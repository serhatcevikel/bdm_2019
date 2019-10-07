# ssh, data

#FROM serhatcevikel/bigdata2:b_2019_01_20191007_01
FROM gcr.io/binder-prod/r2d-f18835fd-serhatcevikel-2dbdm-5f2019-e7b363:312f849c85e7838929bfad0c5bdcd41bff87aebc

LABEL maintainer="serhatcevikel@yahoo.com"

USER root

# configure sshd
RUN sed -i '/^#PubkeyAuthentication/ s/^#//' /etc/ssh/sshd_config; \
    sed -i '/^#PermitRootLogin/ s/^#//' /etc/ssh/sshd_config; \
    sed -i '/StrictHostKeyChecking/ s/^#//' /etc/ssh/ssh_config; \
    sed -i '/StrictHostKeyChecking/ s/ask/no/' /etc/ssh/ssh_config;

USER ${NB_USER}

# copy conf files, create ssh key, exract files
RUN \
    mkdir -p $HOME/.ssh; \
    ssh-keygen -b 2048 -t rsa -f $HOME/.ssh/id_rsa -q -N ""; \
    cp $HOME/.ssh/id_rsa.pub $HOME/.ssh/authorized_keys;

RUN \
    # quilt
    quilt install serhatcevikel/bdm_data; \
    quilt export serhatcevikel/bdm_data $HOME/data; \


# Specify the default command to run
USER ${NB_USER}
ENV SHELL /bin/bash
WORKDIR ${HOME}
