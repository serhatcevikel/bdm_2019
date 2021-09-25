# bash, sql, nosql and hadoop sessions
# from 2021 branch
FROM gesiscss/binder-r2d-g5b5b759-serhatcevikel-2dbdm-5f2019-e7b363:4f8ca003edf54d7a160c1c60744219bd94c4e7c7
LABEL maintainer="serhatcevikel@yahoo.com"

# Make sure the contents of our repo are in ${HOME}
COPY --chown=jovyan:jovyan . ${HOME}

USER ${NB_USER}

RUN \
    #echo "[[ \$TERM != \"screen\" ]] && exec screen -q" >> ${HOME}/.bashrc;\
    rm -r ${HOME}/binder;

# Specify the default command to run
WORKDIR ${HOME}
