# Установка docker с madlib

## 1) Pull down the `madlib/postgres_10` image from docker hub:

    docker pull madlib/postgres_10

## 2) Launch a container corresponding to the MADlib image, mounting the source code folder to the container:

    git clone https://github.com/apache/madlib ~/Documents/incubator-madlib

    docker run -d -it --name madlib -v ~/Documents/incubator-madlib:/incubator-madlib/ madlib/postgres_10

## 3) When the container is up, connect to it and build MADlib:

    docker exec -it madlib bash
    mkdir /incubator-madlib/build-docker
    cd /incubator-madlib/build-docker
    cmake ..
    make
    make doc
    make install

## 4) Install MADlib:

    src/bin/madpack -p postgres -c postgres/postgres@localhost:5432/postgres install

## 5) Several other madpack commands can now be run:

### Run install check, on all modules:

    src/bin/madpack -p postgres -c postgres/postgres@localhost:5432/postgres install-check

### Run install check, on a specific module, say svm:

    src/bin/madpack -p postgres -c postgres/postgres@localhost:5432/postgres install-check -t svm

### Run dev check, on all modules (more comprehensive than install check):

    src/bin/madpack -p postgres -c postgres/postgres@localhost:5432/postgres dev-check

### Run dev check, on a specific module, say svm:

    src/bin/madpack -p postgres -c postgres/postgres@localhost:5432/postgres dev-check -t svm

### Reinstall MADlib:

    src/bin/madpack -p postgres -c postgres/postgres@localhost:5432/postgres reinstall

## 6) Kill and remove containers (after exiting the container):

    docker kill madlib
    docker rm madlib
