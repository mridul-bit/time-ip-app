
# IAM role for ECS tasks (Fargate)
resource "aws_iam_role" "ecs_task_execution_role" {
  name = "ecs-task-execution-role"

  # allows ECS tasks to assume this role
  assume_role_policy = jsonencode({
    Version = "2012-10-17",
    Statement = [
      {
        Effect = "Allow",
        Principal = {
          Service = "ecs-tasks.amazonaws.com"
        },
        Action = "sts:AssumeRole"
      }
    ]
  })

  tags = {
    Name        = "ecs-task-execution-role"
    Environment = "prod"
  }
}

# Attach permission policies
resource "aws_iam_role_policy_attachment" "ecs_task_policy_attachment" {
  role       = aws_iam_role.ecs_task_execution_role.name
  policy_arn = "arn:aws:iam::aws:policy/service-role/AmazonECSTaskExecutionRolePolicy"
}

