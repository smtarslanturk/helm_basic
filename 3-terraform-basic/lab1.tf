That's right! That is a TF file and is used for writing configuration files in Terraform using HCL.
-----------
resource "local_file" "games" {
  filename     = "/root/favorite-games"
  content  = "FIFA 21"
  sensitive_content = "FIFA 21"
}

Inspect the resource type used. The value before the underscore _ in the resource type is usually the provider.
In this case it is local.

-----------
iac-server $ terraform plan 

Error: Could not load plugin


Plugin reinitialization required. Please run "terraform init".

Plugins are external binaries that Terraform uses to access and manipulate
resources. The configuration provided requires plugins which can't be located,
don't satisfy the version constraints, or are otherwise incompatible.

Terraform automatically discovers provider requirements from your
configuration, including providers used in child modules. To see the
requirements and constraints, run "terraform providers".

Failed to instantiate provider "registry.terraform.io/hashicorp/local" to
obtain schema: unknown provider "registry.terraform.io/hashicorp/local"


-----------
iac-server $ terraform init 

Initializing the backend...

Initializing provider plugins...
- Finding latest version of hashicorp/local...
- Installing hashicorp/local v2.4.0...
- Installed hashicorp/local v2.4.0 (self-signed, key ID 34365D9472D7468F)

Partner and community providers are signed by their developers.
If you'd like to know more about provider signing, you can read about it here:
https://www.terraform.io/docs/plugins/signing.html

The following providers do not have any version constraints in configuration,
so the latest version was installed.

To prevent automatic upgrades to new major versions that may contain breaking
changes, we recommend adding version constraints in a required_providers block
in your configuration, with the constraint strings suggested below.

* hashicorp/local: version = "~> 2.4.0"

Terraform has been successfully initialized!

You may now begin working with Terraform. Try running "terraform plan" to see
any changes that are required for your infrastructure. All Terraform commands
should now work.

If you ever set or change modules or backend configuration for Terraform,
rerun this command to reinitialize your working directory. If you forget, other
commands will detect it and remind you to do so if necessary.
iac-server $ 

## Script
resource "local_file" "games" {
  filename     = "/root/favorite-games"
  # content  = "FIFA 21"
  sensitive_content = "FIFA 21"
  # local_sensitive_file = "FIFA 21"
}

NOTE: Notice that the content of the file was not displayed when using sensitive_content instead of the content argument.
Note: This argument is specific to the local_file resource we are using. Refer to the documentation to see all the arguments supported by this resource.
Also note that as Terraform follows an immutable infrastructure approach, the file was recreated although the contents are the same.