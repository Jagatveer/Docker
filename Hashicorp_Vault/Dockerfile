FROM        centos:6.6
MAINTAINER  Jagatveer Singh <Jagatveer Singh>

ENV VERSION "0.6.0"
ENV CONFIG /usr/local/etc/vault-config.hcl
ENV INITFILE /etc/init.d/vault

RUN \
          yum clean all \
          && yum check \
          && yum upgrade -y \
          && yum install unzip -y

ADD https://releases.hashicorp.com/vault/${VERSION}/vault_${VERSION}_linux_amd64.zip /tmp/vault_${VERSION}_linux_amd64.zip
RUN unzip -o /tmp/vault_${VERSION}_linux_amd64.zip -d /usr/bin/ && rm /tmp/vault_${VERSION}_linux_amd64.zip

COPY conf/vault-config.hcl $CONFIG
COPY conf/vault $INITFILE

RUN \
      chmod 0755 $INITFILE \
      && echo "export VAULT_ADDR='http://0.0.0.0:8200'" >> /etc/profile

EXPOSE 8200
CMD vault start
