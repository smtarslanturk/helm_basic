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