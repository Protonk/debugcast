# Read into source

fixed <- function(len) {
  x <- numeric()
  for(i in 1:len) {
    x[i] <- i + runif(1)
  }
  return(x)
}