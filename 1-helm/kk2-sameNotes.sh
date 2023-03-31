## Named Template ## 
- Standart olarak bir cok yerde kullanilan ifadeleri simgeler. 
- Bu durum partial veya name template olarak isimlendirilir. 
- _helpers.tpl dosyasi icerisinde tanimlama yapilabilir. 
bu dosya standart bir manifest dosyasi degildir. Bu dosyada gerekli bazi seylerin tanimlamasini yapabiliriz. 

{{- define "labels" }}
  app.kubernetes.io/name: nginx
  app.kubernetes.io/instance: nginx
{{- end }}

yaml dosyalarinda direk asagidaki sekilde kullanilabilir. 
{{- template "labels" . }}

Ancak indent koymak istersek template ifadesi gecersiz olur. Bundan dolayi include kullanarak bu durum ortadan kaldirilabilir. 
{{- include "labels" . | indent 4 }}

- Template actiondur. Include ise functiondir. 
Functionlari pipe vererek ciktilarini diger fonksiyonlara iletebiliriz. 

## Chart Hooks ## 
- Upgarade alinacagi zaman otomatik olarak volume, db backup alinir oncelikli olarak. 
- Iste bu yapilan aslinda bir ekstra actiondur. Buna aslinda Hook adi verilir. 

helmUpgrade -> Verify/Templates -> render/createManifestFiles -> Upgrade/InstallServices

- Chart install edilmeden once render adimindan once backup alalim. 
Bunun icin "pre-upgrade Hook" kullaniriz. 

helmUpgrade -> Verify -> render -> preUpgrade -> upgrade

helm PreUpgrade bekler ve sonra upgrade islemini gerceklesitirir. 

preUpgrade Hook: Install oncesinde yapilir. 
PostUpgrade Hook: Install tamamlandiktan sonra yapilir. 

INSTALL - UPGRADE - ROLLBACK - DELETE 

- Mesela bir Job manifest olusturarak ardindan Pre-Install Hook olusturmasi yapabiliriz. 

- Bir dosyasinin Hook dosyasi oldugunu anlatmak icin Anatation eklemek gerekmektedir. 
annotations:
  "helm.sh/hook": pre-upgrade
  "helm.sh/hook-weight": "5"
  "helm.sh/hook-delete-policy": hook-succeeded 
#chart bittikten sonra bu tanimlamanin yapildigi objeyi silecektir. 
   "helm.sh/hook-delete-policy": before-hook-creation
- Hooklar pozitif veya negatif olacak sekilde agirlik degerleri alabilirler. 

-------------------------------------------------
## LABS NOTES ##
- The template file should start with an underscore. Else it will be considered a Kubernetes manifest file.

