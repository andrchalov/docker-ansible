
FROM docker:dind

MAINTAINER Andrey Chalov <andrchalov@gmail.com>

RUN echo "===> Installing sudo to emulate normal OS behavior..." && \
    apk --update add sudo && \
    \
    \
    echo "===> Adding Python runtime..."                    && \
    apk --update add python py-pip openssl openssh-keygen ca-certificates  &&\
    apk --update add --virtual build-dependencies \
      python-dev libffi-dev openssl-dev build-base  && \
    pip install --upgrade pip cffi docker-py                && \
    \
    \
    echo "===> Installing Ansible..." && \
    pip install ansible               && \
    \
    \
    echo "===> Removing package list..."  && \
    apk del build-dependencies            && \
    rm -rf /var/cache/apk/*               && \
    \
    \
    echo "===> Adding hosts for convenience..."  && \
    mkdir -p /etc/ansible                        && \
    echo -e '[local]\nlocalhost ansible_connection=local' > /etc/ansible/hosts && \
    \
    \
    echo "===> Complete"

VOLUME /var/lib/docker
EXPOSE 2375

ENTRYPOINT ["dockerd-entrypoint.sh"]
CMD []
