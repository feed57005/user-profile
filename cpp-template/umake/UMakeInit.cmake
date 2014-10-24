set (CMAKE_MODULE_PATH ${CMAKE_MODULE_PATH} ${CMAKE_SOURCE_DIR}/build/umake/find_modules)
# export cc flags for code tools
set (CMAKE_EXPORT_COMPILE_COMMANDS ON CACHE BOOL "" FORCE)
if (NOT CMAKE_BUILD_TYPE)
  set (CMAKE_BUILD_TYPE Debug CACHE INTERNAL "" FORCE)
endif ()

include (build/umake/UMakePlatformDetect.cmake)
include (build/umake/UMakeMacros.cmake)
include (project_info.cmake)

project (${PROJECT_NAME})
