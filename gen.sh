#!/bin/bash

# make pushd and popd silent
pushd () { command pushd "$@" > /dev/null ; }
popd () { command popd "$@" > /dev/null ; }

pushd internal/models
    # without removing the templates first, xo_db.go.go will never be regenerated
    rm -rf *.xo.go
    xo pgsql://colin@127.0.0.1/fishyv3?sslmode=disable -o . --template-path templates/

    xo pgsql://colin@127.0.0.1/fishyv3?sslmode=disable -N -M -B -T GuildLeaderboardDesc -o . << ENDSQL
    select "user", "score"
    from guild_rankings
    where guild = %%guild string%%
    order by score desc
    limit 10 offset %%offest int%%
ENDSQL

    xo pgsql://colin@127.0.0.1/fishyv3?sslmode=disable -N -M -B -T GuildLeaderboardCount -o . << ENDSQL
    select count("id")
    from guild_rankings
ENDSQL

    xo pgsql://colin@127.0.0.1/fishyv3?sslmode=disable -N -M -B -T GlobalLeaderboardDesc -o . << ENDSQL
    select "user", "score"
    from global_rankings 
    order by score desc
    limit 10 offset %%offset int%%
ENDSQL

    xo pgsql://colin@127.0.0.1/fishyv3?sslmode=disable -N -M -B -T GlobalLeaderboardCount -o . << ENDSQL
    select count("user")
    from global_rankings
ENDSQL

    pushd schema
        pg_dump -h localhost \
        -U colin \
        -f dump.sql \
        fishyv3
    popd
popd

pushd pb
    protoc --gogofaster_out=plugins=grpc:. *.proto
popd
