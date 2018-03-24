#From Debian Stretch because the Python Docker image does not have graphviz
FROM debian:stretch

#We need wget,git and pip for MNET.
RUN apt-get update && apt-get install graphviz wget git python-pip -y

#Clone the MNET binaries directly. The "pip install" version is buggy.
RUN git clone https://github.com/MJL85/mnet.git

#Make all further commands use the relative path from inside the MNET git folder.
WORKDIR mnet

#Install our prerequisites from pip. Need specific pyparsing version.
RUN pip install pysnmp pyparsing==2.0.6 pydot2 netaddr graphviz

#Copy our boilerplate mnet configuration file
COPY mnet.conf mnet.conf

#Execute the topology discovery when the container is starting.
CMD python mnet.py graph -r $TARGET_HOST -d 10 -f /topology_image/topology.$IMAGE_OUTPUT -c mnet.conf
