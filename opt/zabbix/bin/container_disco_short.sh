#!/bin/bash
containers=`/rootfs/usr/bin/docker ps -a -q`
name=`/rootfs/usr/bin/docker ps | awk '{if (NR!=1) {print}}' | awk '{print $NF}'`

echo '{
 "data" :[
{'

  for container in $containers
  do
      name=`/rootfs/usr/bin/docker ps -a  | awk '{if (NR!=1) {print}}' | grep $container | awk '{print $NF}'`
      echo "    \"{#CONTAINERNAME_SHORT}\":\"$name\",\"{#SHORTID}\":\"$container\"},{"

  done

echo "}
]
}"
