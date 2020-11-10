module "tenant-service-queue" {
  source  = "../modules/sqs"
  #version = "~> 2.0"

  create = true
  receive_wait_time_seconds = 20
  content_based_deduplication = false // Only for FIFO queue
  visibility_timeout_seconds = 30

  name = "tenant-service-queue"
  project = "review-aggregator"
  environment = "prod"
  owner = "review-aggregator" 
}