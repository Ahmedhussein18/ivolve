resource "aws_cloudwatch_metric_alarm" "ec2_cpu_alarm" {
  alarm_name          = "High-CPU-Utilization"
  comparison_operator = "GreaterThanThreshold"
  evaluation_periods  = 1
  metric_name         = var.metric_name
  namespace           = "AWS/EC2"
  period              = 300
  statistic           = "Average"
  threshold           = var.threshold 
  alarm_description   = "Alarm for high CPU utilization"
  alarm_actions       = [aws_sns_topic.alerts_topic.arn]
  dimensions = {
    InstanceId = aws_instance.instance.id
  }

  tags = {
    Name = "High-CPU-Alarm"
  }
}