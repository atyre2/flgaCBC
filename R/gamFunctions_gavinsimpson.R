#############################################
## Functions for derivatives of GAM models ##
## BORROWED FROM GAVIN SIMPSON's GIT AND BLOG
#############################################
## github.com/gavinsimpson/

# get predictions df ----------------------------------------------------------------
#' @export get.pdat
#' @param m:m3 GAMM or GAM models
#' @description GEt predictins for multiple models
#' @param length.out Default 200. HOw many preds to make.
#' @param dat the data frame used to build models
get.pdat <- function(dat, length.out = 200, m, m1, m2, m3) {
    want <- seq(1, nrow(dat), length.out = length.out)
    pdat <- with(dat,
                 data.frame(year = year[want], hours = hours[want]))



    ## predict trend contributions
    p  <- predict(m$gam,
                  newdata = pdat,
                  type = "terms",
                  se.fit = TRUE)
    p1 <- predict(m1$gam,
                  newdata = pdat,
                  type = "terms",
                  se.fit = TRUE)
    p2 <- predict(m2$gam,
                  newdata = pdat,
                  type = "terms",
                  se.fit = TRUE)
    p3 <- predict(m3$gam,
                  newdata = pdat,
                  type = "terms",
                  se.fit = TRUE)

    ## combine with the predictions data, including fitted and SEs
    pdat <- transform(
        pdat,
        p  = p$fit[, 2],
        se  = p$se.fit[, 2],
        p1 = p1$fit[, 2],
        se1 = p1$se.fit[, 2],
        p2 = p2$fit[, 2],
        se2 = p2$se.fit[, 2],
        p3 = p3$fit[, 2],
        se3 = p3$se.fit[, 2]
    )

}


# Get Deriv ---------------------------------------------------------------
#' @export Deriv
Deriv <- function(mod,
                  n = 200,
                  eps = 1e-7,
                  newdata) {
    m.terms <- attr(terms(m2$gam), "term.labels")

    if (isTRUE(all.equal(class(mod), "list")))
        mod <- mod$gam


    if (!exists("newdata")) {
        newD <- sapply(model.frame(m2$gam)[, m.terms, drop = FALSE],
                       function(x)
                           seq(min(x), max(x), length = n))
        names(newD) <- m.terms
    } else {
        newD <- newdata
    }

    X0 <- predict(mod, data.frame(newD), type = "lpmatrix")
    newD <- newD + eps
    X1 <- predict(mod, data.frame(newD), type = "lpmatrix")
    Xp <- (X1 - X0) / eps
    Xp.r <- NROW(Xp)
    Xp.c <- NCOL(Xp)
    ## dims of bs
    bs.dims <- sapply(mod$smooth, "[[", "bs.dim") - 1
    # number of smooth terms
    t.labs <- attr(mod$terms, "term.labels")
    nt <- length(t.labs)
    ## list to hold the derivatives
    lD <- vector(mode = "list", length = nt)
    names(lD) <- t.labs
    for (i in seq_len(nt)) {
        Xi <- Xp * 0
        want <- grep(t.labs[i], colnames(X1))
        Xi[, want] <- Xp[, want]
        df <- Xi %*% coef(mod)
        df.sd <- rowSums(Xi %*% mod$Vp * Xi) ^ .5
        lD[[i]] <- list(deriv = df, se.deriv = df.sd)
        ## Xi <- Xp * 0 ##matrix(0, nrow = Xp.r, ncol = Xp.c)
        ## J <- bs.dims[i]
        ## Xi[,(i-1) * J + 1:J + 1] <- Xp[,(i-1) * J + 1:J +1]
        ## df <- Xi %*% coef(mod)
        ## df.sd <- rowSums(Xi %*% mod$Vp * Xi)^.5
        ## lD[[i]] <- list(deriv = df, se.deriv = df.sd)
    }
    class(lD) <- "Deriv"
    lD$gamModel <- mod
    lD$eps <- eps
    lD$eval <- newD - eps
    return(lD)
}


