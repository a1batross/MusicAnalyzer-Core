#
# Copyright (c) 2017 a1batross
#
# Permission is hereby granted, free of charge, to any person obtaining a copy
# of this software and associated documentation files (the "Software"), to deal
# in the Software without restriction, including without limitation the rights
# to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
# copies of the Software, and to permit persons to whom the Software is
# furnished to do so, subject to the following conditions:
#
# The above copyright notice and this permission notice shall be included in all
# copies or substantial portions of the Software.
#
# THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
# IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
# FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
# AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
# LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
# OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
# SOFTWARE.
#

cmake_minimum_required(VERSION 2.6.0)

set(CMAKE_MODULE_PATH "${CMAKE_CURRENT_LIST_DIR}/cmake/")

project (MUSICANALYZER_CORE)

set (MUSICANALYZER_CORE ma_core)

find_package(Essentia REQUIRED)

set(MUSICANALYZER_CORE_SRC
	streaming_extractor_music.cpp
	extractor_music/MusicExtractor.cpp
	extractor_music/MusicRhythmDescriptors.cpp
	extractor_music/MusicTonalDescriptors.cpp
	extractor_music/MusicLowlevelDescriptors.cpp
	)
include_directories (. extractor_music/ ${ESSENTIA_INCLUDE_DIRS})

if(ANDROID)
	add_library(${MUSICANALYZER_CORE} SHARED ${MUSICANALYZER_CORE_SRC})
else()
	add_executable(${MUSICANALYZER_CORE} ${MUSICANALYZER_CORE_SRC})
endif()

target_link_libraries(${MUSICANALYZER_CORE} ${ESSENTIA_LIBRARIES})

set_target_properties (${MUSICANALYZER_CORE} PROPERTIES
	POSITION_INDEPENDENT_CODE 1)
