# fluentd-vcenter-prometheus

Kubernetes ready fluentd container for capturing vCenter logs and pushing entries as metrics to prometheus

---
```
Edit the fluent.conf file to your required settings, or provide one to /etc/fluentd/fluent.conf via configmap

fluentd will recieve logs by default on tcp 5140 on 0.0.0.0
prometheus data will be pushed to 24231 on 0.0.0.0
```