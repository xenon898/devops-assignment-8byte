# 8Byte.ai DevOps Assignment

## Overview

This project implements an end-to-end DevOps environment on AWS using Terraform, Docker, GitHub Actions, Amazon ECS Fargate, Amazon RDS PostgreSQL, Application Load Balancer, and Amazon CloudWatch.

The objective was to provision the infrastructure using Infrastructure as Code, automate application testing and deployment, implement container security scanning, and provide centralized monitoring and logging.

## Architecture

The application is deployed using the following architecture:

- AWS VPC with public and private subnets
- Application Load Balancer for external application access
- Amazon ECS Fargate for containerized application hosting
- Amazon ECR for Docker image storage
- Amazon RDS PostgreSQL for the database
- Amazon CloudWatch Logs for centralized container logging
- Amazon CloudWatch dashboards for application and database monitoring
- GitHub Actions for CI/CD automation
- Terraform for infrastructure provisioning

Application traffic flows through the Application Load Balancer to the ECS Fargate service. The ECS service runs two tasks for availability. The PostgreSQL database is hosted on Amazon RDS and is not publicly accessible.

## Infrastructure Provisioning

Terraform is used to provision and manage the AWS infrastructure.

The infrastructure includes:

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

Terraform validation and planning were performed after deployment to verify that the configuration is valid and matches the deployed infrastructure.

## Application

The application is containerized using Docker and runs on port 8080.

The Docker image uses Python 3.11 on Debian Bookworm and runs the application using Gunicorn.

The container runs as a non-root user (`appuser`).

The application exposes:

- `/` - Application endpoint
- `/health` - Health check endpoint

Example health response:

```json
{
  "status": "healthy"
}