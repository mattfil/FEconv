# CMakeLists.txt

cmake_minimum_required(VERSION 3.15)
set(CMAKE_Fortran_COMPILER "C:/Program Files (x86)/Intel/oneAPI/compiler/latest/bin/ifort.exe")
enable_language(Fortran)
set(CMAKE_MSVC_DEBUG_INFORMATION_FORMAT "$<$<CONFIG:Debug,RelWithDebInfo>:ProgramDatabase>")
set(CMAKE_Fortran_FLAGS "-libs:static ${CMAKE_FORTRAN_FLAGS}")
set(CMAKE_EXE_LINKER_FLAGS "/stack:10000000 ${CMAKE_EXE_LINKER_FLAGS}")
project(MeshConverter)

# Set source files
set(SOURCES
    source
    source/cuthill_mckee
    source/ansys
    source/patran
    source/unv
    source/mfm
    source/mum
    source/vtu
    source/mphtxt
    source/pmh
    source/flux
    source/freefem
    source/fem_extract
    source/gmsh
    source/main
)

add_subdirectory(basicmod EXCLUDE_FROM_ALL)

set(all_f90_files_list)
foreach(d IN LISTS SOURCES)
    file(GLOB folder_files "${d}/*.f90")
    list(APPEND all_f90_files_list ${folder_files})
endforeach()

# Add the executable or library
add_executable(MeshConverter "${all_f90_files_list}")
target_link_libraries(MeshConverter PRIVATE basicmod)

# Include directories
target_include_directories(MeshConverter PRIVATE basicmod/include)
set_target_properties(MeshConverter PROPERTIES LINKER_LANGUAGE Fortran)

# Compiler settings
if(WIN32)
    if(CMAKE_Fortran_COMPILER_ID MATCHES "Intel")
        # Intel Fortran Compiler flags
        target_compile_options(MeshConverter PRIVATE
            /nologo
            /stand:f15
            /warn:all
            /check:all,noarg_temp_created
            /traceback
        )
    else()
        message(FATAL_ERROR "Unsupported Fortran compiler on Windows. Please adapt the flags.")
    endif()
endif()

return()
# Add a custom target for building the basicmod library
add_custom_target(lib_basicmod
    COMMAND ${CMAKE_MAKE_PROGRAM} -f Makefile.static.ifort.windows -C basicmod
    COMMENT "Building libbasicmod library"
)

# Add dependency so lib_basicmod is built before YourExecutableOrLibrary
add_dependencies(YourExecutableOrLibrary lib_basicmod)

# Add a custom target for cleaning lib_basicmod
add_custom_target(clean_lib_basicmod
    COMMAND ${CMAKE_MAKE_PROGRAM} -f Makefile.static.ifort.windows -C basicmod cleanlib
    COMMENT "Cleaning libbasicmod library"
)

# Add dependency so clean_lib_basicmod is run before clean target
add_dependencies(clean clean_lib_basicmod)

# Optionally, you can install the executable/library
install(TARGETS YourExecutableOrLibrary DESTINATION bin)