# TODO
# adds what we don't have macro for
# includin MCU specific classes and common libraries

macro(nRF5_addCommon)

    list(APPEND NRF5_SDK_INCLUDES
            "${SDK_ROOT}/modules/nrfx"
            "${SDK_ROOT}/modules/nrfx/mdk"
            "${SDK_ROOT}/modules/nrfx/hal"
            "${SDK_ROOT}/modules/nrfx/drivers/include"
            "${SDK_ROOT}/integration/nrfx"
            #"${SDK_ROOT}/integration/nrfx/legacy"

            "${SDK_ROOT}/components"
            #"${SDK_ROOT}/components/libraries/pwm"
            #"${SDK_ROOT}/components/libraries/low_power_pwm"

            #"${SDK_ROOT}/components/libraries/usbd"
            #"${SDK_ROOT}/components/libraries/usbd/class/audio"
            #"${SDK_ROOT}/components/libraries/usbd/class/cdc"
            #"${SDK_ROOT}/components/libraries/usbd/class/cdc/acm"
            #"${SDK_ROOT}/components/libraries/usbd/class/msc"
            #"${SDK_ROOT}/components/libraries/usbd/class/hid"
            #"${SDK_ROOT}/components/libraries/usbd/class/hid/generic"
            #"${SDK_ROOT}/components/libraries/usbd/class/hid/mouse"
            #"${SDK_ROOT}/components/libraries/usbd/class/hid/kbd"

            "${SDK_ROOT}/components/libraries/mpu"
            #"${SDK_ROOT}/components/libraries/experimental_section_vars"

            #"${SDK_ROOT}/components/libraries/slip"
            "${SDK_ROOT}/components/libraries/delay"
            #"${SDK_ROOT}/components/libraries/csense_drv"

            "${SDK_ROOT}/components/libraries/fstorage"
            "${SDK_ROOT}/components/libraries/bootloader/ble_dfu"

            "${SDK_ROOT}/components/softdevice/s140/headers"
            "${SDK_ROOT}/components/softdevice/s140/headers/nrf52"

            "${SDK_ROOT}/components/ble/ble_services/ble_dfu"

            "${SDK_ROOT}/components/libraries/cli"
            # "${SDK_ROOT}/components/libraries/crc16"
            "${SDK_ROOT}/components/libraries/util"
            "${SDK_ROOT}/components/libraries/csense"
            "${SDK_ROOT}/components/libraries/ecc"
            "${SDK_ROOT}/components/libraries/hci"

            "${SDK_ROOT}/components/libraries/sortlist"
            #"${SDK_ROOT}/components/libraries/spi_mngr"
            "${SDK_ROOT}/components/libraries/led_softblink"
            "${SDK_ROOT}/components/libraries/sdcard"
            "${SDK_ROOT}/components/libraries/sensorsim"
            #"${SDK_ROOT}/components/libraries/gfx"
            "${SDK_ROOT}/components/libraries/stack_guard"
            "${SDK_ROOT}/components/libraries/log/src"

            "${SDK_ROOT}/external/utf_converter"
            )

    list(APPEND NRF5_SDK_SOURCE_FILES
            "${SDK_ROOT}/modules/nrfx/mdk/gcc_startup_nrf52840.S"
            "${SDK_ROOT}/modules/nrfx/mdk/system_nrf52840.c"
            "${SDK_ROOT}/modules/nrfx/drivers/src/nrfx_clock.c"
            # it seems that CMSIS uses legacy drivers
            "${SDK_ROOT}/integration/nrfx/legacy/nrf_drv_clock.c"

            "${SDK_ROOT}/components/libraries/util/app_util_platform.c"
            "${SDK_ROOT}/components/libraries/util/nrf_assert.c"

            "${SDK_ROOT}/components/libraries/fstorage/nrf_fstorage.c"
            "${SDK_ROOT}/components/libraries/fstorage/nrf_fstorage_sd.c"

            "${SDK_ROOT}/components/libraries/experimental_section_vars/nrf_section_iter.c"

            "${SDK_ROOT}/components/libraries/sensorsim/sensorsim.c"

            "${SDK_ROOT}/external/utf_converter/utf.c"
            )

endmacro()

# adds mutex lib
macro(nRF5_addMutex)
    list(APPEND NRF5_SDK_INCLUDES
            "${SDK_ROOT}/components/libraries/mutex"
            )

endmacro()

# adds app error library
macro(nRF5_addAppError)
    nRF5_addLog()
    list(APPEND NRF5_SDK_INCLUDES
            "${SDK_ROOT}/components/libraries/util"
            )

    list(APPEND NRF5_SDK_SOURCE_FILES
            "${SDK_ROOT}/components/libraries/util/app_error.c"
            "${SDK_ROOT}/components/libraries/util/app_error_weak.c"
            )

endmacro()

# adds power management lib
macro(nRF5_addPowerMgmt)
    nRF5_addMutex()

    list(APPEND NRF5_SDK_INCLUDES
            "${SDK_ROOT}/components/libraries/pwr_mgmt"
            )

    list(APPEND NRF5_SDK_SOURCE_FILES
            "${SDK_ROOT}/components/libraries/pwr_mgmt/nrf_pwr_mgmt.c"
            )

endmacro()

# adds balloc lib
macro(nRF5_addBalloc)
    list(APPEND NRF5_SDK_INCLUDES
            "${SDK_ROOT}/components/libraries/balloc"
            )

    list(APPEND NRF5_SDK_SOURCE_FILES
            "${SDK_ROOT}/components/libraries/balloc/nrf_balloc.c"
            )

