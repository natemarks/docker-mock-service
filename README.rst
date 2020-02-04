You need to install go to build this container.
https://golang.org/doc/install

Go doesn't need to be installed in the container itself, but when we want to update the preflight or mock-service
binaries we need to clone those two repose and run go build to create the correct version of the l;inux binary. That binary is put in docker/mock_service.  youo do this by running :

::

    make build


The container can be built  and run this way. use

::

    cd docker/mock_service
    docker build -t mock-service .
    cd ..
    docker-compose up -d
     curl -X GET 'http://localhost:8080/?wait=3000ms'
    docker logs mock_service
    docker-compose down


OR this way using the environment variables first with default settings form the docket/.env file that is excluded
from the git repo using gitignore, but will be used if you create one. The aws credential environment variables let me test the download
when I'm changing the container

::

    cd docker
    docker-compose up -d


To enter the running container:

::

    docker ps -a
        CONTAINER ID        IMAGE               COMMAND             CREATED              STATUS              PORTS                NAMES
        df4b02321b47        runbooks            "/entrypoint.sh"    About a minute ago   Up About a minute   0.0.0.0:80->80/tcp   runbooks
    docker exec -it runbooks /bin/bash

Deployment

The image will be pushed to ecr

::

    eval $(aws ecr get-login --no-include-email | sed 's|https://||')
    docker tag runbooks 371143864265.dkr.ecr.us-east-1.amazonaws.com/runbooks
    docker push 371143864265.dkr.ecr.us-east-1.amazonaws.com/runbooks


here are the container metadata outputs for container.json and  task.json

