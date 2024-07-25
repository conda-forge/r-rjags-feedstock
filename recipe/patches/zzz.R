.onLoad <- function(lib, pkg)
{
    ## Load the rjags wrapper.
    library.dynam("rjags", pkg, lib, local=FALSE)

    ## Set the module directory
    if (is.null(getOption("jags.moddir"))) {
        jags_moddir <- file.path(R.home(), "..", "JAGS", "modules-4")
        options("jags.moddir" = jags_moddir)
    }
    load.module("basemod", quiet=TRUE)
    load.module("bugs", quiet=TRUE)

    ## Set progress bar type
    if (is.null(getOption("jags.pb"))) {
        options("jags.pb"="text")
    }
}

.onAttach <- function(lib, pkg)
{
    packageStartupMessage("Linked to JAGS ",
                          .Call("get_version", PACKAGE="rjags"))
    packageStartupMessage("Loaded modules: ",
                          paste(list.modules(), collapse=","))
}

.onUnload <- function(libpath)
{
    library.dynam.unload("rjags", libpath)
}
