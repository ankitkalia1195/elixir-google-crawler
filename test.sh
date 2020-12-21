#!/bin/bash

echo "Migrating databse for test..."

mix ecto.create

mix ecto.migrate

echo "Running test..."

mix test
