#From Ubuntu 18 because the Python Docker image does not have graphviz and Debian doesn't have Python 3.6.
FROM ubuntu:18.04

#We need wget,git and pip for NATLAS.
RUN apt-get update && apt-get install graphviz wget git python3-pip python3 -y

#Clone the NATLAS binaries directly. The "pip install" version is buggy.
RUN git clone https://github.com/MJL85/natlas.git

#Make all further commands use the relative path from inside the NATLAS git folder.
WORKDIR natlas

#Install our prerequisites from pip. Need specific pyparsing version.
RUN pip3 install pysnmp pyparsing==2.0.6 pydot netaddr graphviz pysnmp

#Copy our boilerplate NATLAS configuration file
COPY natlas.conf natlas.conf

#Execute the topology discovery when the container is starting.
CMD python3.6 natlas-cli.py diagram -r $TARGET_HOST -o /topology_image/topology-`date +%Y-%m-%d-%H-%M-%S`.$FILE_EXTENSION
