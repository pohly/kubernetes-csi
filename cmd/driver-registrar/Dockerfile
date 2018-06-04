FROM alpine
LABEL maintainers="Kubernetes Authors"
LABEL description="CSI Driver registrar"

COPY _output/driver-registrar driver-registrar
ENTRYPOINT ["/driver-registrar"]
