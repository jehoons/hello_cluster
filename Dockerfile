FROM       ubuntu:16.04

MAINTAINER Je-Hoon Song “song.jehoon@gmail.com”

RUN apt-get update && apt-get install -y iputils-ping

# WORKDIR ${STANDB_HOME}

CMD ["/bin/bash"]

