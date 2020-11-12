module "tenant-service-queue" {
  source  = "../modules/sqs"
  #version = "~> 2.0"

  create = true
  receive_wait_time_seconds = 20
  content_based_deduplication = false // Only for FIFO queue
  visibility_timeout_seconds = 30

#   policy = <<POLICY
# {
#   "Version": "2012-10-17",
#   "Id": "sqspolicy",
#   "Statement": [
#     {
#       "Sid": "ForBuildInfraLambda",
#       "Effect": "Allow",
#       "Principal": {
#         "Service": "lambda.amazonaws.com"
#       },
#       "Action": "sqs:SendMessage",
#       "Resource": "arn:aws:sqs:us-east-2:723567309652:tenant-service-queue"
#     }
#   ]
# }
# POLICY

  name = "TenantDbCreateQueue"
  project = "review-aggregator"
  environment = "prod"
  owner = "review-aggregator" 
}
