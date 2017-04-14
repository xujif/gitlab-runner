FROM gitlab/gitlab-runner:v1.11.1

RUN curl https://get.docker.com | sh -

ENV CI_RUNNER_USER root

COPY start.sh /usr/bin/
RUN chmod a+x /usr/bin/start.sh

ENTRYPOINT ["sh","-c"]

CMD ["/usr/bin/start.sh"]

