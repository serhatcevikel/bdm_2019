# bash, sql, nosql and hadoop sessions
FROM gesiscss/orc-binder-serhatcevikel-2dbdm-5f2019-5f2-1e05af:7f3cf548a71d128b14ffd037507b7d80e425e560
LABEL maintainer="serhatcevikel@yahoo.com"
 
# Make sure the contents of our repo are in ${HOME}
COPY --chown=jovyan:jovyan . ${HOME}

USER ${NB_USER}

RUN \
    #echo "[[ \$TERM != \"screen\" ]] && exec screen -q" >> ${HOME}/.bashrc;\
    rm -r ${HOME}/binder;

# Specify the default command to run
WORKDIR ${HOME}
