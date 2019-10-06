# bash, sql, nosql sessions and first hadoop session
FROM serhatcevikel/bigdata2:hadoop_01_20191006_01
LABEL maintainer="serhatcevikel@yahoo.com"
 
# environment variables
ENV NB_USER jovyan
ENV NB_UID 1000
ENV HOME /home/${NB_USER}


# Make sure the contents of our repo are in ${HOME}
COPY --chown=jovyan:jovyan . ${HOME}

USER root

RUN \

    if [ -e /usr/bin/bash ]; \
    then \
        rm /usr/bin/bash; \
    fi; \

    cp /bin/bash /usr/bin/bash; \

    if [ -e /usr/bin/sh ]; \
    then \
        rm /usr/bin/sh; \
    fi; \

    ln -s /usr/bin/bash /usr/bin/sh;


USER ${NB_USER}

RUN rm -r ${HOME}/binder;

# Specify the default command to run
ENV SHELL /usr/bin/bash
WORKDIR ${HOME}
