#!/bin/bash
containers=`/rootfs/usr/bin/docker ps --no-trunc | awk '{if (NR!=1) {print}}' | awk '{print $1}'`
name=`/rootfs/usr/bin/docker ps | awk '{if (NR!=1) {print}}' | awk '{print $NF}'`

echo '{
 "data" :[
{'

  for container in $containers
  do
      name=`/rootfs/usr/bin/docker ps --no-trunc | awk '{if (NR!=1) {print}}' | grep $container | awk '{print $NF}'`
      echo "    \"{#CONTAINERNAME}\":\"$name\",\"{#CONTAINERID}\":\"$container\"},{"

  done

echo "}
]
}"
