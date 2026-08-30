# 8Byte.ai DevOps Assignment

This project demonstrates an end-to-end DevOps setup on AWS using Terraform, Docker, GitHub Actions, Amazon ECS Fargate, Amazon RDS PostgreSQL, Application Load Balancer, and Amazon CloudWatch.

The main goal of the project was to provision the AWS infrastructure using Terraform, automate testing and deployments with GitHub Actions, scan the Docker image for security vulnerabilities, and set up monitoring and centralized logging.

## Architecture

The application is deployed using the following AWS services and tools:

- AWS VPC with public and private subnets
- Application Load Balancer for external access
- Amazon ECS Fargate for running the application containers
- Amazon ECR for storing Docker images
- Amazon RDS PostgreSQL for the application database
- Amazon CloudWatch Logs for centralized container logging
- CloudWatch dashboards for application and database monitoring
- GitHub Actions for CI/CD
- Terraform for infrastructure provisioning

Application traffic is received by the Application Load Balancer and forwarded to the ECS Fargate service. The ECS service is configured to run two tasks. The PostgreSQL database is hosted on Amazon RDS in the private network and is not publicly accessible.

## Infrastructure Provisioning

Terraform is used to provision and manage the AWS infrastructure.

The main resources provisioned include:

- VPC and networking
- Public and private subnets
- Internet Gateway
- NAT Gateway
- Route tables
- ECS cluster and service
- ECS task definition
- Application Load Balancer
- Target group and listener
- ECR repository
- RDS PostgreSQL instance
- Security groups
- IAM execution role
- CloudWatch log group
- CloudWatch dashboards

After deployment, I ran `terraform validate` to check the configuration and `terraform plan` to compare the Terraform configuration with the deployed infrastructure. The plan reported no changes.

## Application

The application is containerized using Docker and runs on port 8080.

The Docker image uses Python 3.11 on Debian Bookworm and runs the application using Gunicorn.

The container runs as a non-root user (`appuser`).

The application exposes two endpoints:

- `/` - Application endpoint
- `/health` - Health check endpoint

Example health response:

```json
{
  "status": "healthy"
}