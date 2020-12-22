# Установка docker с madlib

## 1) Pull down the `madlib/postgres_10` image from docker hub:

    docker pull madlib/postgres_10

## 2) Launch a container corresponding to the MADlib image, mounting the source code folder to the container:

    git clone https://github.com/apache/madlib ~/Documents/incubator-madlib

We expose port 5555 for jupyter later

    docker run -p 5555:5555 -d -it --name madlib -v ~/Documents/incubator-madlib:/incubator-madlib/ madlib/postgres_10

## 3) When the container is up, connect to it and build MADlib:

    docker exec -it madlib bash
    mkdir /incubator-madlib/build-docker
    cd /incubator-madlib/build-docker
    cmake ..
    make
    make doc
    make install

## 4) Install MADlib to postgres (default):

    src/bin/madpack -p postgres -c postgres/postgres@localhost:5432/postgres install

## 4.5) Install MADlib to your db:

In case u want to install MADlib to anonther db, use previous command to do it
Firstly, create db

    psql -U postgres
    CREATE DATABASE datascience;
    \q

And install MADlib

    src/bin/madpack -p postgres -c postgres/postgres@localhost:5432/datascience install

where `localhost:5432/postgres` is your database. I have used db called datascience so I type: `localhost:5432/datascience`

## 5) Install deps:

I use python3 and jupyter-lab for this lab. So let's install it
First we need pip in our docker

    apt install curl
    # also i need git to clone my GitHub repo
    apt install git
    curl https://bootstrap.pypa.io/get-pip.py -o get-pip.py
    python3 get-pip.py

    pip3 install jupyterlab
    pip3 install ipython-sql

Start jupyter

    jupyter lab --no-browser --ip="0.0.0.0" --port=5555 --allow-root

Now you can use your host webbrowser. Jupyter will show you command with token to access web gui like:
`http://127.0.0.1:5555/?token=TOKEN`
