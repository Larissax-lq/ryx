#' @title Plot function for `ryx` objects
#' @description This function creates a plot to visualize the correlations between the dependent variable (`y`) and independent variables (`x`). The plot shows a series of horizontal lines representing the correlations and colored dots at the end of each line to indicate the direction of the correlation: red for negative and blue for positive. The x-axis represents the absolute value of the correlation coefficient, and the y-axis represents the variables.
#' @export
#' @param x An object of class `ryx`, which is the result of the `ryx` function.
#' @returns This function returns a `ggplot` object that visualizes the following:
#'   - Grey lines indicating the strength of correlation for each variable.
#'   - Colored dots at the end of each line to indicate the correlation direction (red for negative, blue for positive).
#'   - The x-axis represents the absolute value of the correlation coefficient, ranging from 0 to 1.
#'   - The y-axis shows the names of the variables.
#' @import ggplot2
#' @examples
#' x <- ryx(Boston, y = "medv")
#' plot(x)

plot.ryx <- function(x, ...) {
  library(ggplot2)

  # Add a direction column to the data for color coding
  x$df$direction <- ifelse(x$df$r < 0, "negative", "positive")

  ggplot(x$df, aes(y = reorder(variable, abs(r)), x = abs(r))) +
    # Grey line for each variable
    geom_segment(aes(x = 0, xend = abs(r), yend = reorder(variable, abs(r))),
                 color = "grey", size = 0.5) +
    # Red or Blue dot at the end of the line
    geom_point(aes(color = direction), size = 3) +
    scale_color_manual(values = c("positive" = "blue", "negative" = "red"),
                       name = "Direction") +  # Add the legend title here
    # Set the x-axis limits and labels, with grid lines at specific intervals
    scale_x_continuous(
      name = "Correlation (absolute value)",
      limits = c(0, 1),
      breaks = seq(0, 1, 0.1)  # This sets the breaks for the x-axis
    ) +
    # Adding the title, minimal theme, and labels
    theme_minimal() +
    labs(title = paste("Correlations of", x$y), y = "Variables") +
    # Customize the background with vertical dashed lines
    theme(
      legend.title = element_text(),  # Regular legend title
      panel.grid.major.x = element_blank(),  # Remove vertical grid lines
      panel.grid.minor.x = element_blank(),  # Remove minor vertical grid lines
      panel.grid.major.y = element_blank(),  # Remove horizontal grid lines
      panel.border = element_rect(color = "black", fill = NA, size = 0.5)  # Add a border around the plot

    ) +
    # Add vertical dashed lines at specific breaks
    geom_vline(xintercept = seq(0, 1, by = 0.1), linetype = "dashed", color = "grey", size = 0.1)
}

