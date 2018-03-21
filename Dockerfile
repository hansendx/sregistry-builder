FROM python:3.7-rc-stretch

ENV SINGULARITY_VERSION=2.4.3
ENV BUILD_SOFTWARE="git libtool automake"
ENV CONTAINER_SOFTWARE="squashfs-tools libarchive-dev"
ENV SREGISTRY_COMMIT="cb595c0b3371514c648b1844a914f861fb842d4f"
ENV SREGISTRY_CLIENT=registry

RUN apt-get update && \
    apt-get install ${BUILD_SOFTWARE} ${CONTAINER_SOFTWARE} -y && \
    git clone https://github.com/singularityware/singularity.git && \
    cd singularity/ && \
    git checkout ${SINGULARITY_VERSION} && \ 
    bash autogen.sh && \
    bash configure --prefix=/usr/local && \
    make install && \
    cd .. && rm -rf singularity/ && \
    git clone https://www.github.com/singularityhub/sregistry-cli.git && \
    cd sregistry-cli && \
    git checkout ${SREGISTRY_COMMIT} && \
    python setup.py install && \
    cd .. && rm -rf sregistry-cli && \
    pip install requests_toolbelt && \
    apt-get purge ${BUILD_SOFTWARE} -y && \
    apt-get autoclean -y && \
    apt-get autoremove -y && \
    rm -rf /var/lib/apt/lists/* 

ADD ./sregistry_file /sregistry_file

ENTRYPOINT [ "bash" ]
