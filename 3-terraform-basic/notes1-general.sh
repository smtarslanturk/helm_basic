#### Introduction to Infrastructure as Code ###
- Traditional infralar genelde on-premise de kosmaktadir. 
Bazi dejavantajlari var: 
 Yavastir. 
 Pahalidir. 
 Otomasyon gerceklestirmek zordur. 
 Insan hatalari fazla olabilir. 
 Resource israfi vardir. 
 Sureklilikte sikinti olabiliyor. 

- Cloud Providerlarin cikmasiyla beraber bir cok sey kolaylamaya basladi. 
- Cloud Resourceslar API destegi vardir. Otomasyon icin buyuk avantajdir. 
- Bir kac click ile sanal makineyi ayaga kaldirabiliriz. (Management consoldan)
- Terraform, Docker, Ansible, CloudFormation, Vagrant, papet... en cok bilinen IaC toolarina ornektir. 

### Types of IAC Tools ### 
- Aslinda infrayi .sh dosyalariylada tek tek kodlayabiliriz. 
Ancak burada ki .sh scriptler genelde buyuk boyutlu oluyorlar. Bunlar terraformla direk basic scriptlere cevrilebilir. (main.tf)
- IaC sayesinde bir cok infra elementini code olarak yazabiliriz. (database, network, storage ...)

# Configuration Management: Daha cok yazilim install etmede kullanilir. Versiyon kontol gibi islerde. Idempotent ozelligide vardir. 
Ansible 
puppet 
saltstack 
 
# Server Templating: Immituble infra. Custom image. Preinstall software. 
Docker 
hashicorp Packer 
hashicorp Vagrant 

# Infrastructer Provisioning Tool: Deploy immutable Infra. Multiple providers destegi vardir. 
hashicorp Terraform 
CloudFormation -> Bu sadece AWS de gecerli. 

### Why Terraform ### 
- Terraform Open Sourcedir. 
- Hizli sekilde kurulum single binary ile yapilabilir. 
- MULTIPLE Platforma deploy islemi gerceklestirebiliriz. (Privite veya public farketmez.)
- .tf file uzantisi olan dosyalara sahiptir. 
- Init fazinda terraform initilation yapar projeye. 
Plan, apply,  gibi fazlari vardir. 
- Terraformdaki her obje Resource olarak isimlendirilir. 
- .tfstate sayesinde terraform desered state kontrolunu saglar.
- Enterprise teraformda ekstra olarak UI arayuzu saglar terraform. (Biz terminalden kontrol saglayacagiz.)

