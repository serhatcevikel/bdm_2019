    # install xidel
    wget "https://netcologne.dl.sourceforge.net/project/videlibri/Xidel/Xidel%200.9.8/xidel_0.9.8-1_amd64.deb" && \
    dpkg -i xidel_0.9.8-1_amd64.deb; \


    #jdbc for postgresql
    #wget -P /usr/lib/jvm/default-java/lib https://jdbc.postgresql.org/download/postgresql-42.2.5.jar; \


    # java env variables 
    echo "JAVA_HOME=/usr/lib/jvm/default-java" >> /etc/environment; \
    echo "CLASSPATH=$JAVA_HOME/lib/postgresql-42.2.5.jar" >> /etc/environment; \

    ## install R kernel for jupyter
    Rscript $HOME/binder/rpack.R; \

    # rc configuration
    echo "startup_message off" >> /etc/screenrc; \
    #echo "screen" >> /etc/profile; \
    
    # install node
    curl -sL https://deb.nodesource.com/setup_10.x | sudo -E bash - && \
        apt install -y nodejs build-essential; \

    # change postgres password
    # echo "postgres:postgres" | chpasswd; \
    
    # pg config
    # perl -i -pe 's/(md5|peer)$/trust/g' /etc/postgresql/11/main/pg_hba.conf; \


    ln -s /usr/bin/bash /usr/bin/sh; \
    #RUN pg_createcluster -u postgres -g postgres 10 main
    
    jupyter-nbextensions-configurator RISE nbpresent; \

    ## install beaker kernels
    beakerx install; \

    # tldr
    npm install tldr -g; \
    
    # own home directory by user
    chown -R ${NB_UID} ${HOME}

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
    cp $HOME/binder/common.json $HOME/.jupyter/nbconfig/common.json; \

    # update tldr cache
    tldr -u; \

    # bashrc
    echo "export JAVA_HOME=/usr/lib/jvm/default-java" >> $HOME/.bashrc; \
    echo "export LC_ALL=C.UTF-8" >> $HOME/.bashrc; \
    echo "export LANG=C.UTF-8" >> $HOME/.bashrc; \
    echo "export EDITOR=vim" >> $HOME/.bashrc; \
    #echo "screen" >> $HOME/.bashrc; \

    # quilt
    quilt install serhatcevikel/bdm_data; \
    quilt export serhatcevikel/bdm_data $HOME/data; \

    # gunzip database
    #gunzip -k $HOME/data/imdb/imdb.sql.gz; \

    # run expect script for parallel
    expect ${HOME}/binder/expect_script; \

    # extract comtrade files
    datadir=$HOME/data; \
    comtradedir=$datadir/comtrade_s1; \
    
    mkdir -p $comtradedir/2010e; \
    
    find $comtradedir/2010 -mindepth 1 | \
    parallel -k -j0 "basenm=\$(basename {}); gunzip -c {} > ${comtradedir}/2010e/\${basenm%.gz};";
    

# Specify the default command to run
USER ${NB_USER}
ENV SHELL /usr/bin/bash
WORKDIR ${HOME}

