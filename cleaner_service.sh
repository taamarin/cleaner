#!/system/bin/sh

# Set the path to the service script
service_script=/data/adb/cleaner/start.sh

# Check if the necessary directories and files exist
if [ ! -f ${service_script} ]; then
  echo "Error: Service script not found" >&2
  exit 1
fi

# Wait for the system to finish booting
(
until [ $(getprop sys.boot_completed) -eq 1 ] ; do
  sleep 5
done

# Launch the service script
${service_script}
)&