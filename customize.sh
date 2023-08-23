#!/sbin/sh

SKIPUNZIP=1
ASH_STANDALONE=1

module_descriptions() {
    # Print text on the Terminal screen (Magisk)
    ui_print "- Cleaner Cache (Magisk Module)"
    ui_print "- A simple module that allows your device to clean all apps cache"
    ui_print "- Automatically if the total cache size is more than 1GB"
    ui_print "- And can be done manually by typing 'su -c cleaner' in the Terminal."

    ui_print ""
    ui_print "- This module only clears the applications cache"
    ui_print "- In the 'cache' and 'code_cache' directories."
}

# Declaring a function with the name "install_module"
install_module() {
    module_descriptions
    ui_print "- Installing..."
    ui_print "- Extracting module files"
    mkdir -p $MODPATH/system/bin
    mkdir -p /data/adb/cleaner
    mkdir -p /data/adb/cleaner/run
 
    unzip -j -o "${ZIPFILE}" 'cleaner_service.sh' -d /data/adb/service.d >&2
    unzip -j -o "${ZIPFILE}" 'cleaner/cleaner' -d $MODPATH/system/bin >&2
    unzip -j -o "${ZIPFILE}" 'cleaner/*' -d /data/adb/cleaner >&2
    unzip -j -o "${ZIPFILE}" 'module.prop' -d $MODPATH >&2
    unzip -j -o "${ZIPFILE}" 'service.sh' -d $MODPATH >&2
    unzip -j -o "${ZIPFILE}" 'uninstall.sh' -d $MODPATH >&2

    rm -rf /data/adb/cleaner/cleaner

    ui_print "- Settings module"    
    ui_print "- Settings permission"
    set_perm_recursive $MODPATH 0 0 0755 0644
    set_perm_recursive /data/adb/cleaner 0 0 0755 0644
    set_perm $MODPATH/system/bin/cleaner 0 0 0755
    set_perm /data/adb/service.d/cleaner_service.sh 0 0 0755
    chmod ugo+x /data/adb/cleaner/*
}

### INSTALLATION ###

if [ "$BOOTMODE" != true ]; then
  ui_print "-----------------------------------------------------------"
  ui_print "! Please install in Magisk Manager or KernelSU Manager"
  ui_print "! Install from recovery is NOT supported"
  abort "-----------------------------------------------------------"
elif [ "$KSU" = true ] && [ "$KSU_VER_CODE" -lt 10670 ]; then
  abort "ERROR: Please update your KernelSU and KernelSU Manager"
fi

# check android
if [ "$API" -lt 21 ]; then
  ui_print "! Unsupported sdk: $API"
  abort "! Minimal supported sdk is 21 (Android 5)"
else
  ui_print "- Device sdk: $API"
fi

# check version
service_dir="/data/adb/service.d"
if [ "$KSU" = true ]; then
  ui_print "- kernelSU version: $KSU_VER ($KSU_VER_CODE)"
  [ "$KSU_VER_CODE" -lt 10683 ] && service_dir="/data/adb/ksu/service.d"
else
  ui_print "- Magisk version: $MAGISK_VER ($MAGISK_VER_CODE)"
fi

if [ ! -d "${service_dir}" ]; then
  mkdir -p "${service_dir}"
fi

install_module
