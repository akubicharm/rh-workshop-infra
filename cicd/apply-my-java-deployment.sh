#!/bin/sh

# クラスタ確認

oc cluster-info

echo "ok?"
read yn

if [ $yn == "n" ]; then
  echo "bye"
  exit
fi  

mkdir -p ./tmp
for i in {1..2} ; do
  _user=user$i
  echo $_user
  cat my-java-deployment.yaml | sed -e's/user1/'${_user}'/g' > ./tmp/my-java-deployment-user$i.yaml
done

oc login --insecure-skip-tls-verify=false --token=sha256~UEwEVHRye2g62YxBS5ji7uUxVexWQDiYa-ca2WjkzgQ --server=https://api.cluster-z2s2d.z2s2d.sandbox1283.opentlc.com:6443

oc apply -f tmp
