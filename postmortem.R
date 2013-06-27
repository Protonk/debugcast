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

warn.default <- getOption("warn")

getOption("warn")

# The current handling "level" for warnings is returned
# this is a little obtuse but explained at ?warnings

# specifically

# the default
getOption("warn")

# Will print warnings to the console at the end of execution

options(warn = 1)

# will print warnings as they go

options(warn = 2)

# will have R treat warnings as errors and then you can handle them
# with the function specified for errors

options(warn = -1)

# Ignores all warnings. 

# return to default

options(warn = warn.default)

# Usually if an established package squashes warnings, there's a reason
# e.g. if it relies on complex models which may produce 
# Inf/-Inf but can deal with those results

### Caveat emptor:
## AFAIK, R doesn't allow us to "protect" options from changing
## So if a package temporarily disables warnings, we can't stop it
## without setting a breakpoint like so

trace(options, exit = function() {
                        options(warn = 2)
                      })
# There's a few things which are interesting here:

# First:
#  trace makes a copy of the function which over-writes
#  the function itself and and previous traces
#  so we won't run into infinite recursion problems 

# Second:
#  options() is written all in C, so there isn't a means to
#  insert ourselves into a specific point in the parse tree
#  and if we want to piggyback on a call to options like
#  options(warn = -1), we need to do so on exit

# Third:
#  .Options seems like a good way around this, but it's 
#  too black-magic, even for R. .Options is copied around
#  dynamically & only some functions reference .Options vs
#  options()

# this is terrible. Let's undo that

untrace(options)
