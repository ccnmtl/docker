FROM ccnmtl/django.base

RUN apt-get update && apt-get install -qy \
		binutils \
		build-essential \
		gcc \
		libffi-dev \
		libssl-dev \
		libexif-dev \
		libexif12 \
		libfontconfig1-dev \
		libfreetype6-dev \
		libldap2-dev \
		libpq-dev  \
		libsasl2-dev \
		libspatialite-dev \
		libsqlite3-dev \
		libssl-dev \
		libxft-dev \
		libxml2-dev \
		libxslt1-dev \
		python-all-dev \
		python-dev \
		python-beautifulsoup \
		python-ldap \
		python-pysqlite2 \
		python-tk \
&& apt-get clean \
&& rm -rf /var/lib/apt/lists/*

RUN /ve/bin/pip install wheel

ENV WHEELHOUSE=/wheelhouse
ENV PIP_WHEEL_DIR=/wheelhouse
ENV PIP_FIND_LINKS=/wheelhouse

VOLUME /wheelhouse
VOLUME /app

ENTRYPOINT cd /app; /ve/bin/pip wheel -r requirements.txt
