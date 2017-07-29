FROM jeffreymanning/centos-base

MAINTAINER Jeff Manning

# we inherit USER root from centois-base
# create a zeppelin user (non-root) to execute our build (and run zeppelin?)
RUN groupadd -r zeppelin && useradd --no-log-init -r -g zeppelin zeppelin
RUN usermod -aG wheel zeppelin
RUN useradd --no-log-init -g zeppelin zeppelin-build
RUN usermod -aG wheel zeppelin-build

# this is not docker image is not meant to be run...  it is a base layer
# co-ordinate with spark-base
ARG SPARK_MINOR=2.1
ARG HADOOP_MINOR=2.7
ARG SCALA_VER=2.11

# libfontconfig is a workaround for
# https://github.com/karma-runner/karma/issues/1270, which caused a
# build break similar to
# https://www.mail-archive.com/users@zeppelin.incubator.apache.org/msg01586.html
RUN yum clean all
RUN yum -y update && yum clean all

# pre-reqs
RUN yum -y install openssl openssl-devel python-setuptools python-devel python-boto npm numpy libfontconfig  && yum clean all
RUN curl https://bootstrap.pypa.io/get-pip.py > /tmp/get-pip.py && python /tmp/get-pip.py && pip install -U pip

USER zeppelin-build
ARG ZEPPELIN_REPO=https://github.com/apache/zeppelin.git
ARG ZEPPELIN_TAG=v0.7.2

RUN git clone ${ZEPPELIN_REPO} -b ${ZEPPELIN_TAG} /tmp/zeppelin
RUN cd /tmp/zeppelin && \
    mvn clean package \
        -Pbuild-distr \
        -Pspark-${SPARK_MINOR} \
        -Phadoop-${HADOOP_MINOR} \
        -Pscala-${SCALA_VER} \
        -Pr \
        -Ppyspark \
        -DskipTests && \
  echo "Successfully built Zeppelin"

USER root
RUN cd /tmp/zeppelin/zeppelin-distribution/target/zeppelin-* && \
  mv zeppelin-* zeppelin && \
  tar cvzf /zeppelin.tgz zeppelin

#### Define default command.
#CMD ["bash"]

