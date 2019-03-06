### Zabbix Monitoring Container for CoreOS

#####  Outline:

This Image is designed to discover and monitor running containers on a CoreOS Host as well as the Host itself.

##### Installation:

First, clone the repo and build the image:

```
git clone $repo
cd $repo
docker build -t zabbix-core .
```

Next, run a container from the newly built image, subsituting the  env's as needed:

```
docker run -d \
--name zabbix \
--privileged \
-e ZABBIX_SERVER="SERVER IP" \
-e ZABBIX_HOSTNAME="AGENT HOSTNAME" \
-p 10050:10050 \
-v /:/rootfs \
-v /var/run/docker.sock:/var/run/docker.sock \
-v /usr/bin/docker:/usr/bin/docker \
-v /run/metadata:/run/metadata \
-v /run/torcx:/run/torcx \
zabbix-core
```

##### Testing:

From your Zabbix Server you can test the agent by using the zabbix_get command:

```
zabbix_get -s {COREOS IP ADDRESS} -p 10050  -k containers.running
15
```

##### Add to Zabbix Server

Import the template.xml file into your Zabbix Server and assign it to your Core OS Host