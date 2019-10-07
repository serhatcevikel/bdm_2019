# install pig and hive
FROM serhatcevikel/bigdata:hadoop04

# environment variables
ENV NB_USER hadoop
ENV NB_UID 1000
ENV HOME /home/${NB_USER}
ENV JAVA_HOME=/usr/lib/jvm/default-java
ENV HADOOP_VERSION 2.9.2
ENV HADOOP_PREFIX=/opt/hadoop-$HADOOP_VERSION
ENV HADOOP_HOME=$HADOOP_PREFIX
ENV HADOOP_CONF_DIR=/etc/hadoop
ENV MULTIHOMED_NETWORK=1
ENV USER=root
ENV PIG_VERSION=0.17.0
ENV PIG_HOME=/opt/pig
ENV HIVE_VERSION=2.3.4
ENV HIVE_HOME=/opt/hive
ENV PATH=$PIG_HOME/bin:$PATH
ENV PATH=$HIVE_HOME/bin:$PATH

USER root

# install pig
USER root
RUN mkdir -p $PIG_HOME && \
    chown -R $NB_UID $PIG_HOME;


USER ${NB_USER}
RUN curl -o /tmp/pig-${PIG_VERSION}.tar.gz \
    http://ftp.itu.edu.tr/Mirror/Apache/pig/pig-${PIG_VERSION}/pig-${PIG_VERSION}.tar.gz && \
    
    tar -xvf /tmp/pig-${PIG_VERSION}.tar.gz -C ${PIG_HOME} --strip-components=1 && \
    rm /tmp/pig-${PIG_VERSION}.tar.gz;

# install hive
USER root
RUN mkdir -p $HIVE_HOME && \
    chown -R $NB_UID $HIVE_HOME;


USER ${NB_USER}
RUN curl -o /tmp/apache-hive-${HIVE_VERSION}-bin.tar.gz \
    http://ftp.itu.edu.tr/Mirror/Apache/hive/hive-${HIVE_VERSION}/apache-hive-${HIVE_VERSION}-bin.tar.gz && \
    
    tar -xvf /tmp/apache-hive-${HIVE_VERSION}-bin.tar.gz -C $HIVE_HOME --strip-components=1 && \
    rm /tmp/apache-hive-${HIVE_VERSION}-bin.tar.gz;

# add directive to delete copied folders, as the previous version

USER ${NB_USER}
ENV SHELL /usr/bin/bash
WORKDIR ${HOME}

