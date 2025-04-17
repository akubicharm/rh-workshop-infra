# Ehterpad-lite

バックエンドにDBサーバが必要。

## SCCの設定

Dockerhubで公開されているコンテナイメージは、実行時のUIDが固定されているのでsccの設定が必要

```
oc adm policy add-scc-to-user anyuid -z default
```

## アプリケーションのデプロイ

```
oc apply -k .
```
