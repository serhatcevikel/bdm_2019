# pip packages, node, tldr, q, beaker
# jupyter, tldr cache, .bashrc, pgcli, expect for parallel

FROM serhatcevikel/bigdata2:b_2019_01

LABEL maintainer="serhatcevikel@yahoo.com"

COPY --chown=jovyan:jovyan / ${HOME}
#COPY --chown=jovyan:jovyan /files ${HOME}/files

USER root

RUN \
    # install pip packages
    pip3 install --no-cache \
        bash_kernel \
        beakerx \
        imongo-kernel \
        ipython_mongo \
        ipython-sql \
        jupyter_contrib_nbextensions \
        jupyter-nbextensions-configurator \
        nbpresent \
        notebook \
        pgcli \
        pgspecial \
        postgres_kernel \
        py4j \
        quilt==2.9.15 \
        RISE \
        sos \
        sos-notebook; \

    # install node
    curl -sL https://deb.nodesource.com/setup_12.x | sudo -E bash - && \
        apt install -y nodejs build-essential; \

    # tldr
    npm install tldr -g; \
    
    # install q 
    qdeblink=$(lynx -listonly -nonumbers -dump "https://github.com/harelba/q/releases" | grep -P "\.deb$" | head -1); \
    qdebfile=${qdeblink##*/}; \

    wget -P ${HOME} $qdeblink && \
    dpkg -i ${HOME}/$qdebfile && \
    rm ${HOME}/$qdebfile; \

    ## install beaker kernels
    beakerx install;

USER ${NB_USER}

# nbpresent
RUN python3 -m bash_kernel.install; \
    python3 -m sos_notebook.install; \
    jupyter contrib nbextension install --user; \
    jupyter nbextensions_configurator enable --user; \
    jupyter nbextension install nbpresent --py --overwrite --user; \
    jupyter nbextension enable nbpresent --py --user; \
    jupyter serverextension enable nbpresent --py --user; \
    jupyter-nbextension enable codefolding/main --user; \
    jupyter-nbextension install rise --py --user; \
    jupyter-nbextension enable splitcell/splitcell --user; \
    jupyter-nbextension enable hide_input/main --user; \
    jupyter-nbextension enable nbextensions_configurator/tree_tab/main --user; \
    jupyter-nbextension enable nbextensions_configurator/config_menu/main --user; \
    jupyter-nbextension enable contrib_nbextensions_help_item/main  --user; \
    jupyter-nbextension enable scroll_down/main --user; \
    jupyter-nbextension enable toc2/main --user; \
    jupyter-nbextension enable autoscroll/main  --user; \
    jupyter-nbextension enable rubberband/main --user; \
    jupyter-nbextension enable exercise2/main --user; \
    cp $HOME/files/common.json $HOME/.jupyter/nbconfig/common.json; \

    # update tldr cache
    tldr -u; \
    
    # screenrc
    printf "hardstatus on\nhardstatus alwayslastline\nhardstatus string \"%%w\"\n" >> ${HOME}/.screenrc; \
    
    # bashrc
    echo "export LC_ALL=C.UTF-8" >> $HOME/.bashrc; \
    echo "export LANG=C.UTF-8" >> $HOME/.bashrc; \
    echo "export EDITOR=vim" >> $HOME/.bashrc; \

    ## pgcli default options
    mkdir -p $HOME/.config/pgcli; \
    cp $HOME/files/pgcli_config $HOME/.config/pgcli/config; \

    # run expect script for parallel
    expect ${HOME}/files/expect_script; \
    
    # remove files
    rm -r ${HOME}/files;

# Make sure the contents of our repo are in ${HOME}

USER ${NB_USER}

RUN rm -r ${HOME}/binder


# Specify the default command to run
ENV SHELL /usr/bin/bash
WORKDIR ${HOME}
