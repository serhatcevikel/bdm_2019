# bash, sql, nosql sessions and first hadoop session
FROM serhatcevikel/bigdata2:hadoop_01_20191006_02
LABEL maintainer="serhatcevikel@yahoo.com"
 
# environment variables
ENV NB_USER jovyan
ENV NB_UID 1000
ENV HOME /home/${NB_USER}
ENV PATH=$PATH:/opt/sqoop/bin:/opt/hadoop-2.9.2/bin:/opt/hadoop-2.9.2/sbin:/opt/hadoop-2.9.2/bin/:/usr/local/sbin:/usr/local/bin:/usr/sbin:/usr/bin:/sbin:/bin:/usr/lib/postgresql/11/bin

# Make sure the contents of our repo are in ${HOME}
COPY --chown=jovyan:jovyan . ${HOME}

USER root

RUN rm /etc/environment; \
    touch /etc/environment;

USER ${NB_USER}

RUN rm -r ${HOME}/binder; \
   
    sed -i "/exec screen/ s/^/#/" ${HOME}/.bashrc;
    #echo "[[ \$TERM != \"screen\" ]] && exec screen -q" >> ${HOME}/.bashrc; \


# Specify the default command to run
USER ${NB_USER}
ENV SHELL /usr/bin/bash
WORKDIR ${HOME}