endmacro()

# adds atomic library
macro(nRF5_addAtomic)
    list(APPEND NRF5_SDK_INCLUDES
            "${SDK_ROOT}/components/libraries/atomic/"
            )

    list(APPEND NRF5_SDK_SOURCE_FILES
            "${SDK_ROOT}/components/libraries/atomic/nrf_atomic.c"
            )
endmacro()

# adds atomic fifo lib
macro(nRF5_addAtomicFIFO)
    list(APPEND NRF5_SDK_INCLUDES
            "${SDK_ROOT}/components/libraries/atomic_fifo"
            )

    list(APPEND NRF5_SDK_SOURCE_FILES
            "${SDK_ROOT}/components/libraries/atomic_fifo/nrf_atfifo.c"
            )

endmacro()

# adds atomic flags lib
macro(nRF5_addAtomicFlags)
    nRF5_addAtomic()
    list(APPEND NRF5_SDK_INCLUDES
            "${SDK_ROOT}/components/libraries/atomic_flags"
            )

    list(APPEND NRF5_SDK_SOURCE_FILES
            "${SDK_ROOT}/components/libraries/atomic_flags/nrf_atflags.c"
            )

endmacro()

# adds memobj lib
macro(nRF5_addMemobj)
    nRF5_addBalloc()

    list(APPEND NRF5_SDK_INCLUDES
            "${SDK_ROOT}/components/libraries/memobj"
            )

    list(APPEND NRF5_SDK_SOURCE_FILES
            "${SDK_ROOT}/components/libraries/memobj/nrf_memobj.c"
            )

endmacro()

macro(nRF5_addStackInfo)
    list(APPEND NRF5_SDK_INCLUDES
            "${SDK_ROOT}/components/libraries/stack_info"
            )
endmacro()

macro(nRF5_addSHA256)
    list(APPEND NRF5_SDK_INCLUDES
            "${SDK_ROOT}/components/libraries/sha256"
            )

    list(APPEND NRF5_SDK_SOURCE_FILES
            "${SDK_ROOT}/components/libraries/sha256/sha256.c"
            )
endmacro()

macro(nRF5_addHWRNG)
    list(APPEND NRF5_SDK_INCLUDES
            "${SDK_ROOT}/modules/nrfx/drivers/include"
            )

    list(APPEND NRF5_SDK_SOURCE_FILES
            "${SDK_ROOT}/modules/nrfx/drivers/src/nrfx_rng.c"
            )
endmacro()

macro(nRF5_addHWRNGLegacy)
    nRF5_addHWRNG()
    list(APPEND NRF5_SDK_INCLUDES
            "${SDK_ROOT}/integration/nrfx/legacy"
            )

    list(APPEND NRF5_SDK_SOURCE_FILES
            "${SDK_ROOT}/integration/nrfx/legacy/nrf_drv_rng.c"
            )
endmacro()

macro(nRF5_addMBEDTLS SDK_CONFIG_INCLUDE_DIR)
    if(TARGET mbedtls)
        return()
    endif()
    set(USE_STATIC_MBEDTLS_LIBRARY 1)
    set(ENABLE_TESTING OFF)
    set(ENABLE_PROGRAMS OFF)
    add_subdirectory("${SDK_ROOT}/external/mbedtls" mbedtls)
    # other targets link mbedcrypto and def needs to be public so only needs defining on this target
    target_compile_definitions(mbedcrypto PUBLIC MBEDTLS_CONFIG_FILE="${SDK_ROOT}/external/nrf_tls/mbedtls/nrf_crypto/config/nrf_crypto_mbedtls_config.h")
    foreach(target mbedtls mbedx509 mbedcrypto)
        target_include_directories(${target} PRIVATE ${SDK_CONFIG_INCLUDE_DIR})
    endforeach()
endmacro()

macro(nRF5_addCryptoCommon)
    list(APPEND NRF5_SDK_SOURCE_FILES
            "${SDK_ROOT}/components/libraries/crypto/nrf_crypto_init.c"
            "${SDK_ROOT}/components/libraries/crypto/nrf_crypto_shared.c"
            )
endmacro()

macro(nRF5_addAES BACKEND)
    nRF5_addCryptoCommon()
    list(APPEND NRF5_SDK_INCLUDES
            "${SDK_ROOT}/components/libraries/crypto"
            # must include all headers
            "${SDK_ROOT}/components/libraries/crypto/backend/cc310"
            "${SDK_ROOT}/components/libraries/crypto/backend/mbedtls"
            )

    list(APPEND NRF5_SDK_SOURCE_FILES
            "${SDK_ROOT}/components/libraries/crypto/backend/${BACKEND}/${BACKEND}_backend_init.c"
            "${SDK_ROOT}/components/libraries/crypto/backend/${BACKEND}/${BACKEND}_backend_aes.c"
            "${SDK_ROOT}/components/libraries/crypto/nrf_crypto_aes_shared.c"
            "${SDK_ROOT}/components/libraries/crypto/nrf_crypto_aes.c"
            )
endmacro()

