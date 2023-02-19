# helm_basic
...

# Commands 
helm repo add [NAME] [URL]
helm repo list 
helm repo remove [NAME]

# lokal      
helm search repo [NAME]
helm search repo mysql 
helm search repo [NAME] --versions 

# global
helm search hub [NAME]  

# number of nginx charts inside hub. 
helm search hub nginx | wc -l 

# install bitnami redis v17.7 chart  on redis nameSpace 
helm repo add bitnami https://charts.bitnami.com/bitnami
helm install my-redis bitnami/redis --version 17.7.5 -n redis  
helm status my-redis 

# list all deployment from helm on all namespace 
helm list -A 

NOT: ayni isimde deployment yapilamamaktadir. Bundan dolayi deploymentlara uniq isimler vermek saglikli olacaktir. 
Farkli nameSpacelerde ayni isimleri verebiliriz. Sonucta her nameSpace sanal nodelar olarak dusunebiliriz. 

# helm fetch 
helm fetch komutu, bir Helm chart'ının paket dosyasını indirmek için kullanılır.
helm fetch <chart-name> --version <chart-version> --repo <repo-url>
helm fetch <chart-name> --version <chart-version>
helm fetch nginx --version 1.2.3

tar -xzf dosyaadi.tgz
tar -xf dosyaadi.tar

