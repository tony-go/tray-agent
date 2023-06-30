cmake_minimum_required(VERSION 3.1.0)

project(TrayAgent LANGUAGES OBJC)

set(CMAKE_MACOSX_BUNDLE YES)
  
add_executable("${PROJECT_NAME}" MACOSX_BUNDLE main.m)
set_target_properties("${PROJECT_NAME}" PROPERTIES
  MACOSX_BUNDLE_BUNDLE_NAME "${PROJECT_NAME}"
  MACOSX_BUNDLE_GUI_IDENTIFIER "com.tonygo.trayagent"
  MACOSX_BUNDLE_BUNDLE_VERSION "1.0.0"
  MACOSX_BUNDLE_INFO_PLIST "${CMAKE_CURRENT_SOURCE_DIR}/Info.plist")
target_link_libraries("${PROJECT_NAME}" "-framework Cocoa")

  
