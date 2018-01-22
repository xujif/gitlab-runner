#!/bin/sh

file="/var/run/lock/gitlab_registered.lock"

RUN_GITLAB_CI=/usr/bin/dumb-init /entrypoint run --user=$CI_RUNNER_USER --working-directory=/home/gitlab-runner


if [ ! -f "$file" ]; then
    sh -c "$PRE_INSTALL_COMMAND" && gitlab-runner register -n && touch "$file" && sh -c "$RUN_GITLAB_CI"
else 
    sh -c "$RUN_GITLAB_CI"     
fi
