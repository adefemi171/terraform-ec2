# Currently revamping/modularizing this repository

# A SIMPLE TERRAFORM FILE THAT INSTALL NGINX WHILE CREATING EC2

## Folder Structure

    📦Terraform-ec2

        📦user_data

            ┣ 📜nginx.sh

        ┣ 📜instance.tf


## About the configuration file
The *public_key* value was generated on my local PC using SSH, the image is an Ubuntu image and the instance type is a *t2 Micro*


# How to setup project and run locally

### Clone the repository 

```
git clone https://github.com/adefemi171/terraform-ec2.git
```

### Initialize the directory

```
    terraform init
```

### You might want to format your terraform file which might not be neccesary

```
    terraform fmt
```

### Apply changes required

```
    echo "yes"|terraform apply
```
