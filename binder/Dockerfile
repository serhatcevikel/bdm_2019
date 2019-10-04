# bash and sql sessions
#FROM serhatcevikel/bigdata2:bash_sql_01
FROM serhatcevikel/bigdata2:bash_sql_20191004_01
LABEL maintainer="serhatcevikel@yahoo.com"
 
# environment variables
ENV NB_USER jovyan
ENV NB_UID 1000
ENV HOME /home/${NB_USER}


# Make sure the contents of our repo are in ${HOME}
COPY --chown=jovyan:jovyan . ${HOME}

USER ${NB_USER}

RUN rm -r ${HOME}/binder;

# Specify the default command to run
ENV SHELL /bin/bash
WORKDIR ${HOME}
