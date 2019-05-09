FROM alpine:3.7
MAINTAINER Josh VanderLinden <codekoala@gmail.com>

RUN apk update && \
    apk add py3-pip && \
    pip3 install --upgrade pip && \
    mkdir -p /srv/pypi

RUN pip install -U passlib pypiserver[cache]==1.2.1

EXPOSE 80
#VOLUME ["/srv/pypi"]

COPY requirements.txt ./
##RUN pip install -t /srv/pypi -r requirements.txt
RUN pip install pip2pi
RUN pip2tgz /srv/pypi/ -r requirements.txt

ADD entrypoint.sh /
CMD ["/entrypoint.sh"]
