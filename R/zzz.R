.onLoad <-
    function(libname, pkgname)
{
    ## make DLL available for Windows; others use static library
    if ("windows" == .Platform$OS.type)
        library.dynam("zlib1bioc.dll", pkgname)
}

pkgconfig <-
    function(opt=c("PKG_CFLAGS", "PKG_LIBS_static",
               "PKG_LIBS_shared"))
{
    opt <- match.arg(opt)
    if (nzchar(.Platform$r_arch)) {
        pth <- system.file("libs", .Platform$r_arch, package="zlibbioc",
                           mustWork=TRUE)
        arch <- sprintf("/%s", .Platform$r_arch)
    } else {
        pth <- system.file("usrlib", package="zlibbioc", mustWork=TRUE)
        arch <- ""
    }
    cat(list(PKG_CFLAGS='',
             PKG_LIBS_static=sprintf('"%s%s/libzbioc.a"', pth, arch),
             PKG_LIBS_shared=sprintf(
               '-L"%s%s" -Wl,-rpath,"%s%s" -lzbioc', pth, arch, pth,
               arch))[[opt]])
}
