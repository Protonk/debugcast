## Debugging in R

### Introductions to R:

# John Cook on R for programmers (from other languages)
# http://www.johndcook.com/R_language_for_programmers.html

# Patrick Burns's "The R Inferno"
# A bit long, but detailed
# http://www.burns-stat.com/documents/books/the-r-inferno/

# A more basic intro from Burns
# http://www.burns-stat.com/documents/tutorials/impatient-r/


# let's make a dumb function

broken <- function(len) {
  for(i in 1:len) {
    x <- i + runif(1)
  }
  return(x)
}

broken(10)

# Hmmmmm
# That didn't work how we wanted

broken <- function(len) {
  for(i in 1:len) {
    x <- i + runif(1)
    print(x)
  }
  return(x)
}

# We got a lot of output, but it is still a little inscrutable. 

# we can enter in to a given execution context with
# browser()

broken <- function(len) {
  for(i in 1:len) {
    x <- i + runif(1)
    browser()
  }
  return(x)
}

# we see and get access to the REPL

# Called from: broken(10)
# Browse[1]> 

# From here we can work just as we would in the console normally

# ls() returns files in the workspace while in the console, 
# but it is context specific 
# (we can even specify the context if we want)
# typing ls()...

# [1] "i" "len" "x"

# Cool! What do we get?

## The object we created implicitly: "i"
## The object we passed in as an arg: "len"
## The object we created explicitly with `<-`: "x"

# we can advance our browser 
# (not quite a debugger, we'll get there!)
# by typing c in the console. 
# because we entered in a loop, 
# we'll call the browser at each iteration

# That control is a little coarse. We want 2 things:
## The ability to inspect objects
## the ability to step through execution

# For most functions 
# (specifically and importantly including your code)
# n in the console will transition to a step through debugger
# we can inspect line by line, not just each browser call


fixed <- function(len) {
  x <- numeric()
  for(i in 1:len) {
    x[i] <- i + runif(1)
  }
  return(x)
}

fixedBetter <- function(len) {
  return(1:len + runif(len))
}

# one last bit
# just like anything else, we can put the 
# browser in a conditional:

brokenCond <- function(len) {
  for(i in 1:len) {
    x <- i + runif(1)
    if(length(x) < len) {
      browser()
    }
  }
  return(x)
}

# This is great, but we're starting to see the problem...
