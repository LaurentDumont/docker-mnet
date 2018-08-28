
How to launch the container

```
git clone https://github.com/LaurentDumont/docker-natlas.git
cd docker-natlas
sudo docker build . --tag docker-natlas
sudo docker run -v $COMPLETE_PATH_HERE/topology_image/:/topology_image/ --env TARGET_HOST=$ROOT_HOST_HERE --env FILE_EXTENSION=pdf docker-natlas
```
