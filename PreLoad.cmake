cmake_minimum_required (VERSION 3.13)

message(STATUS "")
message(STATUS "*** PreLoad.cmake setup ***")
message(STATUS "")

if(NOT DEFINED CMAKE_PROFILE)
    if(UNIX)
        set(CMAKE_PROFILE gcc84)
    elseif(WIN32)
        set(CMAKE_PROFILE vc142)
    else()
        message(FATAL_ERROR "unknown platform found !")
    endif()
endif()

# default R location
if(DEFINED R_ROOT)
    set(R_LOCATION_HINT "${R_ROOT}" CACHE INTERNAL "" FORCE)
else()
    # default location
	set(R_LOCATION_HINT "/opt/r" CACHE INTERNAL "" FORCE)
endif()

message(STATUS "CMAKE_PROFILE set to ${CMAKE_PROFILE}")

string(TOUPPER ${CMAKE_PROFILE} CMAKE_PROFILE_UC)

if(NOT DEFINED CMAKE_ARCH)
    #set(CMAKE_ARCH znver1) # epyc arch
    #set(CMAKE_ARCH haswell)
    set(CMAKE_ARCH native)
endif()

set(CMAKE_ARCH "${CMAKE_ARCH}" CACHE INTERNAL "" FORCE)

if (CMAKE_PROFILE_UC STREQUAL "GCC84")

    set(DEVTOOLS_ROOT "/opt/devtools")

	set(CXX_DIALECT         "17"						    CACHE INTERNAL "" FORCE)
    set(CMAKE_C_COMPILER    "${DEVTOOLS_ROOT}/bin/gcc"	    CACHE INTERNAL "" FORCE)
    set(CMAKE_CXX_COMPILER  "${DEVTOOLS_ROOT}/bin/g++"	    CACHE INTERNAL "" FORCE)
    set(LINKER_EXTRA_FLAG   "-fuse-ld=gold"                 CACHE INTERNAL "" FORCE)
    set(PYTHON_LOCATION_HINT "/opt/miniconda/envs/dev/bin"  CACHE INTERNAL "" FORCE)
    set(CONAN_BIN_PATH      "${PYTHON_LOCATION_HINT}"       CACHE INTERNAL "" FORCE)

    set(CONAN_FLAGS ${CONAN_FLAGS} "compiler.version=8.4"       )
    set(CONAN_FLAGS ${CONAN_FLAGS} "cppstd=${CXX_DIALECT}"      )
    set(CONAN_FLAGS ${CONAN_FLAGS} "compiler.libcxx=libstdc++11")
    
    set(CONAN_EXTRA_SETTINGS ${CONAN_FLAGS}                 CACHE INTERNAL "" FORCE)
    
    set(CMAKE_MAKE_PROGRAM	 "${DEVTOOLS_ROOT}/bin/ninja" 	CACHE INTERNAL "" FORCE)
    set(CMAKE_GENERATOR	     "Ninja"                        CACHE INTERNAL "" FORCE)
	set(CONAN_PROFILE        "gcc84"		                CACHE INTERNAL "" FORCE)
    set(MEMORYCHECK_COMMAND "${DEVTOOLS_ROOT}/bin/valgrind" CACHE INTERNAL "" FORCE)

else()
    message(FATAL_ERROR "CMAKE_PROFILE value ${CMAKE_PROFILE} is not supported !")
endif()

# default build type
if(NOT DEFINED CMAKE_CONF)
    set(CMAKE_CONF "Release")
endif()

string(TOUPPER ${CMAKE_CONF} CMAKE_CONF_UC)

if(CMAKE_CONF_UC STREQUAL "DEBUG")
    set(CMAKE_BUILD_TYPE "Debug" CACHE INTERNAL "" FORCE)
elseif(CMAKE_CONF_UC STREQUAL "RELEASE")
    set(CMAKE_BUILD_TYPE "Release" CACHE INTERNAL "" FORCE)
elseif(CMAKE_CONF_UC STREQUAL "PROFILING")
    set(CMAKE_BUILD_TYPE "Profiling" CACHE INTERNAL "" FORCE)
elseif(CMAKE_CONF_UC STREQUAL "SANITIZE")
    set(CMAKE_BUILD_TYPE "Sanitize" CACHE INTERNAL "" FORCE)
else()
    message(FATAL_ERROR "CMAKE_CONF_UC value ${CMAKE_CONF_UC} is not valid !")
endif()

if(NOT DEFINED CONAN_USER)
    set(CONAN_USER "jvermosen" CACHE INTERNAL "" FORCE)
else()
    set(CONAN_USER ${CONAN_USER} CACHE INTERNAL "" FORCE)
endif()

if(NOT DEFINED CONAN_CHANNEL)
    set(CONAN_CHANNEL "stable" CACHE INTERNAL "" FORCE)
else()
    set(CONAN_CHANNEL ${CONAN_CHANNEL} CACHE INTERNAL "" FORCE)
endif()

# default install prefix
set(CMAKE_INSTALL_PREFIX ${CMAKE_SOURCE_DIR} CACHE INTERNAL "" FORCE)
message(STATUS "CMAKE_INSTALL_PREFIX set to ${CMAKE_INSTALL_PREFIX}")

message(STATUS "")
message(STATUS "*** PreLoad.cmake end ***")
message(STATUS "")

