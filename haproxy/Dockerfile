# FROM jefby/centos-arm64
FROM centos:7

# Upgrade system, install wget and tar
RUN yum -y update && yum clean all \
    && yum -y upgrade \
    && yum -y install wget \
    && yum -y install tar \
    && yum -y install make \
    && yum -y install keepalived \
    && yum -y install gcc \
    && yum -y install pcre-devel 

# Build HAProxy from source
RUN mkdir -p /usr/local/haproxy
COPY ./haproxy.tar.gz /usr/local/haproxy
RUN tar -xvf /usr/local/haproxy/haproxy.tar.gz -C /usr/local/haproxy --strip-components=1 \
    && make_opts=' \
        TARGET=custom \
        USE_PCRE=1 \
        USE_LIBCRYPT=1 \
        USE_LINUX_SPLICE=1 \
        USE_LINUX_TPROXY=1 \
	' \
    && cd /usr/local/haproxy \
    && make $make_opts \
    && rm haproxy.tar.gz 

# Copy configuration file
WORKDIR /usr/local/haproxy
COPY haproxy.cfg /usr/local/haproxy/haproxy.cfg

RUN echo "net.ipv4.ip_nonlocal_bind=1" > /etc/sysctl.conf \
    && sysctl -p

CMD ["./haproxy", "-f", "/usr/local/haproxy/haproxy.cfg"]
