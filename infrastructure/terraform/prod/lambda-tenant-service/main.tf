module "lambda-tenant-service" {
    source = "../modules/lambda"

    create-default-security-group = true
    vpc-id  = data.terraform_remote_state.network.outputs.review-aggregator-vpc.id
    allowed-ports = [80,443]

    security-group-name = "lambda-tenant-service-default-security-group"
    project             = "review-aggregator"
    environment         = "prod"
    owner               = "review-aggregator"
}