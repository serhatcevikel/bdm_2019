# bash and sql sessions
FROM serhatcevikel/bigdata2:bash_sql_01
LABEL maintainer="serhatcevikel@yahoo.com"
 
# environment variables
ENV NB_USER jovyan
ENV NB_UID 1000
ENV HOME /home/${NB_USER}


# Make sure the contents of our repo are in ${HOME}
COPY --chown=jovyan:jovyan . ${HOME}

USER root
RUN Rscript -e "IRkernel::installspec(user = FALSE)"; \
    chown -R ${NB_UID} ${HOME}/data/imdb/tsv2;

USER ${NB_USER}

RUN \
    # make screen default on terminal
    printf "hardstatus on\nhardstatus alwayslastline\nhardstatus string \"%%w\"\n" >> ${HOME}/.screenrc ;\
    echo "[[ \$TERM != \"screen\" ]] && exec screen -q" >> ${HOME}/.bashrc;

# Specify the default command to run
ENV SHELL /bin/bash
WORKDIR ${HOME}
