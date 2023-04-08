### Download Terraform ### 
- Single binary veya executable file uzerinden kurulum gerceklestirilebilir. 

wget <teraformZipFile> 
unzip <terraform.zip> 
mv terraform /usr/local/bin 
terraform version 

- Bu kursta v.0.13.0 terraform kullanilmaktadir. 

- HCL - Declarative Language 
.tf uzantili dosylari terraform okuyabilmektedir. 

- Resource: Lokalde bulunan bir dosya yada bir instance veya bir servise source diyebiliriz. (s3, dynomodb ...)


### HCL LANGUAGE ### - Hashicorp Conf Language 
- HCL block ve argumanlardan olusur. Aslinda key-value ciftlerinden olusmaktadir. 
- block: infra platformu hakkinda bilgi verir. 
arguments: {}lerin arasinda bulunan key-value ciftlerine denir. 
parameters: TypeOfResource 

#local.tf 
<block> <parameters> {
    key1=value1
    key2=value2 
}

<block> <resourceType> <resourceName> {
    filename = "/root/samet/test.txt"
    content = "Selam Terraform!!"
}

## Terraform Configuration Steps ## 
1- Configarasyon dosyasini yaz. HCL file. 
2- terraform init
3- terraform plan 
4- terraform apply 

2: Bu komut configurasyon dosyasinin kontrolunu saglar. Terraformu initilazation eder.
Bu komuttan sonra kullanilan resourceType gore terraformun ilgili plugin indirdigini goruruz. 
3: Eger execution plani gormek istiyorsak <terraform plan> komutunu calistirmaliyiz. 
--dry-run gibi dusunulebilir. 
4: Execution plani bir kere daha goruruz ve burda bizden onay ister. 
5- terraform show: Resource hakkinda detail verir. 

### local.tf - local_file: terraform local providerin bir sourceTypidir. ## 
resource "local_file" "pet" {
filename = "/root/pets.txt"
content = "We love pets!"
}

- Dokumantasyona baktigimiz zaman resource kisminda bazi parametrelerin zorunlu olarak verilmesi gerektigini bazi parametrelerinse optional olarak 
verilebilecegi yazmaktadir. 

### Update And Destroy ### 
- HCL dosyasinda bir degisiklik yaptiktan sonra <terraform apply> komutunu verdigimizde cikan logda uygulanan ve silinen seyler goruntulenir. 
- Yapilan guncellemeden sonra var olan dosyanin silindigi ve yerine yeni dosya olusturuldu gorulur. 

# terraform destroy
- Var olan tum argumanlari HCL dosyasina gore ortadan kaldiracaktir. 
- Nelerin destroy edilecegiyle alakali cikti verir. Bunlari da onaylamis olmak gerekmektedir. 

