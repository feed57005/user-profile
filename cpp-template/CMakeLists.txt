cmake_minimum_required (VERSION 2.8)
include(build/umake/UMakeInit.cmake)

set (CMAKE_CXX_FLAGS "${CMAKE_CXX_FLAGS} -fno-rtti -fno-exceptions -std=c++11")
include_directories(.)

project()
