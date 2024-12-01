#' @title Summary function for `ryx` Objects
#' @description This function provides a summary of the correlation results stored in a `ryx` object. It calculates and prints key statistics such as the median absolute correlation, the range of correlations, and the number of significant correlations (p-value < 0.05).
#' @export
#' @param object An object of class `ryx`, which is the result of the `ryx` function.
#' @returns This function returns `NULL` but prints the following summary to the console:
#'   - The median absolute correlation value.
#'   - The range of correlation values (minimum and maximum).
#'   - The number of significant correlations (p-value < 0.05) out of the total number of correlations.
#' @examples
#' x <- ryx(Boston, y = "medv")
#' print(x)
#' summary(x)

summary.ryx <- function(object) {
  # Extract the correlation summary dataframe
  cor_summary <- object$df

  # Get absolute values for correlation to calculate median and range
  cor_values <- cor_summary$r

  # Median of absolute correlations
  median_cor <- median(abs(cor_values))

  # Range of correlation values
  cor_range <- range(cor_values)

  # Count of significant correlations (p < 0.05)
  significant_count <- sum(cor_summary$p < 0.05)

  # Print the summary output
  cat("Correlating", object$y, "with", paste(cor_summary$variable, collapse = " "), "\n")
  cat("The median absolute correlation was", round(median_cor, 3),
      "with a range from", round(cor_range[1], 3), "to", round(cor_range[2], 3), "\n")
  cat(significant_count, "out of", nrow(cor_summary),
      "variables were significant at the p < 0.05 level.\n")
}
