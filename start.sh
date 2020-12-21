#!/bin/bash

RUN mix deps.get && \
    cd assets && \
    npm install && \
    cd ..

mix ecto.migrate

mix phx.server
