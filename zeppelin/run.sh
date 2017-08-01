#!/bin/bash -x

# Reference: https://docs.docker.com/engine/userguide/containers/dockerimages/

echo "Usage: "
echo "  ${0} <instanceName>"
echo

accntTag=jeffreymanning
projectTag=zeppelin
imageTag=${1:-${accntTag}/${projectTag}}


dockerVolume_Data=data
dockerVolume_Notebook=notebook
targetHome=${ZEPPELIN_HOME:-/opt/zeppelin}

local_dir=/mnt/data/docker/$(basename ${imageTag})

#instanceName=my-${1:-${imageTag%/*}}_$RANDOM
instanceName=my-${1:-${imageTag##*/}}

mkdir -p ./data

echo "(example)"

docker run --rm -d --name ${instanceName} \
        -p 29090:8080 \
        ${imageTag}

#	${imageTag}:${version}

#	-v ${local_dir}/${dockerVolume_Notebook}:${targetHome}/${dockerVolume_Notebook} \
#	-v ${local_dir}/${dockerVolume_Data}:${targetHome}/${dockerVolume_Data} \

echo ">>> Docker Status"
docker ps -a |grep zeppelin
echo "-----------------------------------------------"
echo ">>> Docker Shell into Container `docker ps -lq`"
#docker exec -it ${instanceName} /bin/bash