LOCAL_PATH := $(call my-dir)

include $(CLEAR_VARS)

LOCAL_MODULE := ma_core

include $(XASH3D_CONFIG)

LOCAL_C_INCLUDES := $(DEPS_INCLUDE_PATH)

LOCAL_EXPORT_C_INCLUDES := $(LOCAL_C_INCLUDES)

LOCAL_SRC_FILES := main.cpp \
	platform/android_jni.cpp \
	extractor_music/MusicLowlevelDescriptors.cpp \
	extractor_music/MusicExtractor.cpp \
	extractor_music/MusicRhythmDescriptors.cpp \
	extractor_music/MusicTonalDescriptors.cpp 

LOCAL_SHARED_LIBRARIES := essentia gaia2

LOCAL_LDLIBS := -llog 

include $(BUILD_SHARED_LIBRARY)
