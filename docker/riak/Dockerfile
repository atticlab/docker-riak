FROM ubuntu:trusty

RUN \
    # Install Java 7
    sed -i.bak 's/main$/main universe/' /etc/apt/sources.list \
    && apt-get update -qq && apt-get install -y software-properties-common curl \
    && apt-add-repository ppa:webupd8team/java -y && apt-get update -qq \
    && echo oracle-java7-installer shared/accepted-oracle-license-v1-1 select true | /usr/bin/debconf-set-selections \
    && apt-get install -y oracle-java7-installer \

    # Install Riak
    && curl -fsSL https://packagecloud.io/install/repositories/basho/riak/script.deb | sudo bash \
    && apt-get install -y supervisor riak=2.0.5-1 \

    # Cleanup
    && apt-get clean && rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*

RUN locale-gen en_US en_US.UTF-8

ADD supervisord.conf /etc/supervisor/conf.d/supervisord.conf
ADD entrypoint.sh /

RUN echo "anti_entropy.concurrency_limit = 1" >> /etc/riak/riak.conf \
    && echo "javascript.map_pool_size = 0" >> /etc/riak/riak.conf \
    && echo "javascript.reduce_pool_size = 0" >> /etc/riak/riak.conf \
    && echo "javascript.hook_pool_size = 0" >> /etc/riak/riak.conf \
    && echo "erlang.distribution.port_range.minimum = 6000" >> /etc/riak/riak.conf \
    && echo "erlang.distribution.port_range.maximum = 6001" >> /etc/riak/riak.conf

# Expose Riak Protocol Buffers and HTTP interfaces
EXPOSE 8087 8098

CMD ["/entrypoint.sh"]