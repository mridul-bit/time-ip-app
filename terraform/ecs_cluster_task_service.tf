resource "aws_ecs_cluster" "time_ip_cluster" {
  name = "ecs-time-ip-cluster"

  tags = {
    Environment = "prod"
  }
}

resource "aws_ecs_task_definition" "time_ip_task" {
  family                   = "time-ip-task"
  requires_compatibilities = ["FARGATE"]
  network_mode             = "awsvpc"
  cpu                      = "512"
  memory                   = "1024"
  execution_role_arn       = aws_iam_role.ecs_task_execution_role.arn

  container_definitions = jsonencode([
    {
      name      = "time-ip-app"
      image     = "mridulbadgurjar4/time-ip-image"
      essential = true
      portMappings = [
        {
          containerPort = 3000
          protocol      = "tcp"
        }
      ]
    }
  ])
}

resource "aws_security_group" "ecs_sg" {
  name        = "ecs-task-sg"
  description = "Allow traffic from ALB"
  vpc_id      = module.vpc.vpc_id

  ingress {
    from_port   = 3000
    to_port     = 3000
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name = "ecs-task-sg"
  }
}

resource "aws_ecs_service" "time_ip_service" {
  name            = "time-ip-service"
  cluster         = aws_ecs_cluster.time_ip_cluster.id
  task_definition = aws_ecs_task_definition.time_ip_task.arn
  launch_type     = "FARGATE"
  desired_count   = 1

  network_configuration {
    subnets          = module.vpc.private_subnets
    security_groups  = [aws_security_group.ecs_sg.id]
    assign_public_ip = false
  }

  load_balancer {
    target_group_arn = aws_lb_target_group.ecs_tg.arn

    container_name = "time-ip-app"
    container_port = 3000
  }

  depends_on = [
    aws_iam_role_policy_attachment.ecs_task_policy_attachment,
    aws_security_group.ecs_sg
  ]
}

