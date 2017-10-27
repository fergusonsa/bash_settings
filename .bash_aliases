alias ls='ls -lasF'

alias save-history='history -a'

dockercli2() { 
  docker exec -it $1 /bin/bash; }


alias lien-local='lein repl :connect `cat .nrepl-port`'

dockercli() {
  containername=$1
  shift
  if [ -z "$@" ]
  then
    echo "going to start interactive bash session to container $containername";
    docker exec -it $containername /bin/bash;
  else 
    echo "in container $containername, running command: $@";
    docker exec -t $containername $@;
  fi
}

alias lein2='docker run --rm -it -v /Users/fergusonsa/:/root/ -v `pwd`:/code -v /opt/cenx/application:/opt/cenx/application -e ZOOKEEPER_INSTANCES=zookeeper1 -e ZOOKEEPER_ZOOKEEPER1_CLIENT_PORT=2181 -e ZOOKEEPER_ZOOKEEPER1_HOST=172.17.0.1 ship.cenx.com:5000/lein'

alias lein3='docker run --rm -it -v ~/:/root/ -v `pwd`:/code -v /opt/cenx/application:/opt/cenx/application -e ZOOKEEPER_INSTANCES=zookeeper1 -e ZOOKEEPER_ZOOKEEPER1_CLIENT_PORT=2181 -e ZOOKEEPER_ZOOKEEPER1_HOST=172.17.0.1 ship.cenx.com:5000/lein'


alias lein4='docker run --rm -it -v ~/:/root/ -v ~/CENX/src/heimdallr:/code -v /opt/cenx/application:/opt/cenx/application -e ZOOKEEPER_INSTANCES=zookeeper1 -e ZOOKEEPER_ZOOKEEPER1_CLIENT_PORT=2181 -e ZOOKEEPER_ZOOKEEPER1_HOST=172.17.0.1 ship.cenx.com:5000/lein'
