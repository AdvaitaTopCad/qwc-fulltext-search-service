FROM sourcepole/qwc-uwsgi-base:alpine-v2023.06.08

ADD . /srv/qwc_service

# git: Required for pip with git repos
# postgresql-dev g++ python3-dev: Required for psycopg2
# get-pip: Workaround for "ImportError: cannot import name 'PackageFinder'"
RUN \
    apk add --no-cache --update --virtual runtime-deps postgresql-libs && \
    apk add --no-cache --update --virtual build-deps git postgresql-dev g++ python3-dev wget && \
    wget https://bootstrap.pypa.io/get-pip.py && \
    python3 get-pip.py pip && \
    pip3 install --no-cache-dir -r /srv/qwc_service/requirements.txt && \
    apk del build-deps

ENV SERVICE_MOUNTPOINT=/api/v2/search
