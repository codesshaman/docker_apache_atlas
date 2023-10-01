# FROM maven:3.8.6-openjdk-8 AS builder
# FROM centos:centos8.4.2105
# FROM maven:3.9.4-eclipse-temurin-8-alpine
FROM maven:3.9.4-eclipse-temurin-11-alpine

ENV ATLAS_VERSION 2.3.0
ENV TARBALL apache-atlas-${ATLAS_VERSION}-sources.tar.gz
# ENV	ATLAS_REPO      https://dist.apache.org/repos/dist/release/atlas/${ATLAS_VERSION}/${TARBALL}
ENV ATLAS_REPO	https://dlcdn.apache.org/atlas/${ATLAS_VERSION}/apache-atlas-${ATLAS_VERSION}-sources.tar.gz
ENV	MAVEN_OPTS	"-Xms2g -Xmx2g"
# ENV MAVEN_OPTS="--add-exports jdk.compiler/com.sun.tools.javac.api=ALL-UNNAMED ${MAVEN_OPTS}"

# COPY atlas.tar.xz /tmp

# RUN cd tmp && mkdir atlas_src && tar -xvf atlas.tar.xz -C atlas_src && cd atlas_src
# RUN sed -i 's/mirrorlist/#mirrorlist/g' /etc/yum.repos.d/CentOS-* && \
# 	sed -i 's|#baseurl=http://mirror.centos.org|baseurl=http://vault.centos.org|g' /etc/yum.repos.d/CentOS-*


# RUN yum update -y && yum -y install \
# 	java-11-openjdk-devel \
# 	python3 \
# 	maven  \
# 	unzip \
# 	patch \
# 	wget

RUN apk update && apk add -y --no-cache \
	python3 \
	nodejs \
	unzip \
	patch \
	wget \
	npm

RUN cd /tmp && wget --no-check-certificate ${ATLAS_REPO} && \
	mkdir /tmp/atlas_src && tar -xzf ${TARBALL} -C /tmp/atlas_src --strip 1

# COPY pom.xml /tmp/atlas_src/pom.xml

# RUN	mvn -U \
# 		-DskipTests \
# 		-Drat.skip=true \
# 		-Drat.numUnapprovedLicenses=200 \
# 		-Dmaven.wagon.http.ssl.insecure=true \
# 		-Dmaven.wagon.http.ssl.ignore.validity.dates=true \
# 		clean install 

	# sed -i 's!<version>2.6</version>!<version>3.3.2</version>!1' /tmp/atlas_src/pom.xml
	# cd /tmp/atlas_src && mvn clean -DskipTests package -Pdist | grep -n "" | awk 'NR % 3 == 0'
# RUN cd tmp/atlas_src && ls && mv distro/target/apache-atlas-*-bin.tar.gz /apache-atlas.tar.gz && \
# RUN cd tmp/atlas_src && ls && mv distro/target/apache-atlas-*-kafka-hook.tar.gz /apache-atlas-kafka-hook.tar.gz && \
# RUN cd tmp/atlas_src && ls && mv distro/target/apache-atlas-*-hive-hook.tar.gz /apache-atlas-hive-hook.tar.gz && \
# RUN cd tmp/atlas_src && ls && mv distro/target/apache-atlas-*-sqoop-hook.tar.gz /apache-atlas-sqoop-hook.tar.gz

# FROM centos:7

# COPY --from=stage-atlas /apache-atlas.tar.gz /apache-atlas.tar.gz
# COPY --from=stage-atlas /apache-atlas-kafka-hook.tar.gz /apache-atlas-kafka-hook.tar.gz
# COPY --from=stage-atlas /apache-atlas-hive-hook.tar.gz /apache-atlas-hive-hook.tar.gz
# COPY --from=stage-atlas /apache-atlas-sqoop-hook.tar.gz /apache-atlas-sqoop-hook.tar.gz

# # install which - GUS 10.5
# RUN yum update -y  \
# 	&& yum install -y python python36 && yum install java-1.8.0-openjdk java-1.8.0-openjdk-devel python net-tools -y \
# 	&& yum install which -y \
# 	&& yum clean all 
# RUN groupadd hadoop && \
# 	useradd -m -d /opt/atlas -g hadoop atlas

# RUN pip3 install amundsenatlastypes

# USER atlas

# RUN cd /opt \
# 	&& tar xzf /apache-atlas.tar.gz -C /opt/atlas --strip-components=1

# COPY model /tmp/model
# COPY resources/atlas-setup.sh /tmp
# COPY resources/credentials /tmp
# COPY resources/init_amundsen.py /tmp

# COPY resources/atlas-application.properties /opt/atlas/conf/

# USER root
# ADD resources/entrypoint.sh /entrypoint.sh
# RUN rm -rf /apache-atlas.tar.gz

# USER atlas

# ENTRYPOINT ["sh", "-c", "/entrypoint.sh"]

# EXPOSE 21000

CMD sleep 3600