#!/system/bin/sh

# Set the module directory based on the Magisk version
moddir=/data/adb/modules/cache_cleaner
if [ -n "$(magisk -v | grep lite)" ]; then
  moddir=/data/adb/lite_modules/cache_cleaner
fi

# Set the scripts directory
scripts_dir=/data/adb/cleaner

# Set the log file paths
log_file=/data/adb/cleaner/run/cleaner.log
service_log=/data/adb/cleaner/run/service.log

# Check if the necessary directories exist
if [ ! -d ${moddir} ] || [ ! -d ${scripts_dir} ]; then
  echo "Error: Directories not found" >&2
  exit 1
fi

# Check if inotifyd is installed
if ! type inotifyd > /dev/null; then
  echo "Error: inotifyd command not found" >&2
  exit 1
fi

# Function to start the cleaner service
start_cleaner() {
  ${scripts_dir}/cleaner.service start > ${log_file} 2> ${service_log}
}

# If the manual file doesn't exist
if [ ! -f ${scripts_dir}/manual ] ; then
  # Clear the log file
  echo -n "" > ${log_file}
  # If the module is not disabled
  if [ ! -f ${moddir}/disable ] ; then
    # Start the cleaner service
    start_cleaner
  fi
  # Start inotifyd to monitor the module directory
  inotifyd ${scripts_dir}/cleaner.inotify ${moddir} &>> /dev/null &
fi