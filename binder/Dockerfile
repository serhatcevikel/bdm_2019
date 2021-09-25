# bash, sql, nosql and hadoop sessions
# from 2021 branch
FROM gesiscss/binder-r2d-g5b5b759-serhatcevikel-2dbdm-5f2019-e7b363:4f8ca003edf54d7a160c1c60744219bd94c4e7c7
LABEL maintainer="serhatcevikel@yahoo.com"

# Make sure the contents of our repo are in ${HOME}
COPY --chown=jovyan:jovyan . ${HOME}

USER root
RUN \
    # install pip packages
    pip3 install --no-cache \
        jupyterlab; \
    \   
    jupyter labextension install \
        @jupyterlab/toc \
        transient-display-data \
        jupyterlab-sos;
#       jupyterlab-sos;

#    # start ssh
#    service ssh start;\
#    service postgresql start;\
#
#    sudo -H -u ${NB_USER} bash -c "export JAVA_HOME=/usr/lib/jvm/default-java; \
#    ${HADOOP_HOME}/sbin/start-dfs.sh && \
#    ${HADOOP_HOME}/sbin/start-yarn.sh && \
#    ${HADOOP_HOME}/bin/hdfs dfsadmin -safemode leave && \
#    ${HIVE_HOME}/bin/hive --service metastore & \
#    sleep 20;\
#    tables=\$(psql -U postgres -d world -t --pset=\"border=0\" -c \"\dt\" | \
#    awk -F \" \" '{ print $2 }') && \
#    ${HIVE_HOME}/bin/hive -e \"create database world2\" && \
#    echo \"\$tables\" | while read l; \
#    do ${SQOOP_HOME}/bin/sqoop import \
#    --connect jdbc:postgresql://localhost:5432/world \
#    --username postgres \
#    --table \$l \
#    --hive-import \
#    --create-hive-table \
#    --hive-table world2.\$l \
#    --direct; \
#    done; \
#    \
#    ${HADOOP_HOME}/sbin/stop-yarn.sh && \
#    ${HADOOP_HOME}/sbin/stop-dfs.sh";\
#    service postgresql stop;\
#    service ssh stop;

USER ${NB_USER}

RUN \
    #echo "[[ \$TERM != \"screen\" ]] && exec screen -q" >> ${HOME}/.bashrc;\
    rm -r ${HOME}/binder;

# Specify the default command to run
WORKDIR ${HOME}
