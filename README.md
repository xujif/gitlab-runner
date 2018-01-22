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
NAME:
   register - register a new runner

USAGE:
   command register [command options] [arguments...]

OPTIONS:
   -c, --config "/etc/gitlab-runner/config.toml"        Config file [$CONFIG_FILE]
   --tag-list                                           Tag list [$RUNNER_TAG_LIST]
   -n, --non-interactive                                Run registration unattended [$REGISTER_NON_INTERACTIVE]
   --leave-runner                                       Don't remove runner if registration fails [$REGISTER_LEAVE_RUNNER]
   -r, --registration-token                             Runner's registration token [$REGISTRATION_TOKEN]
   --run-untagged                                       Register to run untagged builds; defaults to 'true' when 'tag-list' is empty [$REGISTER_RUN_UNTAGGED]
   --name, --description "6c501d0bcf0c"                 Runner name [$RUNNER_NAME]
   --limit "0"                                          Maximum number of builds processed by this runner [$RUNNER_LIMIT]
   --output-limit "0"                                   Maximum build trace size in kilobytes [$RUNNER_OUTPUT_LIMIT]
   -u, --url                                            Runner URL [$CI_SERVER_URL]
   -t, --token                                          Runner token [$CI_SERVER_TOKEN]
   --tls-ca-file                                        File containing the certificates to verify the peer when using HTTPS [$CI_SERVER_TLS_CA_FILE]
   --executor                                           Select executor, eg. shell, docker, etc. [$RUNNER_EXECUTOR]
   --builds-dir                                         Directory where builds are stored [$RUNNER_BUILDS_DIR]
   --cache-dir                                          Directory where build cache is stored [$RUNNER_CACHE_DIR]
   --env                                                Custom environment variables injected to build environment [$RUNNER_ENV]
   --pre-clone-script                                   Runner-specific command script executed before code is pulled [$RUNNER_PRE_CLONE_SCRIPT]
   --pre-build-script                                   Runner-specific command script executed after code is pulled, just before build executes [$RUNNER_PRE_BUILD_SCRIPT]
   --post-build-script                                  Runner-specific command script executed after code is pulled and just after build executes [$RUNNER_POST_BUILD_SCRIPT]
   --shell                                              Select bash, cmd or powershell [$RUNNER_SHELL]
   --ssh-user                                           User name [$SSH_USER]
   --ssh-password                                       User password [$SSH_PASSWORD]
   --ssh-host                                           Remote host [$SSH_HOST]
   --ssh-port                                           Remote host port [$SSH_PORT]
   --ssh-identity-file                                  Identity file to be used [$SSH_IDENTITY_FILE]
   --docker-host                                        Docker daemon address [$DOCKER_HOST]
   --docker-cert-path                                   Certificate path [$DOCKER_CERT_PATH]
   --docker-tlsverify                                   Use TLS and verify the remote [$DOCKER_TLS_VERIFY]
   --docker-hostname                                    Custom container hostname [$DOCKER_HOSTNAME]
   --docker-image                                       Docker image to be used [$DOCKER_IMAGE]
   --docker-cpuset-cpus                                 String value containing the cgroups CpusetCpus to use [$DOCKER_CPUSET_CPUS]
   --docker-dns                                         A list of DNS servers for the container to use [$DOCKER_DNS]
   --docker-dns-search                                  A list of DNS search domains [$DOCKER_DNS_SEARCH]
   --docker-privileged                                  Give extended privileges to container [$DOCKER_PRIVILEGED]
   --docker-cap-add                                     Add Linux capabilities [$DOCKER_CAP_ADD]
   --docker-cap-drop                                    Drop Linux capabilities [$DOCKER_CAP_DROP]
   --docker-security-opt                                Security Options [$DOCKER_SECURITY_OPT]
   --docker-devices                                     Add a host device to the container [$DOCKER_DEVICES]
   --docker-disable-cache                               Disable all container caching [$DOCKER_DISABLE_CACHE]
   --docker-volumes                                     Bind mount a volumes [$DOCKER_VOLUMES]
   --docker-volume-driver                               Volume driver to be used [$DOCKER_VOLUME_DRIVER]
   --docker-cache-dir                                   Directory where to store caches [$DOCKER_CACHE_DIR]
   --docker-extra-hosts                                 Add a custom host-to-IP mapping [$DOCKER_EXTRA_HOSTS]
   --docker-volumes-from                                A list of volumes to inherit from another container [$DOCKER_VOLUMES_FROM]
   --docker-network-mode                                Add container to a custom network [$DOCKER_NETWORK_MODE]
   --docker-links                                       Add link to another container [$DOCKER_LINKS]
   --docker-services                                    Add service that is started with container [$DOCKER_SERVICES]
   --docker-wait-for-services-timeout "0"               How long to wait for service startup [$DOCKER_WAIT_FOR_SERVICES_TIMEOUT]
   --docker-allowed-images                              Whitelist allowed images [$DOCKER_ALLOWED_IMAGES]
   --docker-allowed-services                            Whitelist allowed services [$DOCKER_ALLOWED_SERVICES]
   --docker-pull-policy                                 Image pull policy: never, if-not-present, always [$DOCKER_PULL_POLICY]
   --parallels-base-name                                VM name to be used [$PARALLELS_BASE_NAME]
   --parallels-template-name                            VM template to be created [$PARALLELS_TEMPLATE_NAME]
   --parallels-disable-snapshots                        Disable snapshoting to speedup VM creation [$PARALLELS_DISABLE_SNAPSHOTS]
   --virtualbox-base-name                               VM name to be used [$VIRTUALBOX_BASE_NAME]
   --virtualbox-base-snapshot                           Name or UUID of a specific VM snapshot to clone [$VIRTUALBOX_BASE_SNAPSHOT]
   --virtualbox-disable-snapshots                       Disable snapshoting to speedup VM creation [$VIRTUALBOX_DISABLE_SNAPSHOTS]
   --cache-type                                         Select caching method: s3, to use S3 buckets [$CACHE_TYPE]
   --cache-s3-server-address                            A host:port to the used S3-compatible server [$S3_SERVER_ADDRESS]
   --cache-s3-access-key                                S3 Access Key [$S3_ACCESS_KEY]
   --cache-s3-secret-key                                S3 Secret Key [$S3_SECRET_KEY]
   --cache-s3-bucket-name                               Name of the bucket where cache will be stored [$S3_BUCKET_NAME]
   --cache-s3-bucket-location                           Name of S3 region [$S3_BUCKET_LOCATION]
   --cache-s3-insecure                                  Use insecure mode (without https) [$S3_CACHE_INSECURE]
   --cache-s3-cache-path                                Name of the path to prepend to the cache URL [$S3_CACHE_PATH]
   --cache-cache-shared                                 Enable cache sharing between runners. [$CACHE_SHARED]
   --machine-idle-nodes "0"                             Maximum idle machines [$MACHINE_IDLE_COUNT]
   --machine-idle-time "0"                              Minimum time after node can be destroyed [$MACHINE_IDLE_TIME]
   --machine-max-builds "0"                             Maximum number of builds processed by machine [$MACHINE_MAX_BUILDS]
   --machine-machine-driver                             The driver to use when creating machine [$MACHINE_DRIVER]
   --machine-machine-name                               The template for machine name (needs to include %s) [$MACHINE_NAME]
   --machine-machine-options                            Additional machine creation options [$MACHINE_OPTIONS]
   --machine-off-peak-periods                           Time periods when the scheduler is in the OffPeak mode [$MACHINE_OFF_PEAK_PERIODS]
   --machine-off-peak-timezone                          Timezone for the OffPeak periods (defaults to Local) [$MACHINE_OFF_PEAK_TIMEZONE]
   --machine-off-peak-idle-count "0"                    Maximum idle machines when the scheduler is in the OffPeak mode [$MACHINE_OFF_PEAK_IDLE_COUNT]
   --machine-off-peak-idle-time "0"                     Minimum time after machine can be destroyed when the scheduler is in the OffPeak mode [$MACHINE_OFF_PEAK_IDLE_TIME]
   --kubernetes-host                                    Optional Kubernetes master host URL (auto-discovery attempted if not specified) [$KUBERNETES_HOST]
   --kubernetes-cert-file                               Optional Kubernetes master auth certificate [$KUBERNETES_CERT_FILE]
   --kubernetes-key-file                                Optional Kubernetes master auth private key [$KUBERNETES_KEY_FILE]
   --kubernetes-ca-file                                 Optional Kubernetes master auth ca certificate [$KUBERNETES_CA_FILE]
   --kubernetes-image                                   Default docker image to use for builds when none is specified [$KUBERNETES_IMAGE]
   --kubernetes-namespace                               Namespace to run Kubernetes jobs in [$KUBERNETES_NAMESPACE]
   --kubernetes-namespace_overwrite_allowed             Regex to validate 'KUBERNETES_NAMESPACE_OVERWRITE' value [$KUBERNETES_NAMESPACE_OVERWRITE_ALLOWED]
   --kubernetes-privileged                              Run all containers with the privileged flag enabled [$KUBERNETES_PRIVILEGED]
   --kubernetes-cpus                                    (deprecated) The CPU allocation given to build containers [$KUBERNETES_CPUS]
   --kubernetes-memory                                  (deprecated) The amount of memory allocated to build containers [$KUBERNETES_MEMORY]
   --kubernetes-service-cpus                            (deprecated) The CPU allocation given to build service containers [$KUBERNETES_SERVICE_CPUS]
   --kubernetes-service-memory                          (deprecated) The amount of memory allocated to build service containers [$KUBERNETES_SERVICE_MEMORY]
   --kubernetes-helper-cpus                             (deprecated) The CPU allocation given to build helper containers [$KUBERNETES_HELPER_CPUS]
   --kubernetes-helper-memory                           (deprecated) The amount of memory allocated to build helper containers [$KUBERNETES_HELPER_MEMORY]
   --kubernetes-cpu-limit                               The CPU allocation given to build containers [$KUBERNETES_CPU_LIMIT]
   --kubernetes-memory-limit                            The amount of memory allocated to build containers [$KUBERNETES_MEMORY_LIMIT]
   --kubernetes-service-cpu-limit                       The CPU allocation given to build service containers [$KUBERNETES_SERVICE_CPU_LIMIT]
   --kubernetes-service-memory-limit                    The amount of memory allocated to build service containers [$KUBERNETES_SERVICE_MEMORY_LIMIT]
   --kubernetes-helper-cpu-limit                        The CPU allocation given to build helper containers [$KUBERNETES_HELPER_CPU_LIMIT]
   --kubernetes-helper-memory-limit                     The amount of memory allocated to build helper containers [$KUBERNETES_HELPER_MEMORY_LIMIT]
   --kubernetes-cpu-request                             The CPU allocation requested for build containers [$KUBERNETES_CPU_REQUEST]
   --kubernetes-memory-request                          The amount of memory requested from build containers [$KUBERNETES_MEMORY_REQUEST]
   --kubernetes-service-cpu-request                     The CPU allocation requested for build service containers [$KUBERNETES_SERVICE_CPU_REQUEST]
   --kubernetes-service-memory-request                  The amount of memory requested for build service containers [$KUBERNETES_SERVICE_MEMORY_REQUEST]
   --kubernetes-helper-cpu-request                      The CPU allocation requested for build helper containers [$KUBERNETES_HELPER_CPU_REQUEST]
   --kubernetes-helper-memory-request                   The amount of memory requested for build helper containers [$KUBERNETES_HELPER_MEMORY_REQUEST]
   --kubernetes-pull-policy                             Policy for if/when to pull a container image (never, if-not-present, always). The cluster default will be used if not set [$KUBERNETES_PULL_POLICY]
   --kubernetes-node-selector "{}"                      A toml table/json object of key=value. Value is expected to be a string. When set this will create pods on k8s nodes that match all the key=value pairs.
   --kubernetes-image-pull-secrets                      A list of image pull secrets that are used for pulling docker image [$KUBERNETES_IMAGE_PULL_SECRETS]
   --kubernetes-helper-image                            [ADVANCED] Override the default helper image used to clone repos and upload artifacts [$KUBERNETES_HELPER_IMAGE]
   --kubernetes-terminationGracePeriodSeconds "0"       Duration after the processes running in the pod are sent a termination signal and the time when the processes are forcibly halted with a kill signal. [$KUBERNETES_TERMINATIONGRACEPERIODSECONDS]
   --kubernetes-poll-interval "0"                       How frequently, in seconds, the runner will poll the Kubernetes pod it has just created to check its status [$KUBERNETES_POLL_INTERVAL]
   --kubernetes-poll-timeout "0"                        The total amount of time, in seconds, that needs to pass before the runner will timeout attempting to connect to the pod it has just created (useful for queueing more builds that the cluster can handle at a time) [$KUBERNETES_POLL_TIMEOUT]

```