macro(nRF5_addAEAD BACKEND)
    nRF5_addCryptoCommon()
    list(APPEND NRF5_SDK_INCLUDES
            "${SDK_ROOT}/components/libraries/crypto"
            # must include all headers
            "${SDK_ROOT}/components/libraries/crypto/backend/cc310"
            "${SDK_ROOT}/components/libraries/crypto/backend/cifra"
            "${SDK_ROOT}/components/libraries/crypto/backend/mbedtls"
            "${SDK_ROOT}/components/libraries/crypto/backend/oberon"
            )

    list(APPEND NRF5_SDK_SOURCE_FILES
            "${SDK_ROOT}/components/libraries/crypto/backend/${BACKEND}/${BACKEND}_backend_init.c"
            "${SDK_ROOT}/components/libraries/crypto/backend/${BACKEND}/${BACKEND}_backend_aes_aead.c"
            "${SDK_ROOT}/components/libraries/crypto/nrf_crypto_aead.c"
            )
endmacro()

macro(nRF5_addHash BACKEND)
    nRF5_addCryptoCommon()
    list(APPEND NRF5_SDK_INCLUDES
            "${SDK_ROOT}/components/libraries/crypto"
            # must include all headers
            "${SDK_ROOT}/components/libraries/crypto/backend/cc310"
            "${SDK_ROOT}/components/libraries/crypto/backend/mbedtls"
            "${SDK_ROOT}/components/libraries/crypto/backend/oberon"
            "${SDK_ROOT}/components/libraries/crypto/backend/cc310_bl"
            "${SDK_ROOT}/components/libraries/crypto/backend/nrf_sw"
            )

    list(APPEND NRF5_SDK_SOURCE_FILES
            "${SDK_ROOT}/components/libraries/crypto/backend/${BACKEND}/${BACKEND}_backend_init.c"
            "${SDK_ROOT}/components/libraries/crypto/backend/${BACKEND}/${BACKEND}_backend_hash.c"
            "${SDK_ROOT}/components/libraries/crypto/nrf_crypto_hash.c"
            )
endmacro()

macro(nRF5_addRNG BACKEND)
    nRF5_addCryptoCommon()
    nRF5_addStackInfo()
    list(APPEND NRF5_SDK_INCLUDES
            "${SDK_ROOT}/components/libraries/crypto"
            # must include all headers
            "${SDK_ROOT}/components/libraries/crypto/backend/cc310"
            "${SDK_ROOT}/components/libraries/crypto/backend/optiga"
            "${SDK_ROOT}/components/libraries/crypto/backend/nrf_hw"
            )

    list(APPEND NRF5_SDK_SOURCE_FILES
            "${SDK_ROOT}/components/libraries/crypto/nrf_crypto_rng.c"
            )
    if(${BACKEND} STREQUAL "nrf_hw_mbedtls")
        list(APPEND NRF5_SDK_SOURCE_FILES
                "${SDK_ROOT}/components/libraries/crypto/backend/nrf_hw/nrf_hw_backend_rng_mbedtls.c"
                "${SDK_ROOT}/components/libraries/crypto/backend/nrf_hw/nrf_hw_backend_init.c"
                )
    else()
        list(APPEND NRF5_SDK_SOURCE_FILES
                "${SDK_ROOT}/components/libraries/crypto/backend/${BACKEND}/${BACKEND}_backend_rng.c"
                )
    endif()
endmacro()

macro(nRF5_addHMAC BACKEND)
    nRF5_addCryptoCommon()
    list(APPEND NRF5_SDK_INCLUDES
            "${SDK_ROOT}/components/libraries/crypto"
            # must include all headers
            "${SDK_ROOT}/components/libraries/crypto/backend/cc310"
            "${SDK_ROOT}/components/libraries/crypto/backend/mbedtls"
            "${SDK_ROOT}/components/libraries/crypto/backend/oberon"
            )

    list(APPEND NRF5_SDK_SOURCE_FILES
            "${SDK_ROOT}/components/libraries/crypto/backend/${BACKEND}/${BACKEND}_backend_init.c"
            "${SDK_ROOT}/components/libraries/crypto/backend/${BACKEND}/${BACKEND}_backend_hmac.c"
            "${SDK_ROOT}/components/libraries/crypto/nrf_crypto_hmac.c"
            )
endmacro()

# adds dynamic memory manager
macro(nRF5_addMemManager)
    list(APPEND NRF5_SDK_INCLUDES
            "${SDK_ROOT}/components/libraries/mem_manager"
            )

    list(APPEND NRF5_SDK_SOURCE_FILES
            "${SDK_ROOT}/components/libraries/mem_manager/mem_manager.c"
            )

endmacro()

# adds app-level FDS (flash data storage) library
macro(nRF5_addFDS)
    nRF5_addAtomicFIFO()

    list(APPEND NRF5_SDK_INCLUDES
            "${SDK_ROOT}/components/libraries/fds"
            "${SDK_ROOT}/components/libraries/fstorage"
            "${SDK_ROOT}/components/libraries/experimental_section_vars"
            )

    list(APPEND NRF5_SDK_SOURCE_FILES
            "${SDK_ROOT}/components/libraries/fds/fds.c"
            "${SDK_ROOT}/components/libraries/fstorage/nrf_fstorage.c"
            "${SDK_ROOT}/components/libraries/fstorage/nrf_fstorage_sd.c"
            "${SDK_ROOT}/components/libraries/fstorage/nrf_fstorage_nvmc.c"
            )
endmacro()

# adds svc library
macro(nRF5_addSVC)
    list(APPEND NRF5_SDK_INCLUDES
            "${SDK_ROOT}/components/libraries/svc"
            )

    list(APPEND NRF5_SDK_SOURCE_FILES
            "${SDK_ROOT}/components/libraries/svc/nrf_svc_handler.c"
            )
