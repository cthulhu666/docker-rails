FROM cthulhu666/docker-rbenv
MAINTAINER jakub.gluszecki@gmail.com

RUN sudo apt-get update && \
    sudo apt-get install -y supervisor

RUN gem install foreman && rbenv rehash

ADD config /config

ADD bin /usr/sbin
RUN sudo chmod 755 /usr/sbin/entrypoint.sh && \
    sudo chmod 755 /usr/sbin/bundle-install.sh

EXPOSE 8080

#ONBUILD ADD . /home/rails/rails-app
#ONBUILD RUN chown -R rails:rails /home/rails/rails-app
#ONBUILD RUN ["bundle-install.sh"]

ENTRYPOINT ["entrypoint.sh"]
CMD ["app:help"]