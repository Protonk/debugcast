## Reasoning about Scope in R

# R is lexically scoped and uses function closures to build scopes
# see http://darrenjw.wordpress.com/2011/11/23/lexical-scope-and-function-closures-in-r/
# for some more on that.

## Borrowing examples from that post...

a <- 1
b <- 2
f<-function( x ) {
  a * x + b
}
g<-function( x ) {
  a <- 2
  b <- 1
  f( x ) # remember, a * x + b
}

g( 2 )

## In JS it's similar (whew!)

var a = 1;
var b = 2;

function f( x ) {
  return a * x + b;
}
function g( x ) {
  var a = 2;
  var b = 1;
  return f ( x );
}

g( 2 )

## following along in that post, we can exploit function closures
## to give us what may be the expected outcome

a <- 1
b <- 2
f <- function( a, b ) {
  return( function( x ) {
    a * x + b
  })
}
g <- f( 2, 1 )

g( 2 )

## We can also use the debugging tools to help us reason about scope
## in R.

stuff <- function( x ) {
  len <- length( x )
  {
    y <- 1:10
    z <- sys.status()
    # if we wrap sys.status with print, we'll see another frame
    print(z)
  }
  return(len * y)
}

# we can also see

as.list(body(stuff))

# to see how blocks are useful. 
# Like JS there is no block scope in R
# If there were, we could enter in to a frame created by the block

## So this is all well and good, but what does that mean for debugging?

# Under the hood, scope is managed as environments. 
# in 99% of cases, this is merely an implementation detail
# but since r uses it for variable lookup we want to pay close attention
# and environments in R are treated as first class citizens, which can be weird.
# http://cran.r-project.org/doc/manuals/R-lang.html#Environment-objects

# in the chrome dev tools and firebug we can get access to the scope chain
# and the local variables in it

# with R, there's no distinction. Environments contain variable references
# and a reference to the enclosing scope.

# because they're first class citizens we can manipulate them,
# assign objects in them arbitrarily and
# explicitly reference them or objects inside them from any point.


