LOCAL_PATH:= $(call my-dir)

common_src_files := \
	VolumeManager.cpp \
	CommandListener.cpp \
	VoldCommand.cpp \
	NetlinkManager.cpp \
	NetlinkHandler.cpp \
	Volume.cpp \
	DirectVolume.cpp \
	logwrapper.c \
	Process.cpp \
	Ext4.cpp \
	Fat.cpp \
	Loop.cpp \
	Devmapper.cpp \
	ResponseCode.cpp \
	Xwarp.cpp \
	cryptfs.c

common_c_includes := \
	$(KERNEL_HEADERS) \
	system/extras/ext4_utils \
	external/openssl/include

common_shared_libraries := \
	libsysutils \
	libcutils \
	libdiskconfig \
	libhardware_legacy \
	libcrypto

include $(CLEAR_VARS)

LOCAL_MODULE := libvold

LOCAL_SRC_FILES := $(common_src_files)

LOCAL_C_INCLUDES := $(common_c_includes)

LOCAL_SHARED_LIBRARIES := $(common_shared_libraries)

LOCAL_STATIC_LIBRARIES := libfs_mgr

LOCAL_MODULE_TAGS := eng tests

include $(BUILD_STATIC_LIBRARY)

include $(CLEAR_VARS)

LOCAL_MODULE:= vold

LOCAL_SRC_FILES := \
	main.cpp \
	$(common_src_files)

LOCAL_C_INCLUDES := $(common_c_includes)

LOCAL_CFLAGS := -Werror=format

ifeq ($(BOARD_VOLD_SHARES_DEV_MAJOR), true)
LOCAL_CFLAGS += -DSHARES_DEV_MAJOR
endif

ifneq ($(BOARD_VOLD_LUN_FILE_PATH),)
LOCAL_CFLAGS += -DCUSTOM_LUN_FILE=\"$(BOARD_VOLD_LUN_FILE_PATH)\"
endif

ifneq ($(BOARD_VOLD_SECOND_LUN_NUM),)
LOCAL_CFLAGS += -DCUSTOM_SECOND_LUN_NUM=$(BOARD_VOLD_SECOND_LUN_NUM)
endif

LOCAL_SHARED_LIBRARIES := $(common_shared_libraries)

LOCAL_STATIC_LIBRARIES := libfs_mgr

include $(BUILD_EXECUTABLE)

include $(CLEAR_VARS)

LOCAL_SRC_FILES:= vdc.c

LOCAL_MODULE:= vdc

LOCAL_C_INCLUDES := $(KERNEL_HEADERS)

LOCAL_CFLAGS := 

LOCAL_SHARED_LIBRARIES := libcutils

include $(BUILD_EXECUTABLE)
