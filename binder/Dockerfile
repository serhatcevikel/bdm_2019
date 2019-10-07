# bash, sql, nosql sessions and first hadoop session
FROM serhatcevikel/bigdata2:hadoop_01_20191006_01
LABEL maintainer="serhatcevikel@yahoo.com"
 
# environment variables
ENV NB_USER jovyan
ENV NB_UID 1000
ENV HOME /home/${NB_USER}

# Make sure the contents of our repo are in ${HOME}
COPY --chown=jovyan:jovyan . ${HOME}

USER ${NB_USER}

RUN rm -r ${HOME}/binder; \
   
    sed -i "/exec screen/ s/^/#/" ${HOME}/.bashrc;
    #echo "[[ \$TERM != \"screen\" ]] && exec screen -q" >> ${HOME}/.bashrc; \


# Specify the default command to run
ENV SHELL /bin/bash
WORKDIR ${HOME}
