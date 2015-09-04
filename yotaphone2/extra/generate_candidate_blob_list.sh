#!/usr/bin/env bash
# Generates list of proprietary file candidates from Stock ROM
#
# Somewhat similar to generate-blob-lists.sh
# takes installed_files.txt from AOSP build with incomplete blobs
# diffs with fileslist from Stock ROM
# 
# usage:
# mkdir tmp
# cd tmp
# cp out/target/product/<device>/installed-files.txt > installed-files-aosp.txt
# ../system/build/tools/fileslist.py <ROM dir>/system > installed-files-rom.txt
# <android>/vendor/yota/yotaphone2/extra/genererate_candidate_blob_files.sh
#

cat installed-files-aosp.txt |
      cut -b 15- |
      sort -f > filelist-without.txt

cat installed-files-rom.txt |
      cut -b 15- |
      sort -f > filelist-with.txt

diff filelist-without.txt filelist-with.txt |
        grep -v '\.odex$' |
        grep '>' |
        cut -b 3-
    > candidates-proprietary-blobs.txt
