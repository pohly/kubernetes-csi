FROM alpine
LABEL maintainers="Kubernetes Authors"
LABEL description="CSI External Attacher"

COPY _output/csi-attacher csi-attacher
ENTRYPOINT ["/csi-attacher"]
