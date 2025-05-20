Tektonのパイプラインから利用する場合、ログインID/パスワードをconfigmapに保存しておく。

sonar-project.properties
```
sonar.login=admin
sonar.password=sonarqube
sonar.exclusions=**/*.java
```

kubectl create configmap sonar-properties --from-file="sonar-project.properties"


ScanのTaskの
source は Pipeline全体で共有するPVを
sonar-settings は、上記のconfigmapを設定する。


---あとで完成したyamlを貼る---