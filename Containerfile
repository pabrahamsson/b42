FROM registry.access.redhat.com/ubi10/nginx-126:10.0

#USER 0
#RUN dnf upgrade --refresh -y && \
#    dnf clean all

USER 1001
ADD --chown=1001:0 public /tmp/src

RUN /usr/libexec/s2i/assemble

CMD /usr/libexec/s2i/run
