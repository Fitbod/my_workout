#!/bin/bash

set -e

gem install bundler -v "$(cat Gemfile.lock | grep -A 1 "BUNDLED WITH" | grep -v BUNDLED | awk '{print $1}')"

bundle config github.com $GITHUB_TOKEN:x-oauth-basic

function should_bundle {
    if [[ -n $FORCE_BUNDLE ]] || ! bundle check
    then
       return 0
    else
        return 1
    fi
}

function install {
    if [[ -n $FORCE_BUNDLE ]]
    then
        bundle install --jobs 4 --redownload $@
    else
        bundle install --jobs 4 $@
    fi
}

if should_bundle
then
    if [ "$BUILD_ENV" = "production" ] || [ "$BUILD_ENV" = "staging" ]
    then
        bundle config set deployment 'true'
        install --without development test
    else
        install
    fi
else
    echo ""
fi
