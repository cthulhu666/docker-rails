FROM cthulhu666/docker-rbenv
MAINTAINER jakub.gluszecki@gmail.com

RUN sudo apt-get update && \
    sudo apt-get install -y supervisor

RUN gem install foreman && rbenv rehash

ADD bin /usr/sbin
RUN sudo chmod 755 /usr/sbin/entrypoint.sh

ENTRYPOINT ["entrypoint.sh"]
CMD ["app:help"]