# bash, sql, nosql and hadoop sessions
#FROM gesiscss/binder-r2d-g5b5b759-serhatcevikel-2dbdm-5f2019-5f2-1e05af:d035616dfa9f533cd2c19ba48c19ea6ff46a9ada
FROM gesiscss/binder-r2d-g5b5b759-serhatcevikel2-2dbdm-5f2022-9715f0:c07e78aa5ae0de1e842698edc0a19d13d083172c
LABEL maintainer="serhatcevikel@yahoo.com"

ENV datadir ${HOME}/data
ENV imdbdir ${datadir}/imdb
ENV comtrade ${datadir}/comtrade_s1
ENV hemlak ${datadir}/he_sisli
 
# Make sure the contents of our repo are in ${HOME}
COPY --chown=jovyan:jovyan . ${HOME}

USER ${ROOT}
RUN \
    chown -R ${NB_USER}:${NB_USER} /etc/ssh;

# Specify the default command to run
WORKDIR ${HOME}
