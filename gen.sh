#!/bin/bash

rm -rf internal/models/*.xo.go

xo pgsql://colinadler@127.0.0.1/fishyv3?sslmode=disable -o internal/models/ --template-path internal/models/templates/
