## Helm template check.
# lint komutuyla direk hata var yada yok onu goruruz. 
helm lint ./nginx-template

## helm template: renders template and give same yaml files. 
# Bu komutla direk yaml formatinda helmChart kontrolu ve chart ciktisini aliriz. 
helm template ./nginx-template

## Asagidaki komut hata veren template dosyasini da bize gosterir. 
helm template ./nginx-template --debug 


## Bazi durumlarda helm template dosyasinda bir sikinti olmamasina ragmen k8s install zamaninda sikinti yasayabiliriz. 
# Bu durumun testi icin k8s deployment oncesinde --dry-run komutunu ekleyerek kontrol saglayabiliriz. 
# Bu komut tam olarak helm get notes ciktisi gibi bir cikti verecektir ancak install edilmemis olacaktir.  
helm install nginx ./nginx-template --dry-run 

