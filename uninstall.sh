#!/system/bin/sh

uninstall_cleaner() {
    if [ -f /data/adb/cleaner ]; then
        rm -rf /data/adb/cleaner
    fi
    if [ -f /data/adb/service.d/cleaner_service.sh ]; then
        rm -rf /data/adb/service.d/cleaner_service.sh
    fi
}

uninstall_cleaner