endmacro()

macro(nRF5_addCRC32)
    list(APPEND NRF5_SDK_INCLUDES
            "${SDK_ROOT}/components/libraries/crc32"
            )

    list(APPEND NRF5_SDK_SOURCE_FILES
            "${SDK_ROOT}/components/libraries/crc32/crc32.c"
            )
endmacro()

# adds dfu buttonless bootloader libs
macro(nRF5_addBootloaderButtonlessLibs)
    nRF5_addSVC()
    list(APPEND NRF5_SDK_INCLUDES
            "${SDK_ROOT}/components/libraries/bootloader"
            "${SDK_ROOT}/components/libraries/bootloader/dfu"
            "${SDK_ROOT}/components/libraries/bootloader/ble_dfu"
            )

    list(APPEND NRF5_SDK_SOURCE_FILES
            "${SDK_ROOT}/components/libraries/bootloader/nrf_bootloader_info.c"
            "${SDK_ROOT}/components/libraries/bootloader/dfu/nrf_dfu_svci.c"
            )
endmacro()

macro(nRF5_addBootloaderSettings)
    nRF5_addCRC32()
    list(APPEND NRF5_SDK_INCLUDES
            "${SDK_ROOT}/components/libraries/bootloader/dfu"
            )

    list(APPEND NRF5_SDK_SOURCE_FILES
            "${SDK_ROOT}/components/libraries/bootloader/dfu/nrf_dfu_settings.c"
            )
endmacro()

# adds hardfault handler library
macro(nRF5_addHardfaultHandler)
    list(APPEND NRF5_SDK_INCLUDES
            "${SDK_ROOT}/components/libraries/hardfault"
            )

    list(APPEND NRF5_SDK_SOURCE_FILES
            "${SDK_ROOT}/components/libraries/hardfault/hardfault_implementation.c"
            "${SDK_ROOT}/components/libraries/hardfault/nrf52/handler/hardfault_handler_gcc.c"
            )
endmacro()

# adds ring buffer library
macro(nRF5_addRingBuf)
    nRF5_addAtomic()
    list(APPEND NRF5_SDK_INCLUDES
            "${SDK_ROOT}/components/libraries/ringbuf"
            )

    list(APPEND NRF5_SDK_SOURCE_FILES
            "${SDK_ROOT}/components/libraries/ringbuf/nrf_ringbuf.c"
            )
endmacro()

# adds strerror library
macro(nRF5_addStrError)
    list(APPEND NRF5_SDK_INCLUDES
            "${SDK_ROOT}/components/libraries/strerror"
            )

    list(APPEND NRF5_SDK_SOURCE_FILES
            "${SDK_ROOT}/components/libraries/strerror/nrf_strerror.c"
            )
endmacro()

macro(nRF5_addSeggerRTT)
    list(APPEND NRF5_SDK_INCLUDES
            "${SDK_ROOT}/external/segger_rtt"
            )

    list(APPEND NRF5_SDK_SOURCE_FILES
            "${SDK_ROOT}/external/segger_rtt/SEGGER_RTT.c"
            )
endmacro()

# adds log library
macro(nRF5_addLog)
    nRF5_addRingBuf()
    nRF5_addMemobj()
    nRF5_addStrError()

    list(APPEND NRF5_SDK_INCLUDES
            "${SDK_ROOT}/external/fprintf"
            "${SDK_ROOT}/components/libraries/log"
            "${SDK_ROOT}/components/libraries/log/include"
            )

    list(APPEND NRF5_SDK_SOURCE_FILES
            "${SDK_ROOT}/external/fprintf/nrf_fprintf.c"
            "${SDK_ROOT}/external/fprintf/nrf_fprintf_format.c"
            "${SDK_ROOT}/components/libraries/log/src/nrf_log_str_formatter.c"
            "${SDK_ROOT}/components/libraries/log/src/nrf_log_frontend.c"
            "${SDK_ROOT}/components/libraries/log/src/nrf_log_default_backends.c"
            "${SDK_ROOT}/components/libraries/log/src/nrf_log_backend_flash.c"
            "${SDK_ROOT}/components/libraries/log/src/nrf_log_backend_rtt.c"
            "${SDK_ROOT}/components/libraries/log/src/nrf_log_backend_serial.c"
            "${SDK_ROOT}/components/libraries/log/src/nrf_log_backend_uart.c"
            )
endmacro()

# adds aSAADC driver
macro(nRF5_addSAADC)
    list(APPEND NRF5_SDK_INCLUDES
            "${SDK_ROOT}/modules/nrfx/drivers/include"
            )

    list(APPEND NRF5_SDK_SOURCE_FILES
            "${SDK_ROOT}/modules/nrfx/drivers/src/nrfx_saadc.c"
            )
endmacro()

# adds PPI driver
macro(nRF5_addPPI)
    list(APPEND NRF5_SDK_INCLUDES
            "${SDK_ROOT}/modules/nrfx/drivers/include"
            )

    list(APPEND NRF5_SDK_SOURCE_FILES
            "${SDK_ROOT}/modules/nrfx/drivers/src/nrfx_ppi.c"
            )
endmacro()

# adds timer driver
macro(nRF5_addTimer)
    list(APPEND NRF5_SDK_INCLUDES
            "${SDK_ROOT}/modules/nrfx/drivers/include"
            )

    list(APPEND NRF5_SDK_SOURCE_FILES
            "${SDK_ROOT}/modules/nrfx/drivers/src/nrfx_timer.c"
            )
