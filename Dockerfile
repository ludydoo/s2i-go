# myapp
FROM golang:1.18

LABEL maintainer="ludovic.cleroux@gmail.com"

ENV BUILDER_VERSION 0.1
ENV HOME /opt/app-root
ENV GOPATH $HOME/go
ENV PATH $PATH:$GOROOT/bin

LABEL io.k8s.description="Platform for building golang applications" \
      io.k8s.display-name="gobuild 0.0.1" \
      io.openshift.expose-services="8080:http" \
      io.openshift.tags="gobuild,0.0.1" \
      io.openshift.s2i.scripts-url="image:///usr/libexec/s2i" \
      io.openshift.s2i.destination="/opt/app-root/destination"


RUN groupadd -r -g 1001 default && \
    useradd -u 1001 -r -g 1001 -d ${HOME} -s /sbin/nologin -c "Default Application User" default && \
    mkdir -p /opt/app-root/destination/src && \
    mkdir -p /opt/app-root/destination/artifacts && \
    chown -R 1001:1001 ${HOME} && \
    chmod -R og+rwx ${HOME}
COPY --chown=1001:1001 ./s2i/bin/ /usr/libexec/s2i 
WORKDIR $HOME
USER 1001

# TODO: Set the default CMD for the image
CMD ["/usr/libexec/s2i/usage"]
