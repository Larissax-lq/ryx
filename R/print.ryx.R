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
  cat("Correlations of", x$y, "with\n")
  
  # Format r-values with 3 decimal places
  x$df$r <- round(x$df$r, 3)
  
  # Format p-values with 2 decimal places, in scientific notation where appropriate
  x$df$p_display <- formatC(x$df$p, digits = 2, format = "e")
  
  # Print the results with formatted r-values and p-values
  print(x$df[, c("variable", "r", "p_display", "sigif")], row.names = FALSE)
}
