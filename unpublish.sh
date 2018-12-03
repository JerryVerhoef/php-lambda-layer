#!/bin/bash -e

VERSION=$1

source regions.sh

MD5SUM=$(md5 -q layer.zip)
S3KEY="${LAYERNAME}/${MD5SUM}"

for region in "${PHP71_REGIONS[@]}"; do
  bucket_name="${BUCKET_PREFIX}-${region}"

  echo "Deleting Lambda Layer ${LAYERNAME} version ${VERSION} in region ${region}..."
  aws --region $region lambda delete-layer-version --layer-name ${LAYERNAME} --version-number $VERSION > /dev/null
  echo "Deleted Lambda Layer ${LAYERNAME} version ${VERSION} in region ${region}"
done
