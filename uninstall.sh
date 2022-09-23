#!/system/bin/sh

uninstall_cleaner() {
    rm -rf /data/adb/cleaner
    rm -rf /data/adb/service.d/cleaner_service.sh
}

uninstall_cleaner