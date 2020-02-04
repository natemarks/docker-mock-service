#!/usr/bin/env bash
#  CRITICAL:  set -e  to exit the script and prevent the service from being started if preflight exits
#  with a non-zero code
set -e
./preflight
# exec mock service is CRITICALLY IMPORTANT
# it causes teh mokc-service to take over the pid 1 role from the entrypoint shell script
# wihtouth that, it never gets the sigterm from docker-compose-down
# https://hynek.me/articles/docker-signals/
# https://medium.com/@gchudnov/trapping-signals-in-docker-containers-7a57fdda7d86
# https://blog.codeship.com/trapping-signals-in-docker-containers/
# http://veithen.io/2014/11/16/sigterm-propagation.html
# later I may need to wrap the service so I can execute a final diagnostic logger wiht task metadata
# so we can see the container close and detect the absence of the graceful shutdown
# this would require the the servcie graceful shiutdown timer is a few seconds less than the container so we have time
# to run some logger thing example: 'preflight finalize'  subcommand
exec ./mock-service
