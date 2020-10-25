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