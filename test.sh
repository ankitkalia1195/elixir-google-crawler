#!/bin/bash

mix deps.get && \
  cd assets && \
  npm install && \
  cd ..

echo "Migrating databse for test..."

mix ecto.create

mix ecto.migrate

echo "Running test..."

mix test
