### CLEANER CACHE

[![MAGISK](https://img.shields.io/badge/Magisk%20-v20.4+-brightgreen)](https://github.com/topjohnwu/Magisk)
[![API](https://img.shields.io/badge/API-21%2B-brightgreen.svg?style=flat)](https://android-arsenal.com/api?level=21)
[![RELEASES](https://img.shields.io/github/downloads/taamarin/cleaner/total.svg)](https://github.com/taamarin/cleaner/releases)


It will clean the cache in the following directories:
```shell
    "/data/data/*/cache/*"
    "/data/data/*/code_cache/*"
    "/data/user_de/*/*/cache/*"
    "/data/user_de/*/*/code_cache/*"
    "/sdcard/Android/data/*/cache/*"
    "/data/system/dropbox/*"
```

If the total reaches 1GB, the checking will be done every 6 hours.

open **/data/adb/cleaner/cleaner.service**,to make changes:

limit size (KB)
https://github.com/taamarin/cleaner/blob/e79c4645ad3a7119ce8cacd90617beee0c862e48/cleaner/cleaner.service#L78

Checking interval
https://github.com/taamarin/cleaner/blob/e79c4645ad3a7119ce8cacd90617beee0c862e48/cleaner/cleaner.service#L16
if you understand.
