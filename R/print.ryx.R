#' @title Print Method for `ryx` Objects
#' @description This function prints the results of the `ryx` function in a readable and formatted way. It displays the correlation coefficients (`r`), p-values, and significance levels (`sigif`) for each variable correlated with the dependent variable (`y`).
#' @export
#' @param x An object of class `ryx`, which is the result of the `ryx` function.
#' @returns This function prints a table with the following columns:
#'   - `variable`: The name of the independent variable.
#'   - `r`: The correlation coefficient rounded to 3 decimal places.
#'   - `p_display`: The p-value formatted in scientific notation, rounded to 2 decimal places.
#'   - `sigif`: The significance level of the p-value, represented as `"***"`, `"**"`, `"*"`, or `" "` based on p-value thresholds.
#' @examples
#' # Assuming `result` is the result of the `ryx` function:
#' print(result)

print.ryx <- function(x, ...) {
  # Extract the correlation data frame from the ryx object
  cor_df <- x$df

  # Format p-values as scientific notation with < 2e-16 if very small
  cor_df$p_display <- ifelse(cor_df$p < 2e-16, "< 2e-16", formatC(cor_df$p, format = "e", digits = 2))

  # Format correlation coefficients with 3 decimal places
  cor_df$r <- formatC(cor_df$r, format = "f", digits = 3)

  # Print the results in a cleaner table format
  cat("Correlations of", x$y, "with\n")
  print(cor_df[, c("variable", "r", "p_display", "sigif")], row.names = FALSE)
}
