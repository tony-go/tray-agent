cmake_minimum_required(VERSION 3.1.0)

project(TrayAgent LANGUAGES OBJC)

set(CMAKE_MACOSX_BUNDLE YES)

add_executable("${PROJECT_NAME}" MACOSX_BUNDLE main.m)

target_link_libraries("${PROJECT_NAME}" "-framework Cocoa")
  
