FROM centos:latest
LABEL maintainer="Cristian Muñiz <daelvn@gmail.com>"
# Versions
ARG LUAROCKS_VERSION="3.0.4"
ARG RESTY_VERSION="1.13.6.2"

# Necessary files
ADD OpenResty.repo /etc/yum.repos.d/OpenResty.repo
ADD docker-entrypoint.sh /usr/local/bin/docker-entrypoint.sh

# Install from repos
RUN yum -y update; yum clean all
RUN yum -y install epel-release; yum clean all
RUN yum -y install \
  dos2unix \
  gcc \
  git \
  luajit \
  luajit-devel \
  make \
  openresty-${RESTY_VERSION} \
  openresty-opm-${RESTY_VERSION} \
  openresty-resty-${RESTY_VERSION} \
  openssl \
  openssl-devel \
  unzip; \
  yum clean all

# Make executable
RUN chmod +x /usr/local/bin/docker-entrypoint.sh
RUN dos2unix /usr/local/bin/docker-entrypoint.sh

# Install LuaRocks
RUN cd /tmp  && \
	curl -fSL https://luarocks.org/releases/luarocks-${LUAROCKS_VERSION}.tar.gz -o luarocks-${LUAROCKS_VERSION}.tar.gz && \
	tar xzf luarocks-${LUAROCKS_VERSION}.tar.gz && \
	cd luarocks-${LUAROCKS_VERSION} && \
	./configure \
		--prefix=/usr \
		--lua-suffix=jit \
		--with-lua-include=/usr/include/luajit-2.0 && \
	make build && \
	make install && \
	cd /
RUN rm /tmp/* -r

# Install rocks
RUN luarocks install luasec
RUN luarocks install bcrypt
RUN luarocks install lapis
RUN luarocks install md5
RUN luarocks install moonscript
RUN luarocks install i18n

# Link OpenResty logs to /dev
RUN ln -sf /dev/stdout /usr/local/openresty/nginx/logs/access.log
RUN ln -sf /dev/stderr /usr/local/openresty/nginx/logs/error.log

# Update PATH
ENV PATH=$PATH:/root/.luarocks/bin:/usr/bin:/usr/local/sbin:/usr/local/bin:/usr/sbin:/sbin:/bin:/usr/local/openresty/luajit/bin/:/usr/local/openresty/nginx/sbin/:/usr/local/openresty/bin/

# Update cache
RUN ldconfig

ENTRYPOINT ["/usr/local/bin/docker-entrypoint.sh"]
