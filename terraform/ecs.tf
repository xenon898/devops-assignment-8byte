resource "aws_ecs_cluster" "main" {
  name = "${local.project_name}-cluster"

  tags = {
    Name        = "${local.project_name}-cluster"
    Environment = local.environment
  }
}

resource "aws_ecs_task_definition" "app" {
  family                   = "${local.project_name}-app"
  network_mode             = "awsvpc"
  requires_compatibilities = ["FARGATE"]
  cpu                      = "256"
  memory                   = "512"

  execution_role_arn = aws_iam_role.ecs_execution.arn

  container_definitions = jsonencode([
    {
      name      = "app"
      image     = "414904928510.dkr.ecr.ap-south-1.amazonaws.com/devops-assignment-8byte-app:${var.image_tag}"
      essential = true

      portMappings = [
        {
          containerPort = 8080
          hostPort      = 8080
          protocol      = "tcp"
        }
      ]

      # The slim Python base image has no curl; probe with the interpreter itself.
      healthCheck = {
        command = [
          "CMD-SHELL",
          "python -c \"import sys,urllib.request; urllib.request.urlopen(sys.argv[1])\" http://localhost:8080/health || exit 1",
        ]
        interval    = 30
        timeout     = 5
        retries     = 3
        startPeriod = 15
      }

      logConfiguration = {
        logDriver = "awslogs"

        options = {
          awslogs-group         = "/ecs/${local.project_name}"
          awslogs-region        = "ap-south-1"
          awslogs-stream-prefix = "app"
        }
      }
    }
  ])

  tags = {
    Name        = "${local.project_name}-task"
    Environment = local.environment
  }
}

resource "aws_cloudwatch_log_group" "ecs" {
  name              = "/ecs/${local.project_name}"
  retention_in_days = 7

  tags = {
    Name        = "${local.project_name}-logs"
    Environment = local.environment
  }
}