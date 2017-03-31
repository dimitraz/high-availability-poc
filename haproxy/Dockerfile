FROM jefby/centos-arm64

# Upgrade system, install wget and tar
RUN yum -y update && yum clean all \
    && yum -y upgrade \
    && yum -y install wget \
    && yum -y install tar \
    && yum -y install make

# Build HAProxy from source
RUN wget -O haproxy.tar.gz "http://haproxy.1wt.eu/download/1.7/src/haproxy-1.7.4.tar.gz" \
    && mkdir -p /usr/src/haproxy \
    && tar -xzf haproxy.tar.gz -C /usr/src/haproxy --strip-components=1 \
	&& rm haproxy.tar.gz \
    && yum -y install pcre-devel \
    && make_opts=' \
        TARGET=custom \
        USE_PCRE=1 \
        USE_LIBCRYPT=1 \
        USE_LINUX_SPLICE=1 \
        USE_LINUX_TPROXY=1 \
	'

# Install
RUN make /usr/src/haproxy $make_opts \
    && mkdir -p /usr/local/etc/haproxy \
	&& cp -R /usr/src/haproxy/examples/errorfiles /usr/local/etc/haproxy/errors \
	&& rm -rf /usr/src/haproxy

# Copy configuration file
COPY haproxy.cfg /usr/local/etc/haproxy/haproxy.cfg

CMD ["haproxy", "-f", "/usr/local/etc/haproxy/haproxy.cfg"]
