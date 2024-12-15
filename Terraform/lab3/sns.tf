resource "aws_sns_topic" "alerts_topic" {
  name = "ec2-monitoring-alerts"
}

resource "aws_sns_topic_subscription" "email_subscription" {
  topic_arn = aws_sns_topic.alerts_topic.arn
  protocol  = "email"
  endpoint  = var.gmail_address
}

