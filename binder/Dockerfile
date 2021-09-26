# bash, sql, nosql and hadoop sessions
FROM gesiscss/binder-r2d-g5b5b759-serhatcevikel-2dbdm-5f2019-5f2-1e05af:d035616dfa9f533cd2c19ba48c19ea6ff46a9ada
LABEL maintainer="serhatcevikel@yahoo.com"

ENV datadir ${HOME}/data
ENV imdbdir ${datadir}/imdb
ENV comtrade ${datadir}/comtrade_s1
ENV hemlak ${datadir}/he_sisli
 
# Make sure the contents of our repo are in ${HOME}
COPY --chown=jovyan:jovyan . ${HOME}

USER ${NB_USER}

RUN \
    #echo "[[ \$TERM != \"screen\" ]] && exec screen -q" >> ${HOME}/.bashrc;\
    rm -r ${HOME}/binder;

# Specify the default command to run
WORKDIR ${HOME}
