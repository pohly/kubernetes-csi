[![Build Status](https://travis-ci.org/kubernetes-csi/kubernetes-csi.svg?branch=master)](https://travis-ci.org/kubernetes-csi/drivers)
# CSI Drivers

The "hostpath" driver is the driver maintained by the Kubernetes CSI team for testing purposes.

All other drivers are currently hosted here only until a permanent
home in separate repos can be found.

# Sidecar container apps

The CSI attacher, provisioner and driver registrar integrate a CSI
driver into Kubernetes, as explained in
https://kubernetes-csi.github.io/docs/CSI-Kubernetes.html#sidecar-containers.

# Utility code

The code under `pkg` is meant to be used primarily for use in the
other four components. There's no guarantee that the API will be kept
stable.
