# pip packages, node, tldr, jupyter conf

# Make sure the contents of our repo are
    # install mongo
    # https://docs.mongodb.com/manual/tutorial/install-mongodb-on-debian/
    wget -qO - https://www.mongodb.org/static/pgp/server-4.2.asc | sudo apt-key add - && \
    echo "deb http://repo.mongodb.org/apt/debian stretch/mongodb-org/4.2 main" | sudo tee /etc/apt/sources.list.d/mongodb-org-4.2.list && \
    apt update && \
    apt install -y mongodb-org; \   

 in ${HOME}

# install pip packages

    pip3 install --no-cache notebook beakerx sos sos-notebook \
        quilt==2.9.15 bash_kernel pgcli ipython-sql postgres_kernel \
        pgspecial jupyter_contrib_nbextensions \
        imongo-kernel ipython_mongo; \

# install node
    curl -sL https://deb.nodesource.com/setup_12.x | sudo -E bash - && \
        apt install -y nodejs build-essential; \

jupyter-nbextensions-configurator RISE nbpresent; \

    # tldr
    npm install tldr -g; \
    
    # own home directory by user
    chown -R ${NB_UID} ${HOME};

