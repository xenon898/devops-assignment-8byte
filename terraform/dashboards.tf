resource "aws_cloudwatch_dashboard" "application" {
  dashboard_name = "${local.project_name}-application"

  dashboard_body = jsonencode({
    widgets = [
      {
        type   = "metric"
        x      = 0
        y      = 0
        width  = 12
        height = 6

        properties = {
          title  = "ECS CPU Utilization"
          region = "ap-south-1"
          period = 300
          stat   = "Average"
          view   = "timeSeries"

          metrics = [
            [
              "AWS/ECS",
              "CPUUtilization",
              "ClusterName",
              aws_ecs_cluster.main.name,
              "ServiceName",
              aws_ecs_service.app.name
            ]
          ]
        }
      },
      {
        type   = "metric"
        x      = 12
        y      = 0
        width  = 12
        height = 6

        properties = {
          title  = "ECS Memory Utilization"
          region = "ap-south-1"
          period = 300
          stat   = "Average"
          view   = "timeSeries"

          metrics = [
            [
              "ECS/ContainerInsights",
              "MemoryUtilized",
              "ClusterName",
              aws_ecs_cluster.main.name,
              "ServiceName",
              aws_ecs_service.app.name
            ]
          ]
        }
      },
      {
        type   = "metric"
        x      = 0
        y      = 6
        width  = 12
        height = 6

        properties = {
          title  = "ALB Request Count"
          region = "ap-south-1"
          period = 300
          stat   = "Sum"
          view   = "timeSeries"

          metrics = [
            [
              "AWS/ApplicationELB",
              "RequestCount",
              "LoadBalancer",
              aws_lb.app.arn_suffix
            ]
          ]
        }
      },
      {
        type   = "metric"
        x      = 12
        y      = 6
        width  = 12
        height = 6

        properties = {
          title  = "ALB Target Response Time"
          region = "ap-south-1"
          period = 300
          stat   = "Average"
          view   = "timeSeries"

          metrics = [
            [
              "AWS/ApplicationELB",
              "TargetResponseTime",
              "LoadBalancer",
              aws_lb.app.arn_suffix
            ]
          ]
        }
      },
      {
        type   = "metric"
        x      = 0
        y      = 12
        width  = 12
        height = 6

        properties = {
          title  = "ALB HTTP 5xx Errors"
          region = "ap-south-1"
          period = 300
          stat   = "Sum"
          view   = "timeSeries"

          metrics = [
            [
              "AWS/ApplicationELB",
              "HTTPCode_ELB_5XX_Count",
              "LoadBalancer",
              aws_lb.app.arn_suffix
            ]
          ]
        }
      }
    ]
  })
}


resource "aws_cloudwatch_dashboard" "database" {
  dashboard_name = "${local.project_name}-database"

  dashboard_body = jsonencode({
    widgets = [
      {
        type   = "metric"
        x      = 0
        y      = 0
        width  = 12
        height = 6

        properties = {
          title  = "RDS CPU Utilization"
          region = "ap-south-1"
          period = 300
          stat   = "Average"
          view   = "timeSeries"

          metrics = [
            [
              "AWS/RDS",
              "CPUUtilization",
              "DBInstanceIdentifier",
              aws_db_instance.postgres.identifier
            ]
          ]
        }
      },
      {
        type   = "metric"
        x      = 12
        y      = 0
        width  = 12
        height = 6

        properties = {
          title  = "RDS Database Connections"
          region = "ap-south-1"
          period = 300
          stat   = "Average"
          view   = "timeSeries"

          metrics = [
            [
              "AWS/RDS",
              "DatabaseConnections",
              "DBInstanceIdentifier",
              aws_db_instance.postgres.identifier
            ]
          ]
        }
      },
      {
        type   = "metric"
        x      = 0
        y      = 6
        width  = 12
        height = 6

        properties = {
          title  = "RDS Free Storage"
          region = "ap-south-1"
          period = 300
          stat   = "Average"
          view   = "timeSeries"

          metrics = [
            [
              "AWS/RDS",
              "FreeStorageSpace",
              "DBInstanceIdentifier",
              aws_db_instance.postgres.identifier
            ]
          ]
        }
      },
      {
        type   = "metric"
        x      = 12
        y      = 6
        width  = 12
        height = 6

        properties = {
          title  = "RDS Read IOPS"
          region = "ap-south-1"
          period = 300
          stat   = "Average"
          view   = "timeSeries"

          metrics = [
            [
              "AWS/RDS",
              "ReadIOPS",
              "DBInstanceIdentifier",
              aws_db_instance.postgres.identifier
            ]
          ]
        }
      },
      {
        type   = "metric"
        x      = 0
        y      = 12
        width  = 12
        height = 6

        properties = {
          title  = "RDS Write IOPS"
          region = "ap-south-1"
          period = 300
          stat   = "Average"
          view   = "timeSeries"

          metrics = [
            [
              "AWS/RDS",
              "WriteIOPS",
              "DBInstanceIdentifier",
              aws_db_instance.postgres.identifier
            ]
          ]
        }
      }
    ]
  })
}