## Terraform State ## 
- Terraform apply denildigi zaman resourcelerin zaten var oldugunu daha onceden olusturulmus olan terraform.tfstate komutu vasitasiyla anlamaktadir. 
- Eger varolan kaynaklarda bir guncelleme yapilirsa eskisi silinir yenisi gelir. Ve resource ID de guncellenir. 

## Purpose Of State ## terraform.tfstate 
- Gercek dunya kaynaklarinin hepsi .tfstate dosyasi icin de unique id lere sahiptirler. 
- Terraformda 2 cesit Bagaimlilik vardir: 
1- Implicit ${time_static.time_update.id}
2- Expilicit (DependsOn eklenir.)

- State dosyasi large scale altyapilarda onem arzetmektedir. Bu dosyayi biraz daha detayli inceleyerek anlamlandirmada fayda olabilir. 


## Terraform State Configuration ## 
- Terraform state sayesinde aslinda gercek dunyaya neler deploy edilmis bunu gormus olduk. 
- State opsiyonoli olmayan bir seydir terraformda. Ancak bazi seylere dikkat etmek gerekir. 
1- Mesela State File sensitive datalari icerebilir: 
State File kesinlikle elinle degistirme. 
