#!/bin/bash

xo pgsql://colinadler@127.0.0.1/fishyv3?sslmode=disable -v -N -M -B -T InsertOwnedItem -o internal/models/ << ENDSQL
INSERT INTO "public"."owned_items" (
    "user", "item", "tier"
) VALUES (
    %%user string%%, %%item models.Item%%, %%tier int%%
)
ENDSQL