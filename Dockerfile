FROM centos:7.1.1503

RUN buildDeps='make gcc gcc-c++ git tar unzip gtest libevent clang libstdc++-static'; \
    set -x \
    && yum install -y $buildDeps \
    && yum clean -y all && rm -rf /var/cache/yum/* \
    && cd /root/ \
    && curl -L https://github.com/sunyi00/redis-cerberus/archive/master.zip -o redis-cerberus.zip \
    && unzip redis-cerberus.zip \
    && rm redis-cerberus.zip \
    && cd redis-cerberus-master/ \
    && make MODE=debug STATIC_LINK=1 \
    && mkdir -p /cerberus/bin /cerberus/conf \
    && cp -f cerberus /cerberus/bin/ \
    && cp -f example.conf /cerberus/conf/cerberus.conf \
    && cd /root/ \
    && rm -rf /root/redis-cerberus-master/
    && yum remove -y $buildDeps

EXPOSE 8889
CMD [ "/cerberus/bin/cerberus /cerberus/conf/cerberus.conf" ]
