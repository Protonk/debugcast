# External Code

## Like all developers, you're the smartest person in the world
## So YOUR code can't have an error, unlike all those
## filthy filthy libraries you have to use

## How do we debug an external library or source file?

# The source file first

source("source.R")

setBreakpoint("source.R", 5)

# /Users/protonk/dev/bocoup/training/debugcast/source.R#5:
# fixed step  3 in <environment: R_GlobalEnv>

# if we call fixed() it is now mapped to that source file

# debug(externalFunctionName)
# may work, but we can always use
# trace(externalFunctionName, tracer = browser)
# without the "at" argument (or with it)

## This is a bit laborious at times. 
## When we inserted browser() we picked a line number
## Can we do this with an external package?

install.packages("truncnorm")
library(truncnorm)

# Now we're stuck! 
# Libraries are (by default on Windows/OS X) installed as binary data
# functions, object and methods are lazily loaded (on every platform)
# for our purposes, this means no source tree
# Canonical reference is http://cran.r-project.org/doc/manuals/R-exts.html

# if we look at the files

list.files(system.file("R", package = "truncnorm"))

# We don't see any R scripts

# R tricks us (helpfully!) if we try to display the function body

rtruncnorm

# function (n, a = -Inf, b = Inf, mean = 0, sd = 1) 
# {
#   if (length(n) > 1) 
#     n <- length(n)
#   if (length(n) > 1) 
#     n <- length(n)
#   else if (!is.numeric(n)) 
#     stop("non-numeric argument n.")
#   .Call("do_rtruncnorm", as.integer(n), a, b, mean, sd)
# }
# <environment: namespace:truncnorm>

# It's not actually displaying the source code. It's displaying the
# parsed representation of the code from a stored parse tree

# we can set R to install packages and keep the displayed source code
# but it is much easier to trace functions and not worry about
# line number conversion for externally supplied packages.

trace("rtruncnorm")

# If the function name conflicts with another package, 
# you may have to specify the namespace

# we can specify the same arguments here was we would tracing our
# own functions
