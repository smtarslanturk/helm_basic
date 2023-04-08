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