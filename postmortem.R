# Post Mortem debugging

# We may only want to debug when we see an error

# set the options error flag:

options(error = recover)

# This can actually be any expression or function
# recover is nice because we're not jumped in at
# the exact error but anywhere in the stack
# another useful option may be 
# options(error = traceback)

# if we want to unset this we can enter

options(error = NULL)

# Released in R 2.15.1:

getOption("show.error.locations")

# If set to TRUE will return the location of errors
# not just the value


# Notably, R distinguishes between warnings and errors

getOption("warn")

# The current handling "level" for warnings is returned
# this is a little obtuse but explained at ?warnings
# specifically

options(warn = 2)

# will have R treat warnings as errors and then you can handle them
# with the function specified for errors

### Caveat emptor:
## AFAIK, R doesn't allow us to "protect" options from changing
## So if a package temporarily disables warnings, we can't stop it
## without setting a conditional debugger like so

trace(what = "options", tracer = eval(.Options$warn <- 2))

# this is terrible. Let's undo that

untrace(options)

# Usually if an established package squashes warnings, there's a reason
# e.g. if it relies on complex models which may produce 
# Inf/-Inf but can deal with those results


