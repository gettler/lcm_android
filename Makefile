#
# libcmyth example application for Android
#
# Please make sure that adb, ant, and ndk-build are in your $PATH
#

TARGET=lcm

EMULATOR=emulator-5554
FILTER=lcm:V settings:V httpd:V responder:V statistics:V frontend:V backend:V episode:V *:S

default: debug

debug: libcmyth
	ant debug

libcmyth:
	cd cmyth && BUILD_ANDROID=y scons
	mkdir -p libs/armeabi
	cp cmyth/libcppmyth/libs/armeabi/*.so libs/armeabi
	cp cmyth/swig/libs/armeabi/*.so libs/armeabi
	cp cmyth/swig/cmyth.jar libs

clean:
	cd cmyth && scons -c
	ant clean

sim:
	adb -s $(EMULATOR) install bin/$(TARGET)-debug.apk

sim_update:
	adb -s $(EMULATOR) install -r bin/$(TARGET)-debug.apk

hw:
	adb -d install bin/$(TARGET)-debug.apk

hw_update:
	adb -d install -r bin/$(TARGET)-debug.apk

sim_debug:
	adb -s $(EMULATOR) logcat $(FILTER)

hw_debug:
	adb -d logcat lcm:V $(FILTER)
