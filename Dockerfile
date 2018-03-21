FROM python:3.7-rc-stretch

ENV singularity_version=2.4.3
ENV build_software="git libtool automake"
ENV container_software="squashfs-tools libarchive-dev"

RUN apt-get update && \
    apt-get install ${build_software} ${container_software} -y && \
    git clone https://github.com/singularityware/singularity.git && \
    cd singularity/ && \
    git checkout ${singularity_version} && \ 
    bash autogen.sh && \
    bash configure --prefix=/usr/local && \
    make install && \
    cd .. && rm -rf singularity/ && \
    apt-get purge ${build_software} -y && \
    apt-get autoclean -y && \
    apt-get autoremove -y && \
    rm -rf /var/lib/apt/lists/* 

ENTRYPOINT [ "bash" ]