endmacro()

# adds gpiote driver
macro(nRF5_addGPIOTE)
    list(APPEND NRF5_SDK_INCLUDES
            "${SDK_ROOT}/modules/nrfx/drivers/include"
            )

    list(APPEND NRF5_SDK_SOURCE_FILES
            "${SDK_ROOT}/modules/nrfx/drivers/src/nrfx_gpiote.c"
            )
endmacro()

# adds rtc driver
macro(nRF5_addRTC)
    list(APPEND NRF5_SDK_INCLUDES
            "${SDK_ROOT}/modules/nrfx/drivers/include"
            )

    list(APPEND NRF5_SDK_SOURCE_FILES
            "${SDK_ROOT}/modules/nrfx/drivers/src/nrfx_rtc.c"
            )
endmacro()

# adds peripheral resource sharing driver
macro(nRF5_addPRS)
    list(APPEND NRF5_SDK_INCLUDES
            "${SDK_ROOT}/modules/nrfx/drivers/src/prs"
            )

    list(APPEND NRF5_SDK_SOURCE_FILES
            "${SDK_ROOT}/modules/nrfx/drivers/src/prs/nrfx_prs.c"
            )
endmacro()

# adds uart driver
macro(nRF5_addUART)
    nRF5_addPRS()
    list(APPEND NRF5_SDK_INCLUDES
            "${SDK_ROOT}/modules/nrfx/drivers/include"
            )

    list(APPEND NRF5_SDK_SOURCE_FILES
            "${SDK_ROOT}/modules/nrfx/drivers/src/nrfx_uart.c"
            "${SDK_ROOT}/modules/nrfx/drivers/src/nrfx_uarte.c"
            )
endmacro()

# adds legacy uart driver
macro(nRF5_addLegacyUART)
    nRF5_addUART()
    list(APPEND NRF5_SDK_INCLUDES
            "${SDK_ROOT}/integration/nrfx/legacy"
            )

    list(APPEND NRF5_SDK_SOURCE_FILES
            "${SDK_ROOT}/integration/nrfx/legacy/nrf_drv_uart.c"
            )
endmacro()

# adds serial library
macro(nRF5_addSerial)
    #nRF5_addLegacyUART()
    nRF5_addUART()
    nRF5_addMutex()
    nRF5_addQueue()
    nRF5_addAppTimer()
    list(APPEND NRF5_SDK_INCLUDES
            "${SDK_ROOT}/components/libraries/serial"
            )

    list(APPEND NRF5_SDK_SOURCE_FILES
            "${SDK_ROOT}/components/libraries/serial/nrf_serial.c"
            )
endmacro()

macro(nRF5_addLibuarteDrv)
    nRF5_addUART()
    nRF5_addGPIOTE()
    nRF5_addPRS()
    nRF5_addPPI()
    nRF5_addTimer()
    list(APPEND NRF5_SDK_INCLUDES
            "${SDK_ROOT}/components/libraries/libuarte"
            )

    list(APPEND NRF5_SDK_SOURCE_FILES
            "${SDK_ROOT}/components/libraries/libuarte/nrf_libuarte_drv.c"
            )
endmacro()

macro(nRF5_addLibuarteAsync)
    nRF5_addLibuarteDrv()
    nRF5_addBalloc()
    nRF5_addQueue()
    nRF5_addRTC()

    list(APPEND NRF5_SDK_SOURCE_FILES
            "${SDK_ROOT}/components/libraries/libuarte/nrf_libuarte_async.c"
            )
endmacro()

# adds timer driver
macro(nRF5_addTimer)
    list(APPEND NRF5_SDK_INCLUDES
            "${SDK_ROOT}/modules/nrfx/drivers/include"
            )

    list(APPEND NRF5_SDK_SOURCE_FILES
            "${SDK_ROOT}/modules/nrfx/drivers/src/nrfx_timer.c"
            )
endmacro()

# adds nvmc HAL
macro(nRF5_addNVMC)
    list(APPEND NRF5_SDK_INCLUDES
            "${SDK_ROOT}/modules/nrfx/hal"
            )

    list(APPEND NRF5_SDK_SOURCE_FILES
            "${SDK_ROOT}/modules/nrfx/hal/nrf_nvmc.c"
            )
endmacro()

# adds queue library
macro(nRF5_addQueue)
    list(APPEND NRF5_SDK_INCLUDES
            "${SDK_ROOT}/components/libraries/queue"
            )

    list(APPEND NRF5_SDK_SOURCE_FILES
            "${SDK_ROOT}/components/libraries/queue/nrf_queue.c"
            )
endmacro()

# adds app-level scheduler library
macro(nRF5_addAppScheduler)
    list(APPEND NRF5_SDK_INCLUDES
            "${SDK_ROOT}/components/libraries/scheduler"
            )

    list(APPEND NRF5_SDK_SOURCE_FILES
            "${SDK_ROOT}/components/libraries/scheduler/app_scheduler.c"
            )

endmacro()

# adds app-level FIFO libraries
macro(nRF5_addAppFIFO)
    list(APPEND NRF5_SDK_INCLUDES
            "${SDK_ROOT}/components/libraries/fifo"
            )

    list(APPEND NRF5_SDK_SOURCE_FILES
            "${SDK_ROOT}/components/libraries/fifo/app_fifo.c"
            )

