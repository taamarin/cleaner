#!/system/bin/sh

# Declaring a variable to skip the default installation steps
SKIPUNZIP=1

module_descriptions() {
    # Print text on the Terminal screen (Magisk)
    ui_print "CC (Magisk Module)"
    ui_print " • A simple module that allows your device to clean all apps cache"
    ui_print " • Automatically if the total cache size is more than 1GB"
    ui_print " • And can be done manually by typing 'su -c cleaner' in the Terminal."
    sleep 2
    ui_print "Notes:"
    ui_print " • This module only clears the applications cache"
    ui_print " • In the 'cache' and 'code_cache' directories."
    sleep 2
}

# Declaring a function with the name "install_module"
install_module() {
    module_descriptions
    ui_print "Installing..."
    sleep 1

    ui_print "- Extracting module files"
    mkdir -p $MODPATH/system/bin
    mkdir -p /data/adb/cleaner
    mkdir -p /data/adb/cleaner/run
 
    if [ ! -d /data/adb/service.d ] ; then
        mkdir -p /data/adb/service.d
    fi

    unzip -j -o "${ZIPFILE}" 'cleaner_service.sh' -d /data/adb/service.d >&2
    unzip -j -o "${ZIPFILE}" 'cleaner/cleaner' -d $MODPATH/system/bin >&2
    unzip -j -o "${ZIPFILE}" 'cleaner/*' -d /data/adb/cleaner >&2
    unzip -j -o "${ZIPFILE}" 'module.prop' -d $MODPATH >&2
    unzip -j -o "${ZIPFILE}" 'service.sh' -d $MODPATH >&2
    unzip -j -o "${ZIPFILE}" 'uninstall.sh' -d $MODPATH >&2

    rm -rf /data/adb/cleaner/cleaner

    sleep 1
    ui_print "- Settings module"    
    ui_print "- Settings permission"
    set_perm_recursive $MODPATH 0 0 0755 0644
    set_perm_recursive /data/adb/cleaner 0 0 0755 0644
    set_perm $MODPATH/system/bin/cleaner 0 0 0755
    set_perm /data/adb/service.d/cleaner_service.sh 0 0 0755
    chmod ugo+x /data/adb/cleaner/*
}

if [ $API -lt 21 ]; then
    ui_print " Requires API 21+ (Android 5.0+) to install this module! "
    abort "*********************************************************"
elif [ $MAGISK_VER_CODE -lt 23000 ]; then
    ui_print " Please install Magisk v23.0+! "
    abort "*******************************"
elif ! $BOOTMODE; then
    ui_print " Install this module in Magisk! "
    abort "********************************"
else
    set -x
    sleep 3
    install_module
fi