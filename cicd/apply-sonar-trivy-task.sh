#!/bin/sh

# クラスタ確認

oc login --insecure-skip-tls-verify=false --token=sha256~UEwEVHRye2g62YxBS5ji7uUxVexWQDiYa-ca2WjkzgQ --server=https://api.cluster-z2s2d.z2s2d.sandbox1283.opentlc.com:6443

oc cluster-info
oc get projects |grep cicd-

echo "continue? y or n"
read yn

if [ $yn == "n" ]; then
  echo "bye"
  exit
fi  

#FLAG_DRY_RUN="--dry-run=client"
FLAG_DRY_RUN=""

for i in {1..2} ; do
  ns=cicd-user$i
  echo $ns
#  oc apply -f sonarqube-scanner-task.yaml -n $ns $FLAG_DRY_RUN
  oc apply -f trivy-scanner-task.yaml -n $ns $FLAG_DRY_RUN
#  oc apply -f sonar-properties.yaml -n $ns $FLAG_DRY_RUN
done

