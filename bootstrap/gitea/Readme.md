# Gitea

## 管理ユーザの作成

GiteaのPodにrshして、実行
```
/home/gitea/gitea admin user create --username gitea --password openshift --email me@example.com --admin --config ./config/app.ini
```


## ユーザの追加
for i in {1..14} ; do
  user=user$i
  /home/gitea/gitea admin user create --username $user --password openshift --email $user@example.com --must-change-password=false --config ./conf/app.ini
done



GitHubのリポジトリからインポートする

vscodeでimport.http を開いてRestRequestで作成