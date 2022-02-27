#!/bin/bash

set -ex

BUILD_PACKAGES=$(echo \
                     apt-transport-https \
                     curl \
                     git \
                     gnupg \
                     software-properties-common \
                     lsb-release)

RUNTIME_PACKAGES=$(echo \
                       postgresql-client \
                       nodejs
                )
# \
#                        netcat \
#                        build-essential \
#                        gettext)
                       # ca-certificates \


apt-get update -y
# apt-get install -y $BUILD_PACKAGES
apt-get install -y $RUNTIME_PACKAGES

# # Install gcloud
# export CLOUD_SDK_REPO="cloud-sdk-$(lsb_release -c -s)"
# echo "deb http://packages.cloud.google.com/apt $CLOUD_SDK_REPO main" | tee -a /etc/apt/sources.list.d/google-cloud-sdk.list
# curl https://packages.cloud.google.com/apt/doc/apt-key.gpg | apt-key add -
# apt-get update -y && apt-get install google-cloud-sdk -y

# # clean up
# apt-get remove --purge -y $BUILD_PACKAGES
# export SUDO_FORCE_REMOVE=yes
# apt-get autoremove --purge -y
# # just incase a dependency was auto removed
# apt-get install -y $RUNTIME_PACKAGES --no-install-recommends
# rm -rf /var/lib/apt/lists/*
