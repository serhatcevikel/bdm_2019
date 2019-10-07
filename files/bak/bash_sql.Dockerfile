# Make sure the contents of our repo are in ${HOME}
COPY . ${HOME}

    # install q 
    qdeblink=$(lynx -listonly -nonumbers -dump "https://github.com/harelba/q/releases" | grep -P "\.deb$" | head -1); \
    qdebfile=${qdeblink##*/}; \

    wget -P ${HOME}/binder $qdeblink; \
    dpkg -i ${HOME}/binder/$qdebfile; \


    #jdbc for postgresql
    wget -P /usr/lib/jvm/default-java/lib https://jdbc.postgresql.org/download/postgresql-42.2.5.jar; \

    # java env variables 
    echo "CLASSPATH=$JAVA_HOME/lib/postgresql-42.2.5.jar" >> /etc/environment; \

    # add postgresql bin dir to path
    echo "$PATH=$PATH:/usr/lib/postgresql/11/bin" >> /etc/environment; \

    ## install R kernel for jupyter
    Rscript $HOME/binder/rpack.R; \

    # change postgres password
    echo "postgres:postgres" | chpasswd; \
    
    # pg config
    perl -i -pe 's/(md5|peer)$/trust/g' /etc/postgresql/11/main/pg_hba.conf; \

    ## install beaker kernels
    beakerx install; \

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

    ## pgcli default options
    mkdir -p $HOME/.config/pgcli; \
    cp $HOME/binder/pgcli_config $HOME/.config/pgcli/config; \

    # quilt
    quilt install serhatcevikel/bdm_data; \
    quilt export serhatcevikel/bdm_data $HOME/data; \

    # gunzip database
    #gunzip -k $HOME/data/imdb/imdb.sql.gz; \

    # run expect script for parallel
    expect ${HOME}/binder/expect_script; \

    # extract tsv files onto tsv2
    datadir=$HOME/data; \
    imdbdir=$datadir/imdb; \

    mkdir -p $imdbdir/tsv2; \

    find $imdbdir/tsv -mindepth 1 | \
    parallel -k -j0 "basenm=\$(basename {}); gunzip -c {} > ${imdbdir}/tsv2/\${basenm%.gz};";


# start postgresql and create imdb database
USER postgres
RUN /usr/lib/postgresql/11/bin/pg_ctl start -D /etc/postgresql/11/main/ -m smart && \
    createdb -U postgres imdb2 && \
    gunzip -c $HOME/data/imdb/imdb.sql.gz | psql imdb2 postgres && \
    #psql imdb2 postgres < $HOME/data/imdb/imdb.sql; 
    /usr/lib/postgresql/11/bin/pg_ctl stop -D /etc/postgresql/11/main/ -m smart;

# Specify the default command to run
USER ${NB_USER}
ENV SHELL /usr/bin/bash
WORKDIR ${HOME}
#RUN cd ${HOME}
#USER postgres
#CMD ["/usr/lib/postgresql/10/bin/pg_ctl", "-D", "/var/lib/postgresql/10/main", "-l", "logfile", "start"; "jupyter", "notebook", "--ip", "0.0.0.0"; "su", "-", "jovyan"]
#ENTRYPOINT ["sudo", "-u", "postgres", "/usr/lib/postgresql/10/bin/pg_ctl", "-D", "/etc/postgresql/10/main", "start"; "sudo", "-u", "jovyan", "jupyter", "notebook", "--notebook-dir='/home/jovyan'", "--ip", "0.0.0.0"]
#CMD service postgresql start && jupyter notebook --notebook-dir="/home/jovyan" --ip 0.0.0.0
#CMD ["jupyter", "notebook", "--ip", "0.0.0.0"]
#CMD sudo -i -u postgres /bin/bash -c "/usr/lib/postgresql/10/bin/pg_ctl -D /etc/postgresql/10/main -l /var/lib/postgresql/logfile start" && sudo -i -u jovyan /bin/bash -c "jupyter notebook --notebook-dir='/home/jovyan' --ip 0.0.0.0"
#CMD /usr/lib/postgresql/10/bin/pg_ctl -D /etc/postgresql/10/main -l /var/lib/postgresql/logfile start && jupyter notebook --notebook-dir='/home/jovyan' --ip 0.0.0.0
#CMD postgresql start
#ENTRYPOINT ["service", "postgresql", "start"]

