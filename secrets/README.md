# Introduction to use SOPS

### First, make sure you already setup "review-aggregator" aws profile

## Install SOPS
On Mac 
`brew install sops`

Install from binary 
`https://github.com/mozilla/sops`

## Encryption
Run `./sops.sh -e your_crediential.file > encrypted.file`

For example:

```./sops.sh -e bastion-host-key-pair/prod-bastion-host.pem > bastion-host-key-pair/prod-bastion-host-private-key.json```

## Decryption 
Run `./sops.sh -e encrypted.file > decrypted.file`

For example 

```./sops.sh -d bastion-host-key-pair/prod-bastion-host-private-key.json > private-key.pem```

# How to connect to RDS by Bastion host (SSH Tunel)

Bastion host will play a role as intermediary, stand between your machine and RDS

You have to mapping your local port to Bastion host and you should specify the RDS endpoint, RDS port as well

The example command is:

```ssh -i prod-bastion-host.pem -N -L 9001:review-aggregator-prod-review-aggregator-db.crylpz40mxp9.us-east-2.rds.amazonaws.com:5432 ubuntu@ec2-3-138-141-147.us-east-2.compute.amazonaws.com```

- `prod-bastion-host.pem` is the private key to create SSH Tunnel

- `9001` is your local port

- `review-aggregator-prod-review-aggregator-db.crylpz40mxp9.us-east-2.rds.amazonaws.com` this is the RDS endpoint, it's in private subnet, cannot be connected from the internet

- `5432` is the RDS port

- `ubuntu@ec2-3-138-141-147.us-east-2.compute.amazonaws.com` is username and endpoint of Bastion host, it's actually the EC2 machine.

After create SSH Tunnel, you can use Database client software like MySQL Workbench, SQLectron, .... to connect to the database.

### Find your EC2 instance basic informations
Run this aws command, remember correct the `profile` and `region`

```aws ec2 --profile review-aggregator --region us-east-2 describe-instances --query 'Reservations[*].Instances[*].{Name:KeyName,ID:InstanceId,IPpublic:PublicIpAddress,DNS:PublicDnsName}'```

You will get data like this, all ec2 instances in that region.

```
[
    [
        {
            "Name": "prod-bastion-host",
            "ID": "i-016fe749910e1bf83",
            "IPpublic": "3.138.141.147",
            "DNS": "ec2-3-138-141-147.us-east-2.compute.amazonaws.com"
        }
    ]
]
```