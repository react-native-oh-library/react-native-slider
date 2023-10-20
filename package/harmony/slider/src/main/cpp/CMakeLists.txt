cmake_minimum_required(VERSION 3.13)
set(CMAKE_VERBOSE_MAKEFILE on)

file(GLOB rnoh_slider_SRC CONFIGURE_DEPENDS *.cpp)
add_library(rnoh_slider SHARED ${rnoh_slider_SRC})
target_include_directories(rnoh_slider PUBLIC ${CMAKE_CURRENT_SOURCE_DIR})
target_link_libraries(rnoh_slider PUBLIC rnoh)