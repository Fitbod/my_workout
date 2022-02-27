#!/bin/bash

set -ex

sleep 500
bundle exec rails s -b 0.0.0.0 -p 3000
