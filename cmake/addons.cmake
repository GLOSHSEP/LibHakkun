function(enable_addons)
    foreach(addon IN LISTS HAKKUN_ADDONS)
        set(ADDON_DIR ${CMAKE_CURRENT_SOURCE_DIR}/sys/addons/${addon})
        if (NOT IS_DIRECTORY ${ADDON_DIR})
            message(FATAL_ERROR "${addon} is not an addon!")
        endif()

        add_subdirectory(${ADDON_DIR})
        target_include_directories(LibHakkun PRIVATE ${ADDON_DIR}/include)
        target_include_directories(${PROJECT_NAME} PRIVATE ${ADDON_DIR}/include)
        target_include_directories(${addon} PRIVATE ${CMAKE_CURRENT_SOURCE_DIR}/sys/hakkun/include)
        target_link_libraries(${PROJECT_NAME} PRIVATE ${addon})

        target_compile_definitions(${PROJECT_NAME} PRIVATE HK_ADDON_${addon})
        target_compile_definitions(${addon} PRIVATE HK_ADDON_${addon})
        target_compile_definitions(LibHakkun PRIVATE HK_ADDON_${addon})
        
        message("Enabled addon ${addon}")
    endforeach()

    foreach(addon IN LISTS HAKKUN_ADDONS)
        foreach(saddon IN LISTS HAKKUN_ADDONS)
            if (NOT saddon STREQUAL addon)
                set(ADDON_DIR ${CMAKE_CURRENT_SOURCE_DIR}/sys/addons/${saddon})
                target_include_directories(${addon} PRIVATE ${ADDON_DIR}/include ${ADDON_DIR}/include/hk)
            endif()
        endforeach()
    endforeach()
endfunction()
