FROM alpine
LABEL maintainers="Kubernetes Authors"
LABEL description="CSI External Provisioner"

COPY _output/csi-provisioner csi-provisioner
ENTRYPOINT ["/csi-provisioner"]