endmacro()

# adds app-level Timer libraries
macro(nRF5_addAppTimerInclude)
    list(APPEND NRF5_SDK_INCLUDES
            "${SDK_ROOT}/components/libraries/timer"
            )
endmacro()

macro(nRF5_addAppTimer)
    nRF5_addAppTimerInclude()
    list(APPEND NRF5_SDK_SOURCE_FILES
            "${SDK_ROOT}/components/libraries/timer/app_timer.c"
            )
endmacro()

macro(nRF5_addAppTimerFreeRTOS)
    nRF5_addAppTimerInclude()
    list(APPEND NRF5_SDK_SOURCE_FILES
            "${SDK_ROOT}/components/libraries/timer/app_timer_freertos.c"
            )
endmacro()

macro(nRF5_addFreeRTOS RTOS_HEAP_VERSION)
    nRF5_addAppTimerFreeRTOS()
    list(APPEND NRF5_SDK_INCLUDES
            "${SDK_ROOT}/external/freertos/config"
            "${SDK_ROOT}/external/freertos/portable/GCC/nrf52"
            "${SDK_ROOT}/external/freertos/portable/CMSIS/nrf52"
            "${SDK_ROOT}/external/freertos/source/include"
            "${SDK_ROOT}/components/toolchain/cmsis/include"

            )

    list(APPEND NRF5_SDK_SOURCE_FILES
            #freertos
            "${SDK_ROOT}/external/freertos/source/croutine.c"
            "${SDK_ROOT}/external/freertos/source/event_groups.c"
            "${SDK_ROOT}/external/freertos/source/portable/MemMang/heap_${RTOS_HEAP_VERSION}.c"
            "${SDK_ROOT}/external/freertos/source/list.c"
            "${SDK_ROOT}/external/freertos/portable/GCC/nrf52/port.c"
            "${SDK_ROOT}/external/freertos/portable/CMSIS/nrf52/port_cmsis.c"
            "${SDK_ROOT}/external/freertos/portable/CMSIS/nrf52/port_cmsis_systick.c"
            "${SDK_ROOT}/external/freertos/source/queue.c"
            "${SDK_ROOT}/external/freertos/source/stream_buffer.c"
            "${SDK_ROOT}/external/freertos/source/tasks.c"
            "${SDK_ROOT}/external/freertos/source/timers.c"
            # see TODO at soft device support
            "${SDK_ROOT}/components/softdevice/common/nrf_sdh_freertos.c"
            )

    add_definitions(-DFREERTOS)

endmacro()

# adds app UART library
macro(nRF5_addAppUART)
    nRF5_addLegacyUART()
    list(APPEND NRF5_SDK_INCLUDES
            "${SDK_ROOT}/components/libraries/uart"
            )

    list(APPEND NRF5_SDK_SOURCE_FILES
            "${SDK_ROOT}/components/libraries/uart/app_uart_fifo.c"
            )

endmacro()

# adds app-level Button library
macro(nRF5_addAppButton)
    nRF5_addGPIOTE()
    list(APPEND NRF5_SDK_INCLUDES
            "${SDK_ROOT}/components/libraries/button"
            )

    list(APPEND NRF5_SDK_SOURCE_FILES
            "${SDK_ROOT}/components/libraries/button/app_button.c"
            )

endmacro()

# adds BSP (board support package) library
macro(nRF5_addBSP WITH_BLE_BTN WITH_ANT_BTN WITH_NFC)
    list(APPEND NRF5_SDK_INCLUDES
            "${SDK_ROOT}/components/boards"
            "${SDK_ROOT}/components/libraries/bsp"
            )

    list(APPEND NRF5_SDK_SOURCE_FILES
            "${SDK_ROOT}/components/boards/boards.c"
            "${SDK_ROOT}/components/libraries/bsp/bsp.c"
            )

    if (${WITH_BLE_BTN})
        list(APPEND NRF5_SDK_SOURCE_FILES
                "${SDK_ROOT}/components/libraries/bsp/bsp_btn_ble.c"
                )
    endif ()

    if (${WITH_ANT_BTN})
        list(APPEND NRF5_SDK_SOURCE_FILES
                "${SDK_ROOT}/components/libraries/bsp/bsp_btn_ant.c"
                )
    endif ()

    if (${WITH_NFC})
        list(APPEND NRF5_SDK_SOURCE_FILES
                "${SDK_ROOT}/components/libraries/bsp/bsp_nfc.c"
                )
    endif ()

endmacro()

macro(nRF5_addSoftDeviceSupport)
    nRF5_addMemobj()
    nRF5_addStrError()
    nRF5_addAppError()
    nRF5_addAtomicFlags()

    list(APPEND NRF5_SDK_INCLUDES
            "${SDK_ROOT}/components/ble/common"
            "${SDK_ROOT}/components/softdevice/common"
            )

    list(APPEND NRF5_SDK_SOURCE_FILES
            "${SDK_ROOT}/components/libraries/util/app_util_platform.c"
            "${SDK_ROOT}/components/libraries/experimental_section_vars/nrf_section_iter.c"
            "${SDK_ROOT}/components/softdevice/common/nrf_sdh_soc.c"
            "${SDK_ROOT}/components/softdevice/common/nrf_sdh_ble.c"
            # see freertos
            "${SDK_ROOT}/components/softdevice/common/nrf_sdh.c"
            "${SDK_ROOT}/components/ble/common/ble_conn_state.c"
            "${SDK_ROOT}/components/ble/common/ble_conn_params.c"
            "${SDK_ROOT}/components/ble/common/ble_advdata.c"
            "${SDK_ROOT}/components/ble/common/ble_srv_common.c"
            )

    # TODO ?
