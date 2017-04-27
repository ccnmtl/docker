FROM debian:jessie
RUN apt-get update && apt-get install -qyy \
		-o APT::Install-Recommends=false -o APT::Install-Suggests=false \
		curl \
		libjpeg-dev \
		postgresql-client \
		python-imaging \
		python-pip \
		python-setuptools \
		openssl \
&& curl -sL https://deb.nodesource.com/setup_6.x -o /tmp/nodesetup.sh \
&& /bin/bash /tmp/nodesetup.sh \
&& apt-get install -qyy nodejs \
&& apt-get clean \
&& rm -rf /var/lib/apt/lists/*
ENV PYTHONUNBUFFERED 1
RUN ln -s /usr/bin/nodejs /usr/local/bin/node \
&& pip install virtualenv \
&& virtualenv /ve \
&& /ve/bin/pip install -U pip \
&& mkdir -p /requirements/src/
COPY files/pysqlite-2.6.3.tar.gz /requirements/src/pysqlite-2.6.3.tar.gz
