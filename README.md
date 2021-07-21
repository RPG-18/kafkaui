# KafkaUI simple desktop application for Apache Kafka

KafkaUI simple GUI desktop application for Apache Kafka based on [librdkafka](https://github.com/edenhill/librdkafka) and
[Qt](https://www.qt.io/) and written on C++.

## Build from source

### Requirements

* Qt >= 6;
* librdkafka >= 1.7;
* spdlog

#### GNU/Linux

    $ mkdir build
    $ cd build
    $ cmake -DCMAKE_BUILD_TYPE=Release ..
    $ make
    $ ./kafkaui


#### Windows

#### vcpkg and Visual Studio 2019

    .\vcpkg.exe install qt:x64-windows
    .\vcpkg.exe install librdkafka[*]:x64-windows --recurse
    .\vcpkg.exe install spdlog:x64-windows
    cmake -B build -S . -DCMAKE_TOOLCHAIN_FILE=[path to vcpkg]/scripts/buildsystems/vcpkg.cmake
    cmake --build build
    [path to vcpkg]\installed\x64-windows\tools\Qt6\bin\windeployqt.debug.bat --qmldir [path to vcpkg]\installed\x64-windows\Qt6\qml [project]\kafkaui\build\Debug