# conf int ----------------------------------------------------------------
#' @export confint.Deriv
confint.Deriv <- function(object, term, alpha = 0.05, ...) {
    l <- length(object) - 3
    term.labs <- names(object[seq_len(l)])
    if (missing(term))
        term <- term.labs
    Term <- match(term, term.labs)
    ##term <- term[match(term, term.labs)]
    if (any(miss <- is.na(Term)))
        stop(paste("'term'", term[miss], "not a valid model term."))
    ## if(is.na(term))
    ##     stop("'term' not a valid model term.")
    res <- vector(mode = "list", length = length(term))
    names(res) <- term
    residual.df <-
        length(object$gamModel$y) - sum(object$gamModel$edf)
    tVal <- qt(1 - (alpha / 2), residual.df)
    ## tVal <- qt(1 - (alpha/2), object$gamModel$df.residual)
    for (i in seq_along(term)) {
        upr <- object[[term[i]]]$deriv + tVal * object[[term[i]]]$se.deriv
        lwr <-
            object[[term[i]]]$deriv - tVal * object[[term[i]]]$se.deriv
        res[[term[i]]] <- list(upper = drop(upr), lower = drop(lwr))
    }
    res$alpha = alpha
    res
}

# signifD -----------------------------------------------------------------
#' @export signifD
signifD <- function(x, d, upper, lower, eval = 0) {
    miss <- upper > eval & lower < eval
    incr <- decr <- x
    want <- d > eval
    incr[!want | miss] <- NA
    want <- d < eval
    decr[!want | miss] <- NA
    list(incr = incr, decr = decr)
}


# plot derivs -------------------------------------------------------------
#' @export plot.Deriv
plot.Deriv <- function(x,
                       alpha = 0.05,
                       polygon = TRUE,
                       sizer = FALSE,
                       term,
                       eval = 0,
                       lwd = 3,
                       col = "lightgrey",
                       border = col,
                       ylab,
                       xlab,
                       ...) {
    l <- length(x) - 3
    ## get terms and check specified (if any) are in model
    term.labs <- names(x[seq_len(l)])
    if (missing(term))
        term <- term.labs
    Term <- match(term, term.labs)
    if (any(miss <- is.na(Term)))
        stop(paste("'term'", term[miss], "not a valid model term."))
    if (all(is.na(Term)))
        stop("All terms in 'term' not found in model.")
    l <- sum(!miss)
    nplt <- n2mfrow(l)
    ## tVal <- qt(1 - (alpha/2), x$gamModel$df.residual)
    residual.df <- length(x$gamModel$y) - sum(x$gamModel$edf)
    tVal <- qt(1 - (alpha / 2), residual.df)
    if (missing(ylab))
        ylab <- expression(italic(hat(f) * "'" * (x)))
    if (missing(xlab)) {
        xlab <- attr(terms(x$gamModel), "term.labels")[Term]
        names(xlab) <- xlab
    }
    layout(matrix(seq_len(l), nrow = nplt[1], ncol = nplt[2]))
    CI <- confint(x, term = term, alpha = alpha)


    for (i in seq_along(term)) {
        ## for(i in seq_len(l)) {
        upr <- CI[[term[i]]]$upper
        lwr <- CI[[term[i]]]$lower
        ylim <- range(upr, lwr)
        plot(
            x$eval[, term[i]],
            x[[term[i]]]$deriv,
            type = "n",
            ylim = ylim,
            ylab = ylab,
            xlab = xlab[term[i]],
            ...
        )
        if (isTRUE(polygon)) {
            polygon(c(x$eval[, term[i]], rev(x$eval[, term[i]])),
                    c(upr, rev(lwr)),
                    col = col,
                    border = border)
        } else {
            lines(x$eval[, term[i]], upr, lty = "dashed")
            lines(x$eval[, term[i]], lwr, lty = "dashed")
        }
        abline(h = 0, ...)
        if (isTRUE(sizer)) {
            lines(x$eval[, term[i]], x[[term[i]]]$deriv, lwd = 1)
            S <-
                signifD(x[[term[i]]]$deriv, x[[term[i]]]$deriv, upr, lwr,
                        eval = eval)
            lines(x$eval[, term[i]], S$incr, lwd = lwd, col = "blue")
            lines(x$eval[, term[i]], S$decr, lwd = lwd, col = "red")
        } else {
            lines(x$eval[, term[i]], x[[term[i]]]$deriv, lwd = 2)
        }
    }
    layout(1)
    invisible(x)
}
