# terraform-aws-project

A modular Terraform project to provision AWS infrastructure including networking, compute, and databases. This setup uses reusable modules for VPC, EC2, and RDS and includes optional scripts for EC2 instance initialization and database migrations.

## Folder-Structure 

```plaintext
/terraform-aws-project/
├── modules/ # Reusable Terraform modules
│ ├── network/ # VPC, subnets, security groups
│ │ ├── main.tf
│ │ ├── variables.tf
│ │ ├── outputs.tf
│ ├── ec2/ # EC2 instance
│ │ ├── main.tf
│ │ ├── variables.tf
│ │ ├── outputs.tf
│ ├── rds/ # RDS instance
│ │ ├── main.tf
│ │ ├── variables.tf
│ │ ├── outputs.tf
│ ├── scripts/ # Optional scripts (DB migrations, init scripts) 
│ │ └── user_data.sh
├── main.tf # Root module that calls other modules
├── variables.tf # Root-level variables
├── outputs.tf # Root-level outputs
├── terraform.tfvars # Default variable values
├── README.md # Documentation
├── .gitignore # Ignore Terraform state files
├── provider.tf # AWS provider settings
└── backend.tf # Remote state backend (Terraform cloud + DynamoDB)
```
## Modules Overview

- **Network Module**  
  Manages the AWS VPC, subnets, and security groups. Contains necessary variables and outputs for inter-module communication.

- **EC2 Module**  
  Provisions an EC2 instance, including the configuration for user data (located in the scripts folder) to install Docker, Git, Docker Compose, etc.

- **RDS Module**  
  Sets up an RDS instance within private subnets with required inputs for engine type, instance class, and security.

## Scripts

- **user_data.sh:**  
  A bash script executed at EC2 launch to install dependencies such as Docker, Git, and Docker Compose for initial setup.

- **db_init.sql:**  
  Optional SQL script to initialize the database (e.g. create tables, insert seed data).

## Usage

1. **Set Variables:**  
   Update the values in `terraform.tfvars` to suit your environment.

2. **Initialize Terraform:**  
   Run `terraform init` to initialize the project and fetch provider plugins.

3. **Validate & Plan:**  
   Execute `terraform validate` to ensure configuration is correct followed by `terraform plan` to preview changes.

4. **Apply the Configuration:**  
   Run `terraform apply` to provision the AWS resources.

## AWS Provider & Backend

- The **provider.tf** file contains the settings required for Terraform to authenticate and interact with AWS.
- The **backend.tf** configures the remote state management using S3 and DynamoDB to ensure safe state locking and collaboration.

## Contributing

Contributions are welcome! Please open issues or submit pull requests for any improvements or bug fixes.

## License

This project is licensed under the MIT License.

## Author

Amit-Levi  
GitHub: [amitl](https://github.com/amitl)