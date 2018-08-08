#!/bin/bash

# make pushd and popd silent
pushd () { command pushd "$@" > /dev/null ; }
popd () { command popd "$@" > /dev/null ; }

pushd internal/
    # without removing the templates first, xo_db.go.go will never be regenerated
    rm -rf models/*.xo.go
    xo pgsql://colinadler@127.0.0.1/fishyv3?sslmode=disable -o models/ --template-path models/templates/
popd
