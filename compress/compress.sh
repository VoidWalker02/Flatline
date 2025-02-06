#!/bin/bash

archive_name="archive_$(date +%Y%m%d_%H%M%S).tar.gz"

tar -czvf "$archive_name" ./*

echo "All files within this directory have been compressed into $archive_name."