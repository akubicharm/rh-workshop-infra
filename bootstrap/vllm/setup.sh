#!/bin/bash

# scale-up default machineset
machineset=$(oc get machineset -n openshift-machine-api | grep -v NAME | head -n 1 | awk '{print $1}')
#oc scale machineset/${machineset} -n openshift-machine-api --replicas=3
#oc wait --for jsonpath='{.status.availableReplicas}'=3 --timeout 20m machineset/${machineset} -n openshift-machine-api

# create GPU machineset
oc get machineset/${machineset} -o yaml -n openshift-machine-api > gpu.yaml
sed -e "s/${machineset}/${machineset}g/g" gpu.yaml > 1.yaml
sed -e "s/instanceType: .*/instanceType: g5.xlarge/g" 1.yaml > 2.yaml
#sed -e "s/replicas: .*/replicas: 2/g" gpu_machineset.yaml
sed -e "s/replicas: .*/replicas: 1/g" 2.yaml > gpu_machinset.yaml


exit

oc apply -f /tmp/gpu_machineset.yaml
rm -f /tmp/gpu_machineset.yaml

while true; do oc get machineset/${machineset}g -n openshift-machine-api 2>&1 | grep "not found" 1>/dev/null 2>&1; if [ $? -eq 0 ]; then echo "machineset/${machineset}g does not exist yet. waiting..."; sleep 3; continue; else break; fi; done
#oc wait --for jsonpath='{.status.availableReplicas}'=2 --timeout 30m machineset/${machineset}g -n openshift-machine-api
oc wait --for jsonpath='{.status.availableReplicas}'=1 --timeout 30m machineset/${machineset}g -n openshift-machine-api

