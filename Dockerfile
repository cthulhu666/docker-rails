FROM ubuntu:14.04
MAINTAINER jakub.gluszecki@gmail.com

RUN apt-get update && \
    apt-get install -y nginx openssh-server pwgen && \
    apt-get clean

ADD bin/ /usr/sbin/
RUN chmod 755 /usr/sbin/init.sh
RUN chmod 755 /usr/sbin/entrypoint.sh

RUN init.sh

RUN adduser --disabled-password --gecos "Rails" rails

# Make sure we have rights on the rails folder
RUN chown rails -R /home/rails

# USER rails

EXPOSE 22
EXPOSE 80

ENTRYPOINT ["entrypoint.sh"]
CMD ["nginx"]