#    if(${WITH_FREERTOS})
#        list(APPEND NRF5_SDK_SOURCE_FILES
#                "${SDK_ROOT}/components/softdevice/common/nrf_sdh_freertos.c")
#    else()
#        list(APPEND NRF5_SDK_SOURCE_FILES
#                "${SDK_ROOT}/components/softdevice/common/nrf_sdh.c")
#    endif()
endmacro()

# adds Bluetooth Low Energy GATT support library
macro(nRF5_addBLEGATT)
    nRF5_addSoftDeviceSupport()
    list(APPEND NRF5_SDK_INCLUDES
            "${SDK_ROOT}/components/ble/nrf_ble_gatt"
            )

    list(APPEND NRF5_SDK_SOURCE_FILES
            "${SDK_ROOT}/components/ble/nrf_ble_gatt/nrf_ble_gatt.c"
            )
endmacro()

# adds Bluetooth Low Energy advertising support library
macro(nRF5_addBLEAdvertising)
    list(APPEND NRF5_SDK_INCLUDES
            "${SDK_ROOT}/components/ble/ble_advertising"
            )

    list(APPEND NRF5_SDK_SOURCE_FILES
            "${SDK_ROOT}/components/ble/ble_advertising/ble_advertising.c"
            )
endmacro()

# adds Bluetooth Low Energy Queued Write library
macro(nRF5_addBLEQWR)
    list(APPEND NRF5_SDK_INCLUDES
            "${SDK_ROOT}/components/ble/nrf_ble_qwr"
            )

    list(APPEND NRF5_SDK_SOURCE_FILES
            "${SDK_ROOT}/components/ble/nrf_ble_qwr/nrf_ble_qwr.c"
            )
endmacro()

macro(nRF5_addBLELinkCtxManager)
    list(APPEND NRF5_SDK_INCLUDES
            "${SDK_ROOT}/components/ble/ble_link_ctx_manager"
            )

    list(APPEND NRF5_SDK_SOURCE_FILES
            "${SDK_ROOT}/components/ble/ble_link_ctx_manager/ble_link_ctx_manager.c"
            )
endmacro()

# adds Bluetooth Low Energy advertising support library
macro(nRF5_addBLEPeerManager)
    nRF5_addFDS()
    nRF5_addAtomicFlags()

    list(APPEND NRF5_SDK_INCLUDES
            "${SDK_ROOT}/components/ble/peer_manager"
            )

    list(APPEND NRF5_SDK_SOURCE_FILES
            "${SDK_ROOT}/components/ble/peer_manager/auth_status_tracker.c"
            "${SDK_ROOT}/components/ble/peer_manager/gatt_cache_manager.c"
            "${SDK_ROOT}/components/ble/peer_manager/gatts_cache_manager.c"
            "${SDK_ROOT}/components/ble/peer_manager/id_manager.c"
            "${SDK_ROOT}/components/ble/peer_manager/nrf_ble_lesc.c"
            "${SDK_ROOT}/components/ble/peer_manager/peer_data_storage.c"
            "${SDK_ROOT}/components/ble/peer_manager/peer_database.c"
            "${SDK_ROOT}/components/ble/peer_manager/peer_id.c"
            "${SDK_ROOT}/components/ble/peer_manager/peer_manager.c"
            "${SDK_ROOT}/components/ble/peer_manager/peer_manager_handler.c"
            "${SDK_ROOT}/components/ble/peer_manager/pm_buffer.c"
            "${SDK_ROOT}/components/ble/peer_manager/security_dispatcher.c"
            "${SDK_ROOT}/components/ble/peer_manager/security_manager.c"
            )

endmacro()

