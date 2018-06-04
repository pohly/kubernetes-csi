FROM alpine
LABEL maintainers="Kubernetes Authors"
LABEL description="HostPath Driver"

COPY ./_output/hostpath /hostpathplugin
ENTRYPOINT ["/hostpathplugin"]
