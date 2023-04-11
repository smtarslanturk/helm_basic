# Go to the .terraform/plugins directory and count the number of provider plugins installed. If the directory does not exist, there are no plugins downloaded yet.
# Eger terraform init yaparsak pluginler install edilir.

# .terraform/plugins projenin main.tf dosyasinin oldugu yerde terraform init yapinca olusur. 

Run terraform plan (optional) and then terraform apply in the directory /root/terraform-projects/things-to-do.


-------------------------------------------------
### Multiple Providers ### 
- Go to the .terraform/plugins directory and count the number of provider plugins installed. If the directory does not exist, there are no plugins downloaded yet

resource "aws_instance" "ec2_instance" {
	  ami       =  "ami-0eda277a0b884c5ab" 
	  instance_type = "t2.large"
}


resource "aws_ebs_volume" "ec2_volume" {
	  availability_zone = "eu-west-1"
	  size  =    10
}


resource "local_file" "data" {
	filename = "/root/k8s.txt"
	content = "kubernetes the hard way!"
}


resource "kubernetes_namespace" "dev" {
  metadata {
    name = "development"
  }
}


- Eger bir configurasyon dosyasinda degisiklik yaptiysan burda once terraform init komutunu calistirmalisin. 
Aksi takdirde pluginler install edilmedigi icin hata gelecektir. 

This is because whenever we add a resource for a provider that has not been used so far in the configuration directory, we have to initialize the directory by running terraform init command.


-------------------------------------------------
#variables.tf
# variable "name" {
#      type = string
#      default = "Mark"
  
# }
variable "number" {
     type = bool
     default = true
  
}
variable "distance" {
     type = number
     default = 5
  
}
variable "jedi" {
     type = map
     default = {
     filename = "/root/first-jedi"
     content = "phanius"
     }
}

variable "gender" {
     type = list(string)
     default = ["Male", "Female"]
}
variable "hard_drive" {
     type = map
     default = {
          slow = "HHD"
          fast = "SSD"
     }
}
variable "users" {
     type = set(string)
     default = ["tom", "jerry", "pluto", "daffy", "donald", "jerry", "chip", "dale"]

  
}
#main.tf
resource "local_file" "jedi" {
     filename = var.jedi["filename"]
     content = var.jedi["content"]
}

-------------------------------------------------
As you can see, the resource block is empty. This is because time_static does not need any arguments to be supplied to work.
When applied as it is, terraform creates a logical resource locally (similar to random_pet) with the current time.

-------------------------------------------------
### Resource Dependencies 
Reference ...= When we use reference expressions to link resources, the dependency created is called implicit dependency

-------------------------------------------------
Resource A relies on another Resource B but doesn't access any of its attributes in its own arguments.
/explicit dependicy. 

When we use reference expressions to link resources, the dependency created is called implicit dependency

resource "tls_private_key" "pvtkey" {
  algorithm = "RSA"
  rsa_bits  = 4096
}

explicit dependencies: Depends on ifadesini ekledigimiz. hard coded kaynaklarin birbirine bagli oldugu belli olan durum. 
implicit dependencies: depends on ibaresi kullanilmadan id uzerinden kaynaklari birbirine baglamak. 

# terraform state
Kayaklar hakkinda bilgi almamizi saglar. Bir cok ek yan komutu vardir. 

resource "tls_private_key" "pvtkey" {
  algorithm = "RSA"
  rsa_bits  = 4096
}

resource "local_file" "key_details" {
	filename = "/root/key.txt"
	content = "${tls_private_key.pvtkey.private_key_pem}"
}
---------------
resource "tls_private_key" "pvtkey" {
  algorithm = "RSA"
  rsa_bits  = 4096
}

resource "local_file" "key_details" {
  content  = tls_private_key.pvtkey.private_key_pem
  filename = "/root/key.txt"
}
---------------

resource "local_file" "whale" {
  filename   = "/root/whale"
  content    = "whale"
  depends_on = [local_file.krill]
}
resource "local_file" "krill" {
  filename = "/root/krill"
  content  = "krill"
}
---------------

resource "random_pet" "my-pet" {

  length    = var.length 
}

output "pet-name" {
	
	value = random_pet.my-pet.id
	description = "Record the value of pet ID generated by the random_pet resource"
}
terraform output 
terraform state list
terraform state show random_pet.my-pet


---------------
resource "random_pet" "my-pet" {

  length = var.length
}

output "pet-name" {

  value       = random_pet.my-pet.id
  description = "Record the value of pet ID generated by the random_pet resource"
}

resource "local_file" "welcome" {
  filename = "/root/message.txt"
  content  = "Welcome to Kodekloud."
}
output "welcome_message" {
  value = local_file.welcome.content
}

---------------