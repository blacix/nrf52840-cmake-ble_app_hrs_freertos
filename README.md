# nrf52840-cmake-ble_app_hrs_freertos
nrf52840 cmake project for 
nRF5_SDK_16.0.0_98a08e2\examples\ble_peripheral\ble_app_hrs_freertos example.

# Requiremetns:
nrfjprog:
Download install and add to path:
https://www.nordicsemi.com/Products/Development-tools/nRF-Command-Line-Tools/Download

Install nrfutil:
-install python 3.7 or later.
-pip install nrfutil

# Build App
mkdir build
cd build 
cmake -DCMAKE_TOOLCHAIN_FILE:=../cmake/tc_arm-none-eabi-gcc.cmake .. -DCMAKE_BUILD_TYPE=Debug -G "Unix Makefiles" ..
cmake --build .
