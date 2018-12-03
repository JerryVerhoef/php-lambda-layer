#!/bin/bash -e

source regions.sh

MD5SUM=$(md5 -q layer.zip)
S3KEY="${LAYERNAME}/${MD5SUM}"

for region in "${PHP71_REGIONS[@]}"; do
  bucket_name="${BUCKET_PREFIX}-${region}"

  echo "Uploading layer.zip to s3://${bucket_name}/${S3KEY}"

  aws --region $region s3 cp layer.zip "s3://${bucket_name}/${S3KEY}"
done
