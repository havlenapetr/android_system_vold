BUILD_VOLD2 := false
ifneq ($(TARGET_SIMULATOR),true)
    BUILD_VOLD2 := true
endif

ifeq ($(BUILD_VOLD2),true)

LOCAL_PATH:= $(call my-dir)

include $(CLEAR_VARS)

LOCAL_SRC_FILES:=                                      \
                  main.cpp                             \
                  VolumeManager.cpp                    \
                  CommandListener.cpp                  \
                  VoldCommand.cpp                      \
                  NetlinkManager.cpp                   \
                  NetlinkHandler.cpp                   \
                  Volume.cpp                           \
                  DirectVolume.cpp                     \
                  logwrapper.c                         \
                  Process.cpp                          \
                  Fat.cpp                              \
                  Loop.cpp                             \
                  Devmapper.cpp                        \
                  ResponseCode.cpp                     \
                  Xwarp.cpp

LOCAL_MODULE:= vold

LOCAL_C_INCLUDES :=                          \
                    $(KERNEL_HEADERS)        \
                    external/openssl/include

LOCAL_CFLAGS := 

ifeq ($(TARGET_BOARD_PLATFORM),s5pc110)
LOCAL_CFLAGS += -DTARGET_IS_GALAXYS
endif

LOCAL_SHARED_LIBRARIES :=               \
                          libsysutils   \
                          libcutils     \
                          libdiskconfig \
                          libcrypto

include $(BUILD_EXECUTABLE)

include $(CLEAR_VARS)

LOCAL_SRC_FILES:= vdc.c

LOCAL_MODULE:= vdc

LOCAL_C_INCLUDES := $(KERNEL_HEADERS)

LOCAL_CFLAGS := 

LOCAL_SHARED_LIBRARIES := libcutils

include $(BUILD_EXECUTABLE)

include $(call all-makefiles-under,$(LOCAL_PATH))

endif # ifeq ($(BUILD_VOLD,true)
