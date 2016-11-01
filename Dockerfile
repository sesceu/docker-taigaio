FROM ubuntu:16.04
MAINTAINER Sebastian Schneider <mail@sesc.eu>

ENV TAIGA_VERSION 3.0.0

RUN apt-get update && apt-get install -y \
    build-essential \
    binutils-doc \
    autoconf flex \
    bison \
    libjpeg-dev \
    libfreetype6-dev \
    zlib1g-dev \
    libzmq3-dev \
    libgdbm-dev \
    libncurses5-dev \
    automake \
    libtool \
    libffi-dev \
    curl \
    git \
    tmux \
    gettext \
    postgresql-client \
    libpq-dev \
    python3 \
    python3-pip \
    python-dev \
    python3-dev \
    virtualenvwrapper \
    libxml2-dev \
    libxslt-dev \
    nginx \
    supervisor

# create the taiga user and working directory
RUN useradd -ms /bin/bash taiga
USER taiga
WORKDIR /home/taiga

# install taiga-back
RUN mkdir /home/taiga/taiga-back && \
    curl -L https://github.com/taigaio/taiga-back/archive/${TAIGA_VERSION}.tar.gz | tar -xz -C /home/taiga/taiga-back --strip-components 1 -f -
RUN cd taiga-back && \
    /bin/bash -c 'source ~/.bashrc && source /usr/share/virtualenvwrapper/virtualenvwrapper.sh &&  mkvirtualenv -p /usr/bin/python3.5 taiga' && \
    pip3 install -r requirements.txt && \
    python3 manage.py compilemessages && \
    python3 manage.py collectstatic --noinput

COPY taiga-back-local.py /home/taiga/taiga-back/settings/local.py

# install taiga-front
RUN mkdir /home/taiga/taiga-front && \
    curl -L https://github.com/taigaio/taiga-front/archive/${TAIGA_VERSION}.tar.gz | tar -xz -C /home/taiga/taiga-front --strip-components 1 -f - && \
    mkdir -p /home/taiga/taiga-front/dist && \
    cp /home/taiga/taiga-front/conf/conf.example.json /home/taiga/taiga-front/dist/conf.json

# configure nginx
COPY nginx.conf /etc/nginx/nginx.conf

# configure supervisor
COPY supervisord.conf /etc/supervisor/conf.d/supervisord.conf

# volumes
VOLUME ["/home/taiga/taiga-back/static", "/home/taiga/taiga-back/media"]

# configure start
COPY configure-script /configure-script
CMD supervisord -c /etc/supervisor/conf.d/supervisord.conf
