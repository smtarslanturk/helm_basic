## Providers ## 

#terraform init: 
- Bu komut ilk basta girilir ve provider ihtiyaci olan uzantilar download edilir. 
- Terraform bir cok provider vardir. Bunlara terraform sitesinden ulasilabilir. 
https://registry.terraform.io/ 

1- Official Provider 
2- Partner Provider 
3- Comminity Provider 

# /root/terraform-local-file/.terraform 
Terraform install ettigi pluginler burada bulunur. 

# hashicorp/local 
hashicorp: Organization nameSpace 
local: type of provider 

# registry.terrafor.io/hashicorp/local 
registry.terrafor.io: plugin registry adress. 


- Bir path icersinde birden cok .tf uzantili konfiguarasyon dosyasi olabilir. Bu durumda terraform bunlarin hepsini apply eder. 
Veya bir cok conf dosyasi tek bir .tf dosyasi icerisine de yazilabilir. 

#main.tf 
resource "local_file" "pet" {
filename = "/root/pets.txt"
content = "We love pets!"
}
resource "local_file" "cat" {
filename = "/root/cat.txt"
content = "My favorite pet is Mr. Whiskers"
}

- Bir cok farkli configuration dosya cesidi vardir. 
main.tf: main configuration file. 
variables.tf: Contains variable decleration. 
outputs.tf: contains output from resource. 
provider.tf: Contains provider defination. 

### Multiple Providers ### 
resource "local_file" "cat" {
filename = "/root/cat.txt"
content = "My favorite pet is Mr. Whiskers"
}
local= provider 
local_file= resourceType 
cat= resourceName 
filename, content: Arguman.


### Using Input Variables ### 
- Hard code birsyeleri yazmak dogru yontem degildir. 
# variables.tf
- Bu dosya vasitasiyla degiskenlerimizi olusturabiliriz. 
variable "filename" {
default = "/root/pets.txt"
}
variable "content" {
default = "We love pets!"
}
variable "prefix" {
default = "Mrs"
}
variable "separator" {
default = "."
}
variable "length" {
default = "1"
}

#main.tf 
resource "random_pet" "my-pet" {
prefix = var.prefix
separator = var.separator
length = var.lenght
}

# - Bir cok farkli type olabilir. List de bunlardan biridir. List index 0 dan baslar. 
variable "separator" {
default = "."
type = string
description = "the path of local file" }

-----
#Type: List 
variable "prefix" {
default = ["Mr", "Mrs", "Sir"]
type = list
}

resource "random_pet" "my-pet" {
prefix = var.prefix[0]
}

-----
#Type: Map - Data represented format. Key - value pairs. We can imagine like CM in K8s object. Indexin yerine key degerlerini yazacaz. 
variable file-content {
type = map
default = {
"statement1" = "We love pets!"
"statement2" = "We love animals!"
}}

resource local_file my-pet {
filename = "/root/pets.txt"
content = var.file-content["statement2"]
}

# Type: Set - Bu Liste benzer. Ama key degerleri bunda dublicate edilmez. 
# Type: Object - Dictionary gibi dusun.  
# Type: Tuple - List gibi dusun ama burda listen farkli olarak farkli turde elementler bir arada kullanilabilmektedir. 
# - Ancak tuple turunde verilecek degiskene hangi degiskenleri hangi turde alacagi onceden bildirilmesi gerekir.  

variable kitty {
type = tuple([string, number, bool])
default = ["cat", 7, true]
}


-------------------------
###Using Variables in Terraform
- Eger variable dosyasinda herhangi bir default deger girilmezse, terraform apply komutundan  sonra bizden girdi icin deger soracaktir. 
Veya terraform degerleri sormadan asagidaki gibi de reaksiyon alinabilir. 
#terminalden 
terraform apply -var "filename=/root/pets.txt" -var "content=We love Pets!" -var "prefix=Mrs" -var "separator=." -var "length=2"
#varialbe export ederek 
$ export TF_VAR_filename="/root/pets.txt"
$ export TF_VAR_content="We love pets!"
$ export TF_VAR_prefix="Mrs"
$ export TF_VAR_separator="."
$ export TF_VAR_length="2"
$ terraform apply
- Veya diger bir dosya olan terraform.tfvars dosyasina asagideki gibi tanimlama yapilabilir. 
# terraform.tfvars 
filename = "/root/pets.txt"
content = "We love pets!"
prefix = "Mrs"
separator = "."
length = "2"
#terraform apply -var-file variables.tfvars

! Terminalden verilen degisken her zaman icin en oncelikli degisken olacaktir. Environment olarak atanan degisken ise en az oncelige sahip olacaktir. 

! Terraform follows a variable definition precedence order to determine the value and
the command line flag of –var or –var-file takes the highest priority.

-------------------------
### Resource Attributes
- Gercek hayatta olusturualcak olan kaynak diger kaynaklara bagimliligi olabilir. 

 resource "time_static" "time_update" {
# rfc3339 (String) Base timestamp in RFC3339 format (see RFC3339 time string e.g., YYYY-MM-DDTHH:MM:SSZ). Defaults to the current time.
}

 resource "local_file" "time" {
    filename = "/root/time.txt"
    content = "Time stamp of this file is ${time_static.time_update.id}"
}

// Yukaridaki id kismi bizim icin attirbute kismi icin onemli bir oz niteliktir. 
# terraform show 
Make use of the terraform show command and identify the attribute values.

-------------------------
### Resource Dependencies 
Explicit Dependencies: Bir kaynaga depends on ifadesi eklenirse bu kaynak once diger kaynagin olusmasini bekler. Aslinda Atttibutes kullandigimiz zamanda id ihtiyaci olacagi icin yine beklemesi gerekecek. 

resource "local_file" "pet" {
filename = var.filename
content = "My favorite pet is Mr.Cat"
    depends_on = [
    random_pet.my-pet
    ]
}
resource "random_pet" "my-pet" {
prefix = var.prefix
separator = var.separator
length = var.length
}

explicit dependencies: Depends on ifadesini ekledigimiz. hard coded kaynaklarin birbirine bagli oldugu belli olan durum. 
implicit dependencies: depends on ibaresi kullanilmadan id uzerinden kaynaklari birbirine baglamak. 

# terraform state
Kayaklar hakkinda bilgi almamizi saglar. Bir cok ek yan komutu vardir. 

### Output Variables ### 
- Attirbute olarak cektigimiz degerleri output degiskeni olarak tanimlayabilmekteyiz. 

# terraform output 
Bu komut sayesinde terraform tf dosyasinda olan tanimli degiskenleri goruruz. 
Ancak bu komutun calisabilmesi icin onceden apply edilmis olmasi gerekir. 

ayrica resource degilde output olarak tanimlanan objeleri ciktilari apply komutu sonrasi terminale basilir. 