
median_iqr_str <- function(x, r= 0) {
  # Make a string of the form median (IQR) when passed a numeric vector
  # x is numeric vector
  # r is digits to round to
  if (!is.numeric(x)) {stop("Nonnumeric value in median_iqr_str.")}
  out_str <- paste0(
    format(round(median(x, na.rm =T), r), nsmall = r),
    " (",
    format(round(quantile(x, 0.25, na.rm = T)[[1]], r), nsmall = r),
    "-",
    format(round(quantile(x, 0.75, na.rm = T)[[1]], r), nsmall = r),
    ")"
  )
  return(out_str)

}

prop_str <- function(x, r= 0, confint = TRUE) {
  # Make a string of the form xx% (l95ci-u95ci%) when passed a character or
  # factor vector
  # x is character or factor vector
  # r is digits to round to
  # confint = do you want confidence intervals
  x <- as.factor(x)
  levs <- levels(x)
  out <- list()
  sortvar <- list()
  for (l in 1:length(levs)) {

      n <-  sum(x == levs[[l]], na.rm = T)
      N <-  sum(!is.na(x))

      out[[l]] <- paste0(n,
                         "/",
                         N,
                         " (",
                         format(round((n*100/N), r), nsmall = r),
                         ifelse(confint,
                                paste0("% [",
                                format(round(binom.test(n,N)$conf.int[[1]] * 100, r), nsmall = r),
                                "-",
                                format(round(binom.test(n,N)$conf.int[[2]] * 100, r), nsmall = r),
                                "%])"),
                                "%)"
                         )

    )
      sortvar[[l]] <- n/N
  }
  names(out) <- levs
  out[order(unlist(sortvar), decreasing = T)] -> out

  return(out)

}

prop_str_df <- function(x, r = 0, varname = "Var", confint = TRUE) {
  # Make a dataframe with 3 cols when passed a dataframe
  # cols are variable = varname, levels = {levels of original variable} and
  # value output from prop_str
  # when passed a dataframe
  # x is dataframe
  # r is digits to round to
  # varname is variable name
  # confint = whether or not you want confidence intervals
  out <- as.data.frame(do.call(rbind, prop_str(x, r=r, confint = confint)), stringsAsFactors = F)
  out$V2 <- rownames(out)
  out$V3 <- varname
  out <- out[,c(3,2,1)]
  names(out) <- c("variable", "levels", "value")
  rownames(out) <- NULL
  return(out)
}

median_iqr_str_df <- function(x, r = 0, varname = "Var") {
  # Make a dataframe with 3 cols when passed a dataframe
  # cols are variable = varname, levels = "Median (IQR)" and
  # value output from median_iqr_str
  # when passed a dataframe
  # x is dataframe
  # r is digits to round to
  # varname is variable name
  out <- data.frame(variable = varname, levels = "Median (IQR)", value = median_iqr_str(x, r=r), stringsAsFactors = F)
  rownames(out) <- NULL
  return(out)
}

prop_confint_str <- function(x, r= 0) {
  # Make a string of the form xx% (l95ci-u95ci%) when passed a {1,0} vector
  # x is binary vector
  # r is digits to round to
  n = sum(x == 1, na.rm = T)
  N = sum(!is.na(x))
  out_str <- paste0(
    format(round((n*100/N), r), nsmall = r),
    "% ",
    " (",
    format(round(binom.test(n,N)$conf.int[[1]] * 100, r), nsmall = r),
    "-",
    format(round(binom.test(n,N)$conf.int[[2]] * 100, r), nsmall = r),
    "%)"
  )
  return(out_str)

}




#' Create a pretty table from a dataframe to pass to Kable for rendering
#'
#' Take a dataframe and make a new summary dataframe to pass to Kable for
#' pretty table rendering. The input is assumed to have variables in columns
#' with observations in rows.Numeric variables are by default summarised by median and IQR.
#' Character vectors are assumed to be factors and a summarised as a
#' proportion for each level.
#'
#' @param df dataframe to make into pretty table
#' @param vars_to_char character vector of names of numeric variables that you want to treat as factors
#' @param r numeric, number of digits to round to
#' @param vars_to_specify_rounding named numeric vector c("varname" = m) to hange default rounding for variable varname
#' @param confint boolean, do you want to report confidence intervals?
#'
#' @return A dataframe with three columns:
#' variable: the original column name
#' levels: the levels of a character variable (one row for each) level OR
#' the text "Median (IQR)" for numeric variables
#' value: the proportion of observations for that level OR median (IQR) for
#' numeric variables
#' @export
#'
#' @examples pretty_tbl_df(mtcars)
pretty_tbl_df <- function(df,
                          vars_to_char = NULL,
                          r = 0,
                          vars_to_specify_rounding = NULL,
                          confint = TRUE) {


  if (!is.null(vars_to_char)) {
    df[vars_to_char] <- as.data.frame(lapply(df[vars_to_char], as.character), stringsAsFactors = F)
  }
  if (anyDuplicated(names(vars_to_specify_rounding))) {
    stop("Duplicate var names in vars_to_specify_rounding, cowboy.")
  }
  out <- list()
  for (i in 1:ncol(df)) {
    col.class <- class(df[[i]])
    if (col.class == "factor") {
      df[[i]] <- as.character(df[[i]])
      col.class <- "character"
    }
    if (col.class == "numeric" | col.class == "integer") {
      r1 <- ifelse(any(names(df)[i] %in% names(vars_to_specify_rounding)),
                   vars_to_specify_rounding[names(df)[i]],
                   r)
      out[[i]] <- median_iqr_str_df(df[[i]], r = r1, varname = names(df[i]))
    } else if (col.class == "character") {
      r1 <- ifelse(any(names(df)[i] %in% names(vars_to_specify_rounding)),
                   vars_to_specify_rounding[names(df)[i]],
                   r)
      out[[i]] <- prop_str_df(df[[i]], r = r1, varname = names(df[i]),
                              confint = confint)
    } else {
      stop("Non character, factor, numeric or integer class in pretty_tb_df()")
    }
  }
    out <- do.call(rbind, out)
    return(out)
  }

#' Helper to group variables together in Kable tables
#'
#' Use this as input into kableExtra:pack_rows
#'
#' @param data Table to group vars (usually output from pretty_tb_df)
#' @param varnm Variable to group by
#'
#' @return Named character vector: values are variable names and vector names are number of rows
#' @export
#'
#' @examples
make_kable_rowgroup_string <- function(data, varnm) {
    dplyr::group_by(data, {{ varnm }}, .drop = TRUE) -> data
    dplyr::mutate(data,n_var = dplyr::n()) -> data
    dplyr::ungroup(data) -> data
    dplyr::select(data, {{varnm}}, n_var) -> data
    as.data.frame(data) -> data
    unique(data) -> data
    outstring <- data[,2]
    names(outstring) <- data[,1]
    names(outstring)[outstring == 1 ] <- " "
    return(outstring)
}

#' Helper to reliably round number to specified decimal places
#'
#' @param x Number to round
#' @param k Number of decimal places
#'
#' @return String
#' @export
#'
#' @examples
sp_dc <- function(x, k) {
  trimws(format(round(x, k), nsmall=k))
}
