FROM python:3.7-rc-stretch

ENV SINGULARITY_VERSION=2.5.1
ENV BUILD_SOFTWARE="libtool automake"
ENV CONTAINER_SOFTWARE="git squashfs-tools libarchive-dev"
ENV SREGISTRY_GIT="https://github.com/singularityhub/sregistry-cli.git"
ENV SREGISTRY_COMMIT="eed75686aae09739c3dd30ec7e67990d2991c839"
ENV SREGISTRY_CLIENT=registry
ENV CLONE_TMP="clone_dir/"
ENV PIP_INSTALL="requests_toolbelt gitpython iso8601"
ENV AUTOBUILD_GIT="https://github.com/MPIB/SingularityAutobuild" 
ENV AUTOBUILD_VERSION="v0.2.0"
ENV AUTOBUILD_LOCAL_REPO_NAME="autobuild"


RUN apt-get update && \
    apt-get install ${BUILD_SOFTWARE} ${CONTAINER_SOFTWARE} -y && \
    git clone https://github.com/singularityware/singularity.git ${CLONE_TMP}&& \
    cd ${CLONE_TMP} && \
    git checkout ${SINGULARITY_VERSION} && \ 
    bash autogen.sh && \
    bash configure --prefix=/usr/local && \
    make install && \
    cd .. && rm -rf ${CLONE_TMP} && \
    git clone ${SREGISTRY_GIT} ${CLONE_TMP} && \
    cd ${CLONE_TMP} && \
    git checkout ${SREGISTRY_COMMIT} && \
    pip install . && \
    cd .. && rm -rf ${CLONE_TMP} && \
    git clone -b $AUTOBUILD_VERSION $AUTOBUILD_GIT $AUTOBUILD_LOCAL_REPO_NAME && \
    pip install $AUTOBUILD_LOCAL_REPO_NAME/ && \
    rm -rf $AUTOBUILD_LOCAL_REPO_NAME && \
    pip install ${PIP_INSTALL} && \
    apt-get purge ${BUILD_SOFTWARE} -y && \
    apt-get autoclean -y && \
    apt-get autoremove -y && \
    rm -rf /var/lib/apt/lists/* 

ADD ./sregistry_file /sregistry_file
