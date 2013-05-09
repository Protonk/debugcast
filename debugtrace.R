## debug and trace

# browser is great, but...

# fixed <- function(len) {
#   x <- numeric()
#   for(i in 1:len) {
#     x[i] <- i + runif(1)
#     browser()
#   }
#   return(x)
# }

# Now we have that break in execution in production code 
# Unlike print() or a JavaScript engine's console.log()
# browser() will stop execution and raise the console!

fixed <- function(len) {
  x <- numeric()
  for(i in 1:len) {
    x[i] <- i + runif(1)
  }
  return(x)
}

debug(fixed)

fixed(10)

undebug(fixed)

# If we only want to look once:

debugonce(fixed)

# we can also check to see if we've set the debug flag

isdebugged(fixed)

## That's cool, but...
undebug(fixed)
# sometimes the functions we write are gigantic. 
# this is nominally our reason for manually debugging in most cases

trace(fixed, tracer = browser, at = 2)

# now we've entered the function at the 2nd step
# "step" here is a bit opaque. 
# In order to exactly determine where we want to enter
# we can do: 

as.list(body(fixed))

# [[1]]
# `{`
# 
# [[2]]
# x <- numeric()
# 
# [[3]]
# for (i in 1:len) {
#   x[i] <- i + runif(1)
# }
# 
# [[4]]
# return(x)

# don't bother guessing what your insertion point should be. 
# You'll likely get it wrong.

# trace() serves different functions depending on the passed arguments
# if we only pass in the function we want to trace...

trace(`<-`)

fixed(10)

# trace: x <- numeric()
# trace: x[i] <- i + runif(1)
# trace: x <- `[<-`(`*tmp*`, i, value = 1.27961299289018)
# trace: x[i] <- i + runif(1)
# trace: x <- `[<-`(`*tmp*`, i, value = 2.745730265975)
# trace: x[i] <- i + runif(1)
# trace: x <- `[<-`(`*tmp*`, i, value = 3.8495321678929)
# trace: x[i] <- i + runif(1)
# trace: x <- `[<-`(`*tmp*`, i, value = 4.45552718802355)
# trace: x[i] <- i + runif(1)
# trace: x <- `[<-`(`*tmp*`, i, value = 5.18439966184087)
# trace: x[i] <- i + runif(1)
# trace: x <- `[<-`(`*tmp*`, i, value = 6.99301336007193)
# trace: x[i] <- i + runif(1)
# trace: x <- `[<-`(`*tmp*`, i, value = 7.22802428947762)
# trace: x[i] <- i + runif(1)
# trace: x <- `[<-`(`*tmp*`, i, value = 8.32285486720502)
# trace: x[i] <- i + runif(1)
# trace: x <- `[<-`(`*tmp*`, i, value = 9.0931670491118)
# trace: x[i] <- i + runif(1)
# trace: x <- `[<-`(`*tmp*`, i, value = 10.6346214360092)
# [1]  1.279613  2.745730  3.849532  4.455527  5.184400  6.993013
# [7]  7.228024  8.322855  9.093167 10.634621

untrace(`<-`)

# What happened?

# We traced the assignment function 
# because it is a binary operator, we have to quote it in backticks

# assignment happens very ofter, so it isn't super-informative
# but we can do this to any function

