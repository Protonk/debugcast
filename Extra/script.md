# Intro

## R for programmers

* John Cook
* R Inferno
* Impatient R

# First steps

## Print is…like…console.log

* print output
* print is a method

## make a broken function

* Print works, but may not tell us our problem
* browser()

### Environments

* R represents the execution context and scope chain in terms of environments
    * lexical scope
    * function and block scope
* we can enter a function or loop at a given point w/ browser()
* ls() shows us what is available in that envir

### Debug

* step to next debug statement
* step through execution
* conditionals (both inside and outside browser)

## but….

### browser() litters code

* We have to remember where we added them
* breaks execution

### debug()

* set on a specific function

### trace 

* can trace a function and perform any function
    * print output, dump frames, etc.
* can specify where in the parse tree we want to enter

## Parse tree

* R stores functions with an internal source tree showing where the parser has to think about something
* as.list(body(whatever))
* we can also see (with body) where the trace function is inserted

## we can trace anything

* trace the assignment function, `<-`
* binary operator

## External code

### "source()"ing

* when we load a file with the source function R parses the code and associates line numbers with steps in the parse tree
* we can then use setBreakpoint() to specifically start debugging at a given line

### packages

* packages are trickier. code isn't loaded as a flat file but an indexed db. So we have to work hard to get line numbers. 
    * show files w/ system.file
* In 90% of the cases it isn't worth it. 
* we can also see the parsed representation of the source code by just typing the function name
* We can trace package functions just like base or user created functions
    * Can specify namespace, too.

## Postmortem

* Sometimes we may only want to debug on an error
* options(error = recover)
    * this can be any expression
    * but recover is nice. 
* unset with the same function
* show error locations in R 2.15.1 and up
* warnings as errors
    * -1, 0, 1, 2
    * show the problem

## IDEs and other packages

### IDEs

* RStudio: nope
* Revolution R: yes
* ESS: Yes

### Packages

* debug
    * requires tcl/tk
    * more flow control








