+++
date = "2018-02-26T11:00:13+01:00"
title = "Conan"
author = "Lars Bilke"
weight = 1071

[menu]
  [menu.devguide]
    parent = "troubleshooting"
+++

## Something went wrong during CMake run

When CMake is run Conan will download library packages. You can see under `Requirements` in the CMake output from where the packages will be downloaded. Most packages will come `from ogs`:

```bash
$ cmake ../ogs
...
-- Conan executing: conan install . -g cmake -s build_type=Release -s os=Macos -s compiler=apple-clang -s compiler.version=9.0 -s compiler.libcxx=libc++ --build=missing --update
PROJECT: Installing /Users/bilke/code/ogs6/build-n/conanfile.txt
Requirements
    Boost/1.64.0@conan/stable from conan-community
    Eigen3/3.2.9@bilke/stable from ogs
    Qt/5.9.2@osechet/stable from ogs
    Shapelib/1.3.0@bilke/stable from ogs
    VTK/7.1.0@bilke/stable from ogs
    libgeotiff/1.4.2@bilke/stable from ogs
    libtiff/4.0.6@bilke/stable from ogs
    proj/4.9.2@bilke/stable from ogs
    zlib/1.2.11@conan/stable from conan-center
```

You can always delete the Conan cache directory in `$HOME/.conan` to start fresh. This can fix errors.

### ERROR: Invalid setting 'X' is not a valid 'settings.compiler.version' value

In `~/.conan/settings.yml` it is defined which compiler versions are supported by Conan on your machine. Unfortunately (and this is also a bit inconvenient) this file is not updated automatically when upgrading Conan. Three possible ways to fix it:

- add the missing value to the file by yourself
- simply delete the file, Conan will re-create it on the next run (easiest method)
- when upgrading Conan it creates a file `~/.conan/settings.new.yml` or similar which you can just rename to `~/.conan/settings.yml`

See also: <http://docs.conan.io/en/latest/faq/troubleshooting.html#error-invalid-setting>

### ERROR: Error in system requirements

When your `cmake`-run output looks similar to this:

```bash
$ cmake ..
...
Running: sudo -A yum update -y
sudo: no askpass program specified, try setting SUDO_ASKPASS
...
ERROR: Error in system requirements
...
```

Please run `sudo -v` before your `cmake`-command. This will ask you for your password to let Conan install some system packages during the `cmake`-run.

## Something went wrong during building

On Ubuntu always use the system default gcc version! Otherwise if you use a newer compiler
than the default you may end up using incompatible Conan packages. E.g. when you use gcc 6
on Ubuntu 16.04 (where gcc 5 is the default) Conan uses packages which are built on Ubuntu
17.10 (where gcc 6 is the default). Ubuntu 17.10 uses a newer glibc library (2.25) which
is incompatible to the glibc library on Ubuntu 16.04 (2.23).

In this case you would get linker errors with the Conan VTK library:

```bash
error: undefined reference to `getrandom'
.../expat/vtkexpat/lib/xmlparse.c 694
```

If you still want to use your OS / compiler combination you can build the VTK Conan package on your machine. Run this one time:

```bash
cmake . -DOGS_CONAN_BUILD=vtk
```
