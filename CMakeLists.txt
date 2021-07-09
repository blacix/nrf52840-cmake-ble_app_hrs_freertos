# https://github.com/Polidea/cmake-nRF5x
# https://blog.jetbrains.com/clion/2021/04/using-nrf52-with-cmake-connect-sdk/
# https://github.com/zl3one6/nRF52xCLion/blob/master/examples/ble_peripheral/ble_app_hrs/pca10056/s140/armgcc/CMakeLists.txt
# https://devzone.nordicsemi.com/f/nordic-q-a/38301/a-unofficial-tutorial-for-building-nrf52-project-in-clion

cmake_minimum_required (VERSION 3.6)

# CMAKE_SYSTEM_NAME should be set to "Generic" before project
# it is set in nRF5-cmake.cmake
include(nRF5-cmake.cmake)
include(nRF5-libraries.cmake)

set(PROJECT_NAME nrf52840-cmake-ble_app_hrs_freertos)

project ("${PROJECT_NAME}")
# w/o setting the language, linker fails, because the startup file (.S) is not processed
enable_language(CXX ASM)

# TODO toolchain file
set(ARM_TOOLCHAIN_PATH "c:/Program Files (x86)/GNU Tools Arm Embedded/7 2018-q2-update/bin")
set(ARM_TOOLCHAIN_PREFIX arm-none-eabi-)

set(CMAKE_C_COMPILER ${ARM_TOOLCHAIN_PATH}/${ARM_TOOLCHAIN_PREFIX}gcc)
set(CMAKE_CXX_COMPILER ${ARM_TOOLCHAIN_PATH}/${ARM_TOOLCHAIN_PREFIX}g++)
set(CMAKE_ASM_COMPILER ${ARM_TOOLCHAIN_PATH}/${ARM_TOOLCHAIN_PREFIX}gcc)

# set(CMAKE_C_STANDARD 99)
set(CMAKE_CXX_STANDARD 14)
set(CMAKE_CXX_STANDARD_REQUIRED ON)


# configure nRF5 SDK version
# nRF5_SDK_15.3.0_59ac345 comes with softdevice 6.1.1
# nRF5_SDK_16.0.0_98a08e2 comes with softdevice 7.0.1
set(SDK_ROOT ${CMAKE_SOURCE_DIR}/nRF5_SDK_16.0.0_98a08e2)
set(PROJ_DIR "${CMAKE_SOURCE_DIR}")
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


# Includes
list(APPEND APP_INCLUDES
        "${PROJ_DIR}/config")

include_directories(
        # app includes must come first, see makefile, too. otherwise FreeRTOS won't compile
        ${APP_INCLUDES}
        ${NRF5_SDK_INCLUDES}
)


# application sources
list(APPEND APP_SOURCE_FILES
        "${PROJ_DIR}/main.cpp")


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
# Add standard libraries at the very end of the linker input, after all objects
# that may need symbols provided by these libraries.
set(CMAKE_EXE_LINKER_FLAGS "${OPT_FLAGS} -mthumb -mabi=aapcs -L${SDK_ROOT}/modules/nrfx/mdk -T${NRF52_LINKER_SCRIPT} ${CPU_FLAGS} -Wl,--gc-sections --specs=nano.specs ${LIB_FILES}")

add_definitions(
        -DBOARD_PCA10056
        -DCONFIG_GPIO_AS_PINRESET
        -DFLOAT_ABI_HARD
        -DFREERTOS
        -DNRF52840_XXAA
        -DNRF_SD_BLE_API_VERSION=${NRF5_NRF_SD_BLE_API_VERSION}
        -DS140
        -DSOFTDEVICE_PRESENT
        -D__HEAP_SIZE=1024
        -D__STACK_SIZE=2048
)


# binary targer
set(target_name ${PROJECT_NAME})
add_executable(${target_name} ${NRF5_SDK_SOURCE_FILES} ${APP_SOURCE_FILES})
set_target_properties(${target_name} PROPERTIES SUFFIX ".out")
set_target_properties(${target_name} PROPERTIES LINK_FLAGS "-Wl,-Map=${target_name}.map")

add_custom_command(TARGET ${target_name}
        POST_BUILD
        COMMAND ${ARM_TOOLCHAIN_PATH}/arm-none-eabi-size ${target_name}.out
        COMMAND ${ARM_TOOLCHAIN_PATH}/arm-none-eabi-objcopy -O binary ${target_name}.out "${target_name}.bin"
        COMMAND ${ARM_TOOLCHAIN_PATH}/arm-none-eabi-objcopy -O ihex ${target_name}.out "${target_name}.hex"
        COMMENT "post build steps for ${target_name}")


# custom targets
add_custom_target(erase_all
        COMMAND ${NRFJPROG} -f nrf52 --eraseall
)

add_custom_target(flash DEPENDS ${target_name}
        COMMAND ${NRFJPROG} -f nrf52 --program "${target_name}.hex" --sectorerase
        COMMAND ${NRFJPROG} -f nrf52 --reset
)

add_custom_target(flash_softdevice
        COMMAND ${NRFJPROG} -f nrf52 --program ${SDK_ROOT}/components/softdevice/s140/hex/s140_nrf52_${NRF5_SOFT_DEVICE_VERSION}_softdevice.hex --sectorerase
        COMMAND ${NRFJPROG} -f nrf52 --reset
)

# sdk_config tool
set(SDK_CONFIG_FILE  "${PROJ_DIR}/config/sdk_config.h")
set(CMSIS_CONFIG_TOOL "${SDK_ROOT}/external_tools/cmsisconfig/CMSIS_Configuration_Wizard.jar")
add_custom_target(sdk_config
        java -jar ${CMSIS_CONFIG_TOOL} ${SDK_CONFIG_FILE}
)
