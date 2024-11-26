#' @title Conduct Correlation Analysis
#' @description 
#' This is a function that conducts correlation tests between one dependent variable and one or more independent variables. 
#' If the explanatory variable is not specified, it will conduct correlation analysis on all numeric variables in the dataset. 
#' The function returns a list of elements, including correlation coefficients, p-values, and the significance levels.
#' @export
#' @param data A data frame
#' @param y The dependent variable
#' @param x The independent variables
#' @returns A list of class `ryx` containing:
#'   - `y` The dependent variable
#'   - `x` The independent variables
#'   - `df` A data frame with columns
#'   - `r` correlation coefficient)
#'   - `p` (p-value)
#'   - `sigif` (significance)
#' @import MASS
#' @examples
#' x <- ryx(Boston, y = "medv")
#' print(x)  # Print results of the correlation analysis
#' summary(x)  # Get a summary of the results
#' plot(x)  # Visualize the correlations

ryx <- function(data, y, x){
  if(missing(x)){
    x <- names(data)[sapply(data, class)=="numeric"]
    x <- setdiff(x, y)
  }
  df <- data.frame()
  for (var in x){
    res <- cor.test(data[[y]], data[[var]])
    df_temp <- data.frame(variable = var, 
                          r = res$estimate, 
                          p = res$p.value)
    df <- rbind(df, df_temp)
    df <- df[order(-abs(df$r)),]
  }
  
  df$sigif <- ifelse(df$p < .001, "***",
                     ifelse(df$p < .01, "**", 
                            ifelse(df$p < .05, "*", " ")))
  results <- list(y=y, x=x, df=df)
  class(results) <- "ryx"
  return(results)
}