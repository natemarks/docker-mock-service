You need to install go to build this container.
https://golang.org/doc/install

Go doesn't need to be installed in the container itself, but when we want to update the preflight or mock-service
binaries we need to clone those two repose and run go build to create the correct version of the l;inux binary. That binary is put in docker/mock-service.  youo do this by running :

::

    make build


make build will do the following
 - download the preflightt repo, compile the binary and copy it into the docker directory
 - download the mock-service repo, compile the binary and copy it into the docker directory
 - run docker-compose build to rebuild the docker image



::

    make run
    docker-compose logs  -t mock-service
    Attaching to mock-service
    mock-service    | 2020-02-04T19:44:35.079750922Z time="2020-02-04T19:44:35Z" level=info msg="preflight version: v0.0.9"
    mock-service    | 2020-02-04T19:44:35.079780139Z time="2020-02-04T19:44:35Z" level=info msg="environment variable found: SERVICE_GRACEFUL_SHUTDOWN_TIMEOUT = cab4e4c248583e0db85c4ac3e3a9825db6046796e5d740017fd647a9d17e47cf (sha256)"
    mock-service    | 2020-02-04T19:44:35.079785330Z time="2020-02-04T19:44:35Z" level=info msg="Checked 1 environment variables.  Finished"
    mock-service    | 2020-02-04T19:44:35.086308790Z time="2020-02-04T19:44:35Z" level=info msg="mock-service version: v0.0.3"
    mock-service    | 2020-02-04T19:44:35.086329833Z time="2020-02-04T19:44:35Z" level=info msg="SERVICE_GRACEFUL_SHUTDOWN_TIMEOUT is set to 5s"
    mock-service    | 2020-02-04T19:44:35.086333464Z [GIN-debug] [WARNING] Creating an Engine instance with the Logger and Recovery middleware already attached.
    mock-service    | 2020-02-04T19:44:35.086335964Z
    mock-service    | 2020-02-04T19:44:35.086338232Z [GIN-debug] [WARNING] Running in "debug" mode. Switch to "release" mode in production.
    mock-service    | 2020-02-04T19:44:35.086340710Z  - using env:  export GIN_MODE=release
    mock-service    | 2020-02-04T19:44:35.086343745Z  - using code: gin.SetMode(gin.ReleaseMode)
    mock-service    | 2020-02-04T19:44:35.086346182Z
    mock-service    | 2020-02-04T19:44:35.086348829Z [GIN-debug] GET    /                         --> main.main.func1 (5 handlers)
    mock-service    | 2020-02-04T19:44:35.086351217Z [GIN-debug] [WARNING] Creating an Engine instance with the Logger and Recovery middleware already attached.
    mock-service    | 2020-02-04T19:44:35.086353555Z
    mock-service    | 2020-02-04T19:44:35.086355729Z [GIN-debug] [WARNING] Running in "debug" mode. Switch to "release" mode in production.
    mock-service    | 2020-02-04T19:44:35.086358102Z  - using env:  export GIN_MODE=release
    mock-service    | 2020-02-04T19:44:35.086360388Z  - using code: gin.SetMode(gin.ReleaseMode)
    mock-service    | 2020-02-04T19:44:35.086362657Z
    mock-service    | 2020-02-04T19:44:35.086364829Z [GIN-debug] GET    /heartbeat                --> main.main.func2 (5 handlers)



See the mock-service repo on how to use the service:
https://github.com/natemarks/mock-service

pushing to ecr

::

    eval $(aws ecr get-login --no-include-email | sed 's|https://||')
    docker tag mock-service [account_number].dkr.ecr.us-east-1.amazonaws.com/mock-service
    docker push [account_number].dkr.ecr.us-east-1.amazonaws.com/runbooks

