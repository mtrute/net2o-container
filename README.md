net2o in a container

Uses the directory /my/home/net2o of the docker host to store
persistent data such as keys or chat logs. Inside the container
this directory is called /net2o regardless where it is on the
host - see the -v option below.

```shell
$ docker pull mtrute/net2o-container
$ mkdir /my/home/net2o
$ docker run -ti --rm -v /my/home/net2o:/net2o mtrute/net2o-container n2o keylist
Passphrase: ••••••  
==== opened: ....
```

The config file /net2o/config shall look like

```shell
date=2
chats="/net2o/chats"
keys="/net2o/keys"
.net2o="/net2o"
```

see https://fossil.net2o.de for more information.
