### gitlab-runner with docker in docker

#### entry point  
```bash
#!/bin/sh

file="/var/run/lock/gitlab_registered.lock"
RUN_GITLAB_CI="/usr/bin/dumb-init /entrypoint run --user=$CI_RUNNER_USER --working-directory=/home/gitlab-runner"
if [ ! -f "$file" ]; then
    sh -c "$PRE_INSTALL_COMMAND" && gitlab-runner register -n && touch "$file" && sh -c $RUN_GITLAB_CI
else 
    sh -c $RUN_GITLAB_CI     
fi
```


### 注册信息
```bash
CI_SERVER_URL=http://gitlab.example.com
RUNNER_NAME=my-runner
REGISTRATION_TOKEN=my-registration-token
REGISTER_NON_INTERACTIVE=true
```
