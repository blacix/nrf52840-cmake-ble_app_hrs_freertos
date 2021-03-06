﻿# https://github.com/Polidea/cmake-nRF5x
# https://blog.jetbrains.com/clion/2021/04/using-nrf52-with-cmake-connect-sdk/
# https://github.com/zl3one6/nRF52xCLion/blob/master/examples/ble_peripheral/ble_app_hrs/pca10056/s140/armgcc/CMakeLists.txt
# https://devzone.nordicsemi.com/f/nordic-q-a/38301/a-unofficial-tutorial-for-building-nrf52-project-in-clion

cmake_minimum_required (VERSION 3.20)

include(cmake/nRF5-cmake.cmake)
include(cmake/nRF5-libraries.cmake)

set(PROJECT_NAME nrf52840-cmake-ble_app_hrs_freertos)


project ("${PROJECT_NAME}")
# w/o setting the language, linker fails, because the startup file (.S) is not processed
enable_language(CXX ASM)

set(CMAKE_CXX_STANDARD 14)
set(CMAKE_CXX_STANDARD_REQUIRED ON)
if(NOT EXISTS ${CMAKE_SOURCE_DIR}/nRF5_SDK)
file(DOWNLOAD https://developer.nordicsemi.com/nRF5_SDK/nRF5_SDK_v16.x.x/nRF5_SDK_16.0.0_98a08e2.zip ${CMAKE_SOURCE_DIR}/nRF5_SDK.zip)
file(ARCHIVE_EXTRACT INPUT ${CMAKE_SOURCE_DIR}/nRF5_SDK.zip
     DESTINATION ${CMAKE_SOURCE_DIR}/nRF5_SDK)
endif()	 

# configure nRF5 SDK version
# nRF5_SDK_15.3.0_59ac345 comes with softdevice 6.1.1
# nRF5_SDK_16.0.0_98a08e2 comes with softdevice 7.0.1
set(SDK_ROOT ${CMAKE_SOURCE_DIR}/nRF5_SDK)
# -DNRF_SD_BLE_API_VERSION must correspond to the major version number of the softdevice in use.
set(NRF5_NRF_SD_BLE_API_VERSION 7)
set(NRF5_SOFT_DEVICE_VERSION "7.0.1")

# add NRF SDK libraries and components
nRF5_addCommon()
nRF5_addSeggerRTT()
nRF5_addAppUART()
nRF5_addBLEGATT(TRUE)
nRF5_addFreeRTOS(1)
nRF5_addBLEPeerManager()
nRF5_addBLEAdvertising()
nRF5_addBLELinkCtxManager()
nRF5_addBLEQWR()
nRF5_addAppButton()
nRF5_addHardfaultHandler()
nRF5_addMutex()
nRF5_addBSP(TRUE FALSE FALSE)
nRF5_addBLEService(ble_bas)
nRF5_addBLEService(ble_dis)
nRF5_addBLEService(ble_hrs)


# application files
set(APP_SOURCES_DIR ${CMAKE_SOURCE_DIR}/src)
# include paths
list(APPEND APP_INCLUDES
        "${APP_SOURCES_DIR}/config")
include_directories(
        # app includes must come first, see makefile, too. otherwise FreeRTOS won't compile
        ${APP_INCLUDES}
        ${NRF5_SDK_INCLUDES}
)
# application sources
list(APPEND APP_SOURCE_FILES
        "${APP_SOURCES_DIR}/main.cpp")


# linker script file
set(NRF52_LINKER_SCRIPT ${CMAKE_CURRENT_SOURCE_DIR}/project/pca10056/s140/armgcc/ble_app_hrs_freertos_gcc_nrf52.ld)

# build options
set(CPU_FLAGS "-mcpu=cortex-m4 -mfloat-abi=hard -mfpu=fpv4-sp-d16")
set(OPT_FLAGS "-O3 -g3")
set(COMMON_FLAGS "-mthumb -mabi=aapcs -Wall -Werror -ffunction-sections -fdata-sections -fno-strict-aliasing -fno-builtin -fshort-enums")
set(ASM_FLAGS "-g3 -mthumb -mabi=aapcs ${CPU_FLAGS}")

# required standard libs
set(LIB_FILES "-lc -lnosys -lm")

# configure compiler
set(CMAKE_C_FLAGS "${COMMON_FLAGS} ${CPU_FLAGS} ${OPT_FLAGS}")
set(CMAKE_CXX_FLAGS "${COMMON_FLAGS} ${CPU_FLAGS} ${OPT_FLAGS}")
set(CMAKE_ASM_FLAGS "${ASM_FLAGS}")
# Comment from Makefile:
# Add standard libraries at the very end of the linker input, after all objects
# that may need symbols provided by these libraries.
set(CMAKE_EXE_LINKER_FLAGS "${OPT_FLAGS} -mthumb -mabi=aapcs -L${SDK_ROOT}/modules/nrfx/mdk -T${NRF52_LINKER_SCRIPT} ${CPU_FLAGS} -Wl,--gc-sections --specs=nano.specs ${LIB_FILES}")

add_definitions(
        -DBOARD_PCA10056
        -DCONFIG_GPIO_AS_PINRESET
        -DFLOAT_ABI_HARD
        -DNRF52840_XXAA
        -DNRF_SD_BLE_API_VERSION=${NRF5_NRF_SD_BLE_API_VERSION}
        -DS140
        -DSOFTDEVICE_PRESENT
        -D__HEAP_SIZE=1024
        -D__STACK_SIZE=2048
)


# binary targer
set(TARGET_NAME ${PROJECT_NAME})
add_executable(${TARGET_NAME} ${NRF5_SDK_SOURCE_FILES} ${APP_SOURCE_FILES})
set_target_properties(${TARGET_NAME} PROPERTIES SUFFIX ".out")
set_target_properties(${TARGET_NAME} PROPERTIES LINK_FLAGS "-Wl,-Map=${TARGET_NAME}.map")

add_custom_command(TARGET ${TARGET_NAME}
        POST_BUILD
        COMMAND ${ARM_TOOLCHAIN_DIR}/arm-none-eabi-size ${TARGET_NAME}.out
        COMMAND ${ARM_TOOLCHAIN_DIR}/arm-none-eabi-objcopy -O binary ${TARGET_NAME}.out "${TARGET_NAME}.bin"
        COMMAND ${ARM_TOOLCHAIN_DIR}/arm-none-eabi-objcopy -O ihex ${TARGET_NAME}.out "${TARGET_NAME}.hex"
        COMMENT "post build steps for ${TARGET_NAME}")


# custom targets
add_custom_target(erase_all
        COMMAND ${NRFJPROG} -f nrf52 --eraseall
)

add_custom_target(flash DEPENDS ${TARGET_NAME}
        COMMAND ${NRFJPROG} -f nrf52 --program "${TARGET_NAME}.hex" --sectorerase
        COMMAND ${NRFJPROG} -f nrf52 --reset
)

add_custom_target(flash_softdevice
        COMMAND ${NRFJPROG} -f nrf52 --program ${SDK_ROOT}/components/softdevice/s140/hex/s140_nrf52_${NRF5_SOFT_DEVICE_VERSION}_softdevice.hex --sectorerase
        COMMAND ${NRFJPROG} -f nrf52 --reset
)

# sdk_config tool
set(SDK_CONFIG_FILE  "${CMAKE_SOURCE_DIR}/config/sdk_config.h")
set(CMSIS_CONFIG_TOOL "${SDK_ROOT}/external_tools/cmsisconfig/CMSIS_Configuration_Wizard.jar")
add_custom_target(sdk_config
        java -jar ${CMSIS_CONFIG_TOOL} ${SDK_CONFIG_FILE}
)
