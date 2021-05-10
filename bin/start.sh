#!/bin/sh

bin/google_crawler eval "GoogleCrawler.ReleaseTasks.migrate()"

bin/google_crawler start
