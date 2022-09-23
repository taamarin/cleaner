#!/system/bin/sh

moddir=/data/adb/modules/cache_cleaner
if [ -n "$(magisk -v | grep lite)" ]; then
  moddir=/data/adb/lite_modules/cache_cleaner
fi
scripts_dir=/data/adb/cleaner

start_cleaner() {
  ${scripts_dir}/cleaner.service start
}

if [ ! -f /data/adb/cleaner/manual ] ; then
  echo -n "" > /data/adb/cleaner/run/cleaner.log
  if [ ! -f ${moddir}/disable ] ; then
    start_cleaner
  fi
  inotifyd ${scripts_dir}/cleaner.inotify ${moddir} &>> /dev/null &
fi