# adds NFC library
macro(nRF5_addNFC)
    # NFC includes
    list(APPEND NRF5_SDK_INCLUDES
            "${SDK_ROOT}/components/nfc/ndef/conn_hand_parser"
            "${SDK_ROOT}/components/nfc/ndef/conn_hand_parser/ac_rec_parser"
            "${SDK_ROOT}/components/nfc/ndef/conn_hand_parser/ble_oob_advdata_parser"
            "${SDK_ROOT}/components/nfc/ndef/conn_hand_parser/le_oob_rec_parser"
            "${SDK_ROOT}/components/nfc/ndef/connection_handover/ac_rec"
            "${SDK_ROOT}/components/nfc/ndef/connection_handover/ble_oob_advdata"
            "${SDK_ROOT}/components/nfc/ndef/connection_handover/ble_pair_lib"
            "${SDK_ROOT}/components/nfc/ndef/connection_handover/ble_pair_msg"
            "${SDK_ROOT}/components/nfc/ndef/connection_handover/common"
            "${SDK_ROOT}/components/nfc/ndef/connection_handover/ep_oob_rec"
            "${SDK_ROOT}/components/nfc/ndef/connection_handover/hs_rec"
            "${SDK_ROOT}/components/nfc/ndef/connection_handover/le_oob_rec"
            "${SDK_ROOT}/components/nfc/ndef/generic/message"
            "${SDK_ROOT}/components/nfc/ndef/generic/record"
            "${SDK_ROOT}/components/nfc/ndef/launchapp"
            "${SDK_ROOT}/components/nfc/ndef/parser/message"
            "${SDK_ROOT}/components/nfc/ndef/parser/record"
            "${SDK_ROOT}/components/nfc/ndef/text"
            "${SDK_ROOT}/components/nfc/ndef/uri"
            "${SDK_ROOT}/components/nfc/platform"
            "${SDK_ROOT}/components/nfc/t2t_lib"
            "${SDK_ROOT}/components/nfc/t2t_parser"
            "${SDK_ROOT}/components/nfc/t4t_lib"
            "${SDK_ROOT}/components/nfc/t4t_parser/apdu"
            "${SDK_ROOT}/components/nfc/t4t_parser/cc_file"
            "${SDK_ROOT}/components/nfc/t4t_parser/hl_detection_procedure"
            "${SDK_ROOT}/components/nfc/t4t_parser/tlv"
            )

    list(APPEND NRF5_SDK_SOURCE_FILES
            "${SDK_ROOT}/components/nfc/ndef/conn_hand_parser/ac_rec_parser/nfc_ac_rec_parser.c"
            "${SDK_ROOT}/components/nfc/ndef/conn_hand_parser/ble_oob_advdata_parser/nfc_ble_oob_advdata_parser.c"
            "${SDK_ROOT}/components/nfc/ndef/conn_hand_parser/le_oob_rec_parser/nfc_le_oob_rec_parser.c"
            "${SDK_ROOT}/components/nfc/ndef/connection_handover/ac_rec/nfc_ac_rec.c"
            "${SDK_ROOT}/components/nfc/ndef/connection_handover/ble_oob_advdata/nfc_ble_oob_advdata.c"
            "${SDK_ROOT}/components/nfc/ndef/connection_handover/ble_pair_lib/nfc_ble_pair_lib.c"
            "${SDK_ROOT}/components/nfc/ndef/connection_handover/ble_pair_msg/nfc_ble_pair_msg.c"
            # we have old SKD
            # "${SDK_ROOT}/components/nfc/ndef/connection_handover/common/nfc_common.c"
            "${SDK_ROOT}/components/nfc/ndef/connection_handover/common/nfc_ble_pair_common.c"
            "${SDK_ROOT}/components/nfc/ndef/connection_handover/ep_oob_rec/nfc_ep_oob_rec.c"
            "${SDK_ROOT}/components/nfc/ndef/connection_handover/hs_rec/nfc_hs_rec.c"
            "${SDK_ROOT}/components/nfc/ndef/connection_handover/le_oob_rec/nfc_le_oob_rec.c"
            "${SDK_ROOT}/components/nfc/ndef/generic/message/nfc_ndef_msg.c"
            "${SDK_ROOT}/components/nfc/ndef/generic/record/nfc_ndef_record.c"
            "${SDK_ROOT}/components/nfc/ndef/launchapp/nfc_launchapp_msg.c"
            "${SDK_ROOT}/components/nfc/ndef/launchapp/nfc_launchapp_rec.c"
            "${SDK_ROOT}/components/nfc/ndef/parser/message/nfc_ndef_msg_parser.c"
            "${SDK_ROOT}/components/nfc/ndef/parser/message/nfc_ndef_msg_parser_local.c"
            "${SDK_ROOT}/components/nfc/ndef/parser/record/nfc_ndef_record_parser.c"
            "${SDK_ROOT}/components/nfc/ndef/text/nfc_text_rec.c"
            "${SDK_ROOT}/components/nfc/ndef/uri/nfc_uri_msg.c"
            "${SDK_ROOT}/components/nfc/ndef/uri/nfc_uri_rec.c"
            "${SDK_ROOT}/components/nfc/platform/nfc_platform.c"
            "${SDK_ROOT}/components/nfc/t2t_parser/nfc_t2t_parser.c"
            "${SDK_ROOT}/components/nfc/t4t_parser/apdu/nfc_t4t_apdu.c"
            "${SDK_ROOT}/components/nfc/t4t_parser/cc_file/nfc_t4t_cc_file.c"
            "${SDK_ROOT}/components/nfc/t4t_parser/hl_detection_procedure/nfc_t4t_hl_detection_procedures.c"
            "${SDK_ROOT}/components/nfc/t4t_parser/tlv/nfc_t4t_tlv_block.c"
            )
endmacro()

macro(nRF5_addBLEService NAME)
    nRF5_addBLEAdvertising()
    nRF5_addBLELinkCtxManager()
    nRF5_addBLEGATT()

    list(APPEND NRF5_SDK_INCLUDES
            "${SDK_ROOT}/components/ble/ble_services/${NAME}"
            )

    if("${NAME}" STREQUAL "ble_ancs_c")
        list(APPEND NRF5_SDK_SOURCE_FILES
                "${SDK_ROOT}/components/ble/ble_services/${NAME}/nrf_${NAME}.c"
                )
    else()
        list(APPEND NRF5_SDK_SOURCE_FILES
                "${SDK_ROOT}/components/ble/ble_services/${NAME}/${NAME}.c"
                )
    endif()

    if("${NAME}" STREQUAL "ble_dfu")
        list(APPEND NRF5_SDK_SOURCE_FILES
                "${SDK_ROOT}/components/ble/ble_services/${NAME}/${NAME}_bonded.c"
                "${SDK_ROOT}/components/ble/ble_services/${NAME}/${NAME}_unbonded.c"
                )
        nRF5_addBootloaderButtonlessLibs()
        nRF5_addBLEPeerManager()
    endif()
endmacro()
