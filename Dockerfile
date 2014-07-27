FROM ubuntu:14.04
MAINTAINER jakub.gluszecki@gmail.com

RUN apt-get update && \
    apt-get install -y supervisor build-essential libssl-dev libreadline6-dev nginx openssh-server pwgen curl git-core && \
    apt-get clean

ADD config/supervisord.conf /etc/supervisor/conf.d/supervisord.conf
ADD bin/ /usr/sbin/
RUN chmod 755 /usr/sbin/init.sh
RUN chmod 755 /usr/sbin/entrypoint.sh
RUN chmod 755 /usr/sbin/install-rbenv.sh

RUN adduser --disabled-password --gecos "Rails" rails

RUN install-rbenv.sh
RUN init.sh

EXPOSE 22 80

ENTRYPOINT ["entrypoint.sh"]
CMD ["/usr/bin/supervisord"]