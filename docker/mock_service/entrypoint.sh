#!/usr/bin/env bash
#  CRITICAL:  set -e  to exit the script and prevent the service from being started if preflight exits
#  with a non-zero code
set -e
./preflight
./mock-service
