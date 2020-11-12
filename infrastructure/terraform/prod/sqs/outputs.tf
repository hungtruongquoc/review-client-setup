output "tenant-service-queue-arn" {
    value = "${module.tenant-service-queue.this_sqs_queue_arn}"
}

output "tenant-service-queue-name" {
    value = "${module.tenant-service-queue.this_sqs_queue_name}"
}
