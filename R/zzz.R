.onLoad <-
    function(libname, pkgname)
{
    ## make DLL available for Windows; others use static library
    if ("windows" == .Platform$OS.type) {
        dll <- file.path(libname, pkgname, "usrlib", .Platform$r_arch,
                         "zlib1bioc.dll")
        dyn.load(dll)
    }
}

pkgconfig <-
    function(opt=c("PKG_CFLAGS", "PKG_LIBS_static",
               "PKG_LIBS_shared"))
{
    opt <- match.arg(opt)
    incl <- system.file("include", package="zlibbioc")
    pth <- system.file("usrlib", package="zlibbioc", mustWork=TRUE)
    if (nzchar(.Platform$r_arch)) {
        arch <- sprintf("/%s", .Platform$r_arch)
    } else {
        arch <- ""
    }
    if ("windows" == .Platform$OS.type) {
        PKG_LIBS_shared <-
            sprintf('-L"%s%s" -lzlib1bioc', pth, arch)
    } else {
        PKG_LIBS_shared <-
            sprintf('-L"%s%s" -Wl,-rpath,"%s%s" -lzbioc', pth, arch,
                    pth, arch)
    }
    cat(list(PKG_CFLAGS=sprintf('-I"%s"', incl),
             PKG_LIBS_static=sprintf('"%s%s/libzbioc.a"', pth, arch),
             PKG_LIBS_shared=PKG_LIBS_shared)[[opt]])
}
