# bash_scripts

This project provides a simple analog to the Make build automation tool, implemented using a pair of files: shell_make.sh (analogous to Make) and shmakefile (analogous to Makefile).

## Features
Build Targets: The shell_make.sh script is designed to build targets described in the project description file named shmakefile. 

## Default Target
If no arguments are provided to shell_make.sh, it will build the first target defined in shmakefile.

## Specifying Targets
You can provide a list of target names as arguments to shell_make.sh to build specific targets. The script will inform you of any invalid targets that are not defined in shmakefile.

## Dependency Handling
If a target's name corresponds to a file and that target has dependencies listed in shmakefile, the script will build the target only if any of its dependencies are newer than the target file itself.

## Target Dependencies
Optionally, you can implement target dependencies similar to Make. You can specify which targets depend on others in shmakefile.

## Maximum Targets
The number of targets is limited - (10)


# Usage
To use this simple Makefile analog, follow these steps:

Place your project description in a file named shmakefile. Ensure that it contains the target names and build rules as needed.

Run shell_make.sh without any arguments to build the default target or specify one or more target names as arguments to build specific targets:


./shell_make.sh

or

./shell_make.sh target1 target2 ...

The script will handle building the targets, checking dependencies, and reporting any invalid target names.

