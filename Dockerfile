FROM python:3.7-rc-stretch

ENV SINGULARITY_VERSION=2.5.1
ENV BUILD_SOFTWARE="libtool automake"
ENV CONTAINER_SOFTWARE="git squashfs-tools libarchive-dev"
ENV SREGISTRY_COMMIT="cb595c0b3371514c648b1844a914f861fb842d4f"
ENV SREGISTRY_CLIENT=registry
ENV PIP_INSTALL="requests_toolbelt gitpython iso8601 sregistry"
ENV AUTOBUILD_GIT="https://github.com/MPIB/SingularityAutobuild" 
ENV AUTOBUILD_VERSION="v0.1.0"
ENV AUTOBUILD_LOCAL_REPO_NAME="autobuild"


RUN apt-get update && \
    apt-get install ${BUILD_SOFTWARE} ${CONTAINER_SOFTWARE} -y && \
    git clone https://github.com/singularityware/singularity.git && \
    cd singularity/ && \
    git checkout ${SINGULARITY_VERSION} && \ 
    bash autogen.sh && \
    bash configure --prefix=/usr/local && \
    make install && \
    cd .. && rm -rf singularity/ && \
    git clone -b $AUTOBUILD_VERSION $AUTOBUILD_GIT $LOCAL_REPO_NAME && \
    pip install $LOCAL_REPO_NAME && \
    cd .. && rm -rf $LOCAL_REPO_NAME && \
    pip install ${PIP_INSTALL} && \
    apt-get purge ${BUILD_SOFTWARE} -y && \
    apt-get autoclean -y && \
    apt-get autoremove -y && \
    rm -rf /var/lib/apt/lists/* 

ADD ./sregistry_file /sregistry_file
