
FROM docker:dind

MAINTAINER Andrey Chalov <andrchalov@gmail.com>

RUN echo "===> Installing sudo to emulate normal OS behavior..." && \
    apk --update add sudo && \
    \
    \
    echo "===> Adding Python runtime..."                    && \
    apk --update add python py-pip openssl ca-certificates  &&\
    apk --update add --virtual build-dependencies \
      python-dev libffi-dev openssl-dev build-base          && \
    pip install --upgrade pip cffi                          && \
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
    echo "===> Complete"

# default command: display Ansible version
CMD [ "ansible-playbook", "--version" ]
