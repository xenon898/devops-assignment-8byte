resource "aws_ecs_service" "app" {
  name            = "${local.project_name}-service"
  cluster         = aws_ecs_cluster.main.id
  task_definition = aws_ecs_task_definition.app.arn
  desired_count   = 2
  launch_type     = "FARGATE"

  health_check_grace_period_seconds = 60

  network_configuration {
    subnets = [
      aws_subnet.private_1.id,
      aws_subnet.private_2.id
    ]

    security_groups = [aws_security_group.ecs.id]

    assign_public_ip = false
  }

  load_balancer {
    target_group_arn = aws_lb_target_group.app.arn
    container_name   = "app"
    container_port   = 8080
  }

  depends_on = [
    aws_lb_listener.http
  ]

  # The CI/CD pipeline rolls out new images by registering new task definition
  # revisions and pointing the service at them. Ignore that drift here so
  # `terraform apply` does not revert deployments.
  lifecycle {
    ignore_changes = [task_definition]
  }

  tags = {
    Name        = "${local.project_name}-service"
    Environment = local.environment
  }
}