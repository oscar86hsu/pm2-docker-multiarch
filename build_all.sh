#!/bin/bash
tpath='tags'
declare -A versions
versions['latest']='alpine|stretch|jessie|slim'
versions['14']='alpine|stretch|jessie|slim'
versions['13']='alpine|stretch|jessie|slim'
versions['12']='alpine|stretch|jessie|slim'
versions['10']='alpine|stretch|jessie|slim|wheezy'
versions['8']='alpine|stretch|jessie|slim|wheezy'


for version in "${!versions[@]}"
do

  variants=(${versions[$version]//|/ })
  for i in "${!variants[@]}"
  do
    variant=${variants[i]}
    docker buildx build --platform linux/amd64,linux/arm64,linux/arm/v7 -t oscar86hsu/pm2:"$version"-"$variant" --push "$tpath/$version/$variant"
    docker image prune --all -f
  done
done