cmake_minimum_required(VERSION 3.6)

# find programs
find_program(NRFJPROG nrfjprog DOC "Path to the `nrfjprog` command line executable")
find_program(NRFUTIL nrfutil DOC "Path to the `nrfutil` command line executable")
if(${CMAKE_HOST_SYSTEM_NAME} STREQUAL "Windows")
    find_program(JLINK JLink DOC "Path to `JLink.exe` command line executable")
    find_program(JLINKGDBSERVER JLinkGDBServerCL DOC "Path to `JLinkGDBServerCL.exe` command line executable")
    find_program(JLINKRTTCLIENT JLinkRTTClient DOC "Path to `JLinkRTTClient.exe` command line executable")
    if(NOT JLINK)
        set(JLINK "$ENV{ProgramFiles\(x86\)}/SEGGER/JLink/JLink.exe")
    endif()
    if(NOT JLINKGDBSERVER)
        set(JLINKGDBSERVER "$ENV{ProgramFiles\(x86\)}/SEGGER/JLink/JLinkGDBServerCL.exe")
    endif()
    if(NOT JLINKRTTCLIENT)
        set(JLINKRTTCLIENT "$ENV{ProgramFiles\(x86\)}/SEGGER/JLink/JLinkRTTClient.exe")
    endif()
else()
    find_program(JLINK JLinkExe DOC "Path to `JLinkExe` command line executable")
    find_program(JLINKGDBSERVER JLinkGDBServer DOC "Path to `JLinkGDBServer` command line executable")
    find_program(JLINKRTTCLIENT JLinkRTTClient DOC "Path to `JLinkRTTClient` command line executable")
endif ()

# check if all the necessary tools paths have been provided

if (NOT NRFJPROG)
    message(FATAL_ERROR "The path to the nrfjprog utility (NRFJPROG) must be set.")
endif ()

if (NOT NRFUTIL)
    message(FATAL_ERROR "The path to the nrfutil utility (NRFUTIL) must be set.")
endif ()

# must be set before project, otherwise causes linking issues
set(CMAKE_SYSTEM_NAME "Generic")
set(CMAKE_SYSTEM_PROCESSOR "ARM")
