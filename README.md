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

# helm list -A 
list all deployment from helm on all namespace 

NOT: ayni isimde deployment yapilamamaktadir. Bundan dolayi deploymentlara uniq isimler vermek saglikli olacaktir. 
Farkli nameSpacelerde ayni isimleri verebiliriz. Sonucta her nameSpace sanal nodelar olarak dusunebiliriz. 

# helm fetch 
helm fetch komutu, bir Helm chart'ının paket dosyasını indirmek için kullanılır.
helm fetch <chart-name> --version <chart-version> --repo <repo-url>
helm fetch <chart-name> --version <chart-version>
helm fetch nginx --version 1.2.3

tar -xzf dosyaadi.tgz
tar -xf dosyaadi.tar

# helm uninstall ve helm delete arasindaki fark nedir 
helm delete ve helm uninstall Helm komutlarının ikisi de bir chart'ın kaldırılması için kullanılır. Ancak, helm delete ve helm uninstall komutları arasındaki fark, helm delete komutunun, bir chart'ı kaldırırken yan etkileri de olabilen birkaç ekstra adım gerçekleştirmesidir.

helm delete, bir chart'ın silinmesi için aşağıdaki adımları gerçekleştirir:

Chart kaynakları silinir (Pod'lar, Servisler, vb.).
Tiller'ın saklama alanından kayıt silinir.
Kaynakların Kubernetes'ten silinmesini onaylamak için kullanıcıya bir istek gösterilir.
Öte yandan, helm uninstall komutu yalnızca chart kaynaklarını siler ve kullanıcıya silme işleminin başarıyla tamamlandığına dair bir çıktı sağlar.

Bu nedenle, genellikle helm uninstall tercih edilir, çünkü chart'ın kaldırılması sırasında yan etkilerin oluşması mümkün değildir. Ancak, helm delete komutu bazı durumlarda faydalı olabilir, örneğin kaynakların yanı sıra Tiller'ın saklama alanından kaydı da silmeniz gerektiğinde.

# helm repo update --debug
localde var olan repolari guncellerken olusan loglari daha detayli sekilde gosterecektir. 

# helm template <PATH>
Any values that would normally be looked up or retrieved in-cluster will be
faked locally. Additionally, none of the server-side testing of chart validity

Lokalde bulunan helmChart dosyalarinin yaml formatinda cikti vermesini saglar. 

# helm package <PATH>
This command packages a chart into a versioned chart archive file. If a path
is given, this will look at that path for a chart (which must contain a
Chart.yaml file) and then package that directory.

helm chart dosyalarini .tgz formatinda paketler. Dogrudan paketlenen dosyayi install edebiliriz. 

# helm repo update 
localde bulunan helm chart repolarini gunceller. 

# upgrade 
NOT: Eger upgrade komutunu --values input.yaml gibi bir dosyayla calistirmazsak default degerlerle upgrade islemi yapilacaktir. 
Bundan dolayi bu ayrinti gozden kacilirilmamalidir. 

- upgrade 2 durumda yapilir: 
1- input.yaml dosyasinda degisiklik yapilacagi zaman 
2- chartin versiyonu degistirilecegi zaman 
Sifre sorabilir bu guncelleme sirasinda. Eger input.yaml dosyasinda sifre varsa tekrar sifre sormayacaktir. 

-----------------------------------------------------------------------------
# Install MariaDB on app namespace 
helm install my-mariadb bitnami/mariadb --version 11.4.7 -n helm 
helm status -n helm my-mariadb #we can see logs after installation. 
helm upgrade -n helm 

create mariadb-custom.yaml file 
helm install my-mariadb bitnami/mariadb --version 11.4.7 -n test --values mariadb-custom.yaml
helm install my-mariadb bitnami/mariadb --version 11.4.7 -n app -f mariadb-custom.yaml

kubectl get secret --namespace test my-mariadb -o jsonpath="{.data.mariadb-root-password}" | base64 -d
values.yamldaki rootpassword oldugu goruntulenir. 

-----------------------------------------------------------------------------
### Use HELM at Next Level #### 

### Helm Deployment WorkFlow 
1- Load Charts And Dependecies 
2- Parse the Values to YAML File 
3- Generate YAML File 
4- Parse YAMLs to Kube Object & Validate 
5- Send Validates YAML to K8s 

### Validate Resources before Deployment 
- Aslinda Helm deploy etmeden once dogrulama ihtiyaci yoktur. Cunku helm zaten Deploymenttan once Validate islemini kendisi gerceklestirmektedir. 
# Dry Run Before Deployment 
helm install my-mariadb bitnami/mariadb --version 11.4.7 -n test --values mariadb-custom.yaml --dry-run 
helm install my-mariadb bitnami/mariadb --version 11.4.7 -n test --values mariadb-custom.yaml --dry-run  > mariaDb_helm.yaml 

# direk deploy edilecek yaml file verir. 
helm template my-mariadb bitnami/mariadb --version 11.4.7 -n test --values mariadb-custom.yaml

Bu islem yaoildiktan sonra STATU: pending-deploy seklinde bekler. 
Tum objeleri - resourceleri bunun ciktisinda goruruz. 

# Details of HELM Deployment Releases 
helm install my-mariadb bitnami/mariadb --version 11.4.7 -n test --values mariadb-custom.yaml 

<!-- mariadb-custom.yaml  dosyasinda password degisikligi yaparak helmCharti guncelleyelim.  -->
helm upgarede my-mariadb bitnami/mariadb --version 11.4.7 -n test --values mariadb-custom.yaml 
Deployment Revision: 2
kubectl get secrets -n test
my-mariadb 
sh.helm.release.v1.my-mariadb.v1 -> Ilk helm install yapildiginda gelir. 
sh.helm.release.v1.my-mariadb.v2 -> ikinci helm install ile gelen secret. 

<!-- Bu seferde verisyonu guncelleyelim -->
helm upgarede my-mariadb bitnami/mariadb --version 11.3.1 -n test --values mariadb-custom.yaml 
Deployment Revision: 3
kubectl get secrets -n test
my-mariadb 
sh.helm.release.v1.my-mariadb.v1 -> Ilk helm install yapildiginda gelir. 
sh.helm.release.v1.my-mariadb.v2 -> ikinci helm install ile gelen secret. 
sh.helm.release.v1.my-mariadb.v3 -> Ucuncu helm install ile gelen secret.

k get secrets -n test sh.helm.release.v1.my-mariadb.v1 -o yaml 
<!-- # encode olarak secreti yaml formatinda verir.  -->

# Get Details of Deployed Deployment
helm list -A 
helm status -n test my-mariadb 

<!-- Release notlarini goruntuleriz  -->
helm get notes my-mariadb -n test 

<!-- USER SUPPLIED VALUES: values yaml dosyasinda verilen degerleri goruntulememizi saglar  -->
helm get vaules my-mariadb -n test 

<!-- revision 1 deki degerleri gormek istiyoruz  -->
helm get vaules my-mariadb -n test --revision 1 

<!-- revision1 icin manifest dosyalarini verir.  -->
helm get manifest my-mariadb -n test --revision 1 

