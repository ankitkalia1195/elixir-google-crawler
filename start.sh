#!/bin/bash

RUN mix deps.get && \
    cd assets && \
    npm install && \
    cd ..

mix ecto.create

mix ecto.migrate

PORT=$PORT mix phx.server
