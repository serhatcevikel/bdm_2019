# bash, sql, nosql and hadoop sessions
FROM gesiscss/orc-binder-serhatcevikel-2dbdm-5f2019-5f2-1e05af:3fbea1bcf6a4815c7e11a708c36ec04885b3cdab
LABEL maintainer="serhatcevikel@yahoo.com"
 
# Make sure the contents of our repo are in ${HOME}
COPY --chown=jovyan:jovyan . ${HOME}

USER ${NB_USER}

RUN rm -r ${HOME}/binder;

# Specify the default command to run
WORKDIR ${HOME}
