## Use provided spark installation ##
## defining SPARK_HOME makes Zeppelin run spark interpreter process using spark-submit
##
## spark-base defines this environment variable
## SPARK_HOME, When it is defined, load it instead of Zeppelin embedded Spark libraries
##
## this will eliminate zeppelin/spark version  mismatches (typically on connect)
FROM jeffreymanning/spark-base

MAINTAINER Jeff Manning

# well, this needs to be addressed...
# allow containers withs with USER root to getr root privs
# requires:
# oc admin policy add-scc-to-user anyuid -z default -n <namespace installed into>
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
# minimal install (can add interpreters as required)
ARG ZEPPELIN_MIN_PKG_NAME=zeppelin-${ZEPPELIN_VERSION}-bin-netinst

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
    && mkdir -p ${ZEPPELIN_HOME}/logs chmod a+rw ${ZEPPELIN_HOME}/logs \
    && mkdir -p ${ZEPPELIN_HOME}/run chmod a+rw ${ZEPPELIN_HOME}/run \
    && rm -f ${ZEPPELIN_PKG_NAME}.tgz


#### Define default command.
VOLUME ${ZEPPELIN_HOME}/notebook
VOLUME ${ZEPPELIN_HOME}/conf
VOLUME ${ZEPPELIN_HOME}/data

### change the ownership
# change ownership to the spark process (non-root)
#RUN groupadd -r zeppelin && useradd --no-log-init -r -g zeppelin zeppelin
#RUN usermod -aG wheel zeppelin
#RUN usermod -aG spark zeppelin
#RUN chown -R -L zeppelin:zeppelin ${ZEPPELIN_HOME}

# set the working directory
#USER zeppelin

# Make the default PWD somewhere that the user can write. This is
# useful when connecting with 'oc run' and starting a 'spark-shell',
# which will likely try to create files and directories in PWD and
# error out if it cannot.
#WORKDIR /tmp
WORKDIR ${ZEPPELIN_HOME}

CMD ["/opt/zeppelin/bin/zeppelin.sh"]

