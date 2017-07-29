FROM jeffreymanning/centos-base

MAINTAINER Jeff Manning

USER root

#install the basic packages
RUN yum clean all && \
    yum -y update && \
    yum clean all

# from centos: tar curl net-tools build-essential git wget zip unzip vim
# pre-reqs
RUN yum -y install wget gcc openssl openssl-devel python-setuptools python-devel python-boto npm numpy libfontconfig  && yum clean all
RUN curl https://bootstrap.pypa.io/get-pip.py > /tmp/get-pip.py && python /tmp/get-pip.py && pip install -U pip
# requirements
###python
COPY requirements.txt /tmp
RUN pip install -r /tmp/requirements.txt

### Host Arguments
# zeppelin
ARG ZEPPELIN_MAJOR_VERSION=0
ARG ZEPPELIN_UPDATE_VERSION=7
ARG ZEPPELIN_BUILD_NUMBER=2
ARG ZEPPELIN_VERSION=${ZEPPELIN_MAJOR_VERSION}.${ZEPPELIN_UPDATE_VERSION}.${ZEPPELIN_BUILD_NUMBER}
ARG ZEPPELIN_DOWNLOAD_URL=https://www.apache.org/dist/zeppelin
ARG ZEPPELIN_INSTALL_DIR=/opt
ARG ZEPPELIN_HOME=${ZEPPELIN_INSTALL_DIR}/zeppelin
ARG ZEPPELIN_PKG_NAME=zeppelin-${ZEPPELIN_VERSION}-bin-all

### Host environment
ENV ZEPPELIN_HOME=${ZEPPELIN_HOME}
ENV ZEPPELIN_CONF_DIR=${ZEPPELIN_HOME}/conf
ENV ZEPPELIN_DATA_DIR=${ZEPPELIN_HOME}/data
ENV ZEPPELIN_NOTEBOOK_DIR=${ZEPPELIN_HOME}/notebook

###  Start of Installation

#### ---- Zeppelin Installation -----
WORKDIR ${ZEPPELIN_INSTALL_DIR}

#### ---- (Deployment mode use) Zeppelin Installation (Download from Internet -- Deployment) ----
RUN wget -c ${ZEPPELIN_DOWNLOAD_URL}/zeppelin-${ZEPPELIN_VERSION}/${ZEPPELIN_PKG_NAME}.tgz \
    && tar xvf ${ZEPPELIN_PKG_NAME}.tgz \
    && ln -s ${ZEPPELIN_PKG_NAME} zeppelin \
    && mkdir -p ${ZEPPELIN_HOME}/logs && mkdir -p ${ZEPPELIN_HOME}/run \
    && rm -f ${ZEPPELIN_PKG_NAME}.tgz


#### Define default command.
VOLUME ${ZEPPELIN_HOME}/notebook
VOLUME ${ZEPPELIN_HOME}/conf
VOLUME ${ZEPPELIN_HOME}/data

WORKDIR ${ZEPPELIN_HOME}

CMD ["/opt/zeppelin/bin/zeppelin.sh"]

