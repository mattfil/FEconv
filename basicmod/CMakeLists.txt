cmake_minimum_required(VERSION 3.15)
set(CMAKE_Fortran_COMPILER "C:/Program Files (x86)/Intel/oneAPI/compiler/latest/bin/ifx.exe")
enable_language(Fortran)
project(basicmod)

# Set source files
set(SOURCES
    source
    source/alloc
    source/intel
    source/sourcelib
    source/vtk
    source/xml
    source/xread
)

set(all_f90_files_list)
foreach(d IN LISTS SOURCES)
    file(GLOB folder_files "${d}/*.f90")
    list(APPEND all_f90_files_list ${folder_files})
endforeach()

# Add the executable or library
add_library(basicmod "${all_f90_files_list}")
