+++
date = "2018-02-26T11:00:13+01:00"
title = "Development IDEs"
author = "Marc Walther"
weight = 1013
draft = true # This page is outdated

[menu]
  [menu.devguide]
    parent = "development-workflows"
+++

## Overview

Here is a small compilation about **debugging tools** and how to **set them up** to start **developing** OGS. There are several development IDE's available, both open-source or commercial. Some are multi-platform, others are platform-specific.

Here is a **link list** without specific order:

- [Eclipse](https://www.eclipse.org/)
- [Code::Blocks](https://www.codeblocks.org/)
- [Netbeans](https://netbeans.org/)
- [GDB](https://www.sourceware.org/gdb/)
- [CLion](https://www.jetbrains.com/clion/)

The steps to get things started with an IDE basically include **generating** the project files, **importing** them in the IDE and know where to **provide arguments** to the debugging binary.

I will assume, that you have the sources (eg. checked out from github) and that they lie in the **source directory**

```bash
/home/user/ogs6/sources
```

Please, create a separate **build directory** for your favorite IDE like

```bash
/home/user/ogs6/build_gdb
```

__________

## GDB

<https://www.sourceware.org/gdb/download>

![GDB screenshot](../gdb.png)

### Create project files

1. CD to the build directory
2. Generate project files with CMake:

    ```bash
    cmake ../sources/
    ```

3. Start gdb in graphical mode, without license info (quiet) and with arguments:

    ```bash
    gdb -tui -q --args ./bin/ogs ./path/to/BenchmarkName.prj
    ```

4. Have fun...

Documentation: <https://sourceware.org/gdb/onlinedocs/gdb/index.html>

__________

## Eclipse

<https://www.eclipse.org/downloads>

Choose "Eclipse IDE for C/C++ Developers"

![Eclipse screenshot](../eclipse.png)

### Import Code

1. CD to the build directory
2. Generate project files with CMake:

    ```bash
    cmake -G "Eclipse CDT4 - Unix Makefiles" ../sources/
    ```

3. Open Eclipse and choose *File - Import - Existing Project into Workspace*
4. Select the **build directory** and click Finish (***Attention:*** Make sure to **not** check the option *Copy projects into workspace*!)
5. To provide arguments, you will have to run the project once: *Run - Debug* (running will start building first, if not already done).
6. Then, give arguments via *Run - Debug Configuration - C/C++ Application - ogs*. Choose *Arguments* tab on right side and add your arguments to the line *C/C++ Application*, e.g.

    ```bash
    ./path/to/BenchmarkName.prj
    ```

7. Start debugging...

Documentation: <https://wiki.eclipse.org/Main_Page>

__________

## Code::Blocks

<https://www.codeblocks.org/downloads>  
or  
<https://code.google.com/p/fortranproject>

The latter includes already plugins for Fortran, in case you want to cross-compile.

![Code::Blocks screenshot](../codeblocks.png)

### Import Code

1. CD to the build directory
2. Generate project files with CMake:

    ```bash
    cmake -G "CodeBlocks - Unix Makefiles" ../sources/
    ```

3. *Open an existing project* and choose before created .cbp file
4. Choose your compilation target
5. Give arguments: *Project - Set Programs' Arguments*, select correct target and add *Program arguments* in the bottom

    ```bash
    ./path/to/BenchmarkName.prj
    ```

6. Rock the show...

### Documentation

- <https://www.codeblocks.org/user-manual>

__________

## NetBeans

<https://netbeans.apache.org/download/index.html>

![NetBeans screenshot](../netbeans.png)

### Import project files

1. Open NetBeans
2. Choose *File - New Project - C/C++ Project with Existing Sources* (Click *Next >*)
3. Specify sources directory, select configuration mode *Custom*
4. Check *Run Configure Script in Subfolder*
5. Click *Next >* until *Finish*
6. Give arguments via *Run - Set Project Configuration - Customize*
7. Under *Run*, give *Run Command* on right side:

    ```bash
    "${OUTPUT_PATH}" ./path/to/BenchmarkName.prj
    ```

8. When starting debugging, choose correct target
9. Have a great time...

Documentation: <https://netbeans.org/kb/index.html>

__________

## CLion

Download: <https://www.jetbrains.com/clion/>

![Clion screenshot](../clion.png)

### Import project

You don't need a build-directory for CLion. It will create it by itself.

1. *File / Import Project*
2. Choose source-directory
3. When prompted do not overwrite CMake file, instead choose *Open Project*
4. Under *Run / Edit Configurations* choose the ogs-target and set the program working directory and arguments
5. On the top right choose the ogs-target and click the green Debug-button

Documentation: <https://www.jetbrains.com/clion/help/introduction.html>
