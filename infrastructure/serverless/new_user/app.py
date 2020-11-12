import json
import flask
import boto3
import logging
import time
from botocore.exceptions import ClientError

app = flask.Flask(__name__)

class register():
    def __init__(self,client_name,region="us-east-2"):
        self.client_name = client_name
        self.region = region
        try:
            self.cloudfront_client = boto3.client('cloudfront')
            self.s3_client = boto3.client('s3', region_name=self.region)
            self.sqs_client = boto3.client("sqs")
        except ClientError as e:
            logging.error(e)

    
    def create_cloudfront_oai(self):
        response = self.cloudfront_client.create_cloud_front_origin_access_identity(
            CloudFrontOriginAccessIdentityConfig={
                'CallerReference': '{}'.format(time.time()),
                'Comment': '{} Cloudfront Origin Access Identity'.format(self.client_name)
            }
        )
        print(response)

    
    def create_cloudfront_distribution(self):
        try:
            response = self.cloudfront_client.create_distribution_with_tags(
                DistributionConfigWithTags={
                    'DistributionConfig': {
                        'CallerReference': '{}'.format(time.time()),
                        'Aliases': {
                            'Quantity': 123,
                            'Items': [
                                'string',
                            ]
                        },
                        'DefaultRootObject': 'string',
                        'Origins': {
                            'Quantity': 123,
                            'Items': [
                                {
                                    'Id': 'string',
                                    'DomainName': 'string',
                                    'OriginPath': 'string',
                                    'CustomHeaders': {
                                        'Quantity': 123,
                                        'Items': [
                                            {
                                                'HeaderName': 'string',
                                                'HeaderValue': 'string'
                                            },
                                        ]
                                    },
                                    'S3OriginConfig': {
                                        'OriginAccessIdentity': 'string'
                                    },
                                    'CustomOriginConfig': {
                                        'HTTPPort': 123,
                                        'HTTPSPort': 123,
                                        'OriginProtocolPolicy': 'http-only'|'match-viewer'|'https-only',
                                        'OriginSslProtocols': {
                                            'Quantity': 123,
                                            'Items': [
                                                'SSLv3'|'TLSv1'|'TLSv1.1'|'TLSv1.2',
                                            ]
                                        },
                                        'OriginReadTimeout': 123,
                                        'OriginKeepaliveTimeout': 123
                                    },
                                    'ConnectionAttempts': 123,
                                    'ConnectionTimeout': 123,
                                    'OriginShield': {
                                        'Enabled': True|False,
                                        'OriginShieldRegion': 'string'
                                    }
                                },
                            ]
                        },
                        'OriginGroups': {
                            'Quantity': 123,
                            'Items': [
                                {
                                    'Id': 'string',
                                    'FailoverCriteria': {
                                        'StatusCodes': {
                                            'Quantity': 123,
                                            'Items': [
                                                123,
                                            ]
                                        }
                                    },
                                    'Members': {
                                        'Quantity': 123,
                                        'Items': [
                                            {
                                                'OriginId': 'string'
                                            },
                                        ]
                                    }
                                },
                            ]
                        },
                        'DefaultCacheBehavior': {
                            'TargetOriginId': 'string',
                            'TrustedSigners': {
                                'Enabled': True|False,
                                'Quantity': 123,
                                'Items': [
                                    'string',
                                ]
                            },
                            'TrustedKeyGroups': {
                                'Enabled': True|False,
                                'Quantity': 123,
                                'Items': [
                                    'string',
                                ]
                            },
                            'ViewerProtocolPolicy': 'allow-all'|'https-only'|'redirect-to-https',
                            'AllowedMethods': {
                                'Quantity': 123,
                                'Items': [
                                    'GET'|'HEAD'|'POST'|'PUT'|'PATCH'|'OPTIONS'|'DELETE',
                                ],
                                'CachedMethods': {
                                    'Quantity': 123,
                                    'Items': [
                                        'GET'|'HEAD'|'POST'|'PUT'|'PATCH'|'OPTIONS'|'DELETE',
                                    ]
                                }
                            },
                            'SmoothStreaming': True|False,
                            'Compress': True|False,
                            'LambdaFunctionAssociations': {
                                'Quantity': 123,
                                'Items': [
                                    {
                                        'LambdaFunctionARN': 'string',
                                        'EventType': 'viewer-request'|'viewer-response'|'origin-request'|'origin-response',
                                        'IncludeBody': True|False
                                    },
                                ]
                            },
                            'FieldLevelEncryptionId': 'string',
                            'RealtimeLogConfigArn': 'string',
                            'CachePolicyId': 'string',
                            'OriginRequestPolicyId': 'string',
                            'ForwardedValues': {
                                'QueryString': True|False,
                                'Cookies': {
                                    'Forward': 'none'|'whitelist'|'all',
                                    'WhitelistedNames': {
                                        'Quantity': 123,
                                        'Items': [
                                            'string',
                                        ]
                                    }
                                },
                                'Headers': {
                                    'Quantity': 123,
                                    'Items': [
                                        'string',
                                    ]
                                },
                                'QueryStringCacheKeys': {
                                    'Quantity': 123,
                                    'Items': [
                                        'string',
                                    ]
                                }
                            },
                            'MinTTL': 123,
                            'DefaultTTL': 123,
                            'MaxTTL': 123
                        },
                        'CacheBehaviors': {
                            'Quantity': 123,
                            'Items': [
                                {
                                    'PathPattern': 'string',
                                    'TargetOriginId': 'string',
                                    'TrustedSigners': {
                                        'Enabled': True|False,
                                        'Quantity': 123,
                                        'Items': [
                                            'string',
                                        ]
                                    },
                                    'TrustedKeyGroups': {
                                        'Enabled': True|False,
                                        'Quantity': 123,
                                        'Items': [
                                            'string',
                                        ]
                                    },
                                    'ViewerProtocolPolicy': 'allow-all'|'https-only'|'redirect-to-https',
                                    'AllowedMethods': {
                                        'Quantity': 123,
                                        'Items': [
                                            'GET'|'HEAD'|'POST'|'PUT'|'PATCH'|'OPTIONS'|'DELETE',
                                        ],
                                        'CachedMethods': {
                                            'Quantity': 123,
                                            'Items': [
                                                'GET'|'HEAD'|'POST'|'PUT'|'PATCH'|'OPTIONS'|'DELETE',
                                            ]
                                        }
                                    },
                                    'SmoothStreaming': True|False,
                                    'Compress': True|False,
                                    'LambdaFunctionAssociations': {
                                        'Quantity': 123,
                                        'Items': [
                                            {
                                                'LambdaFunctionARN': 'string',
                                                'EventType': 'viewer-request'|'viewer-response'|'origin-request'|'origin-response',
                                                'IncludeBody': True|False
                                            },
                                        ]
                                    },
                                    'FieldLevelEncryptionId': 'string',
                                    'RealtimeLogConfigArn': 'string',
                                    'CachePolicyId': 'string',
                                    'OriginRequestPolicyId': 'string',
                                    'ForwardedValues': {
                                        'QueryString': True|False,
                                        'Cookies': {
                                            'Forward': 'none'|'whitelist'|'all',
                                            'WhitelistedNames': {
                                                'Quantity': 123,
                                                'Items': [
                                                    'string',
                                                ]
                                            }
                                        },
                                        'Headers': {
                                            'Quantity': 123,
                                            'Items': [
                                                'string',
                                            ]
                                        },
                                        'QueryStringCacheKeys': {
                                            'Quantity': 123,
                                            'Items': [
                                                'string',
                                            ]
                                        }
                                    },
                                    'MinTTL': 123,
                                    'DefaultTTL': 123,
                                    'MaxTTL': 123
                                },
                            ]
                        },
                        'CustomErrorResponses': {
                            'Quantity': 123,
                            'Items': [
                                {
                                    'ErrorCode': 123,
                                    'ResponsePagePath': 'string',
                                    'ResponseCode': 'string',
                                    'ErrorCachingMinTTL': 123
                                },
                            ]
                        },
                        'Comment': 'string',
                        'Logging': {
                            'Enabled': True|False,
                            'IncludeCookies': True|False,
                            'Bucket': 'string',
                            'Prefix': 'string'
                        },
                        'PriceClass': 'PriceClass_100'|'PriceClass_200'|'PriceClass_All',
                        'Enabled': True|False,
                        'ViewerCertificate': {
                            'CloudFrontDefaultCertificate': True|False,
                            'IAMCertificateId': 'string',
                            'ACMCertificateArn': 'string',
                            'SSLSupportMethod': 'sni-only'|'vip'|'static-ip',
                            'MinimumProtocolVersion': 'SSLv3'|'TLSv1'|'TLSv1_2016'|'TLSv1.1_2016'|'TLSv1.2_2018'|'TLSv1.2_2019',
                            'Certificate': 'string',
                            'CertificateSource': 'cloudfront'|'iam'|'acm'
                        },
                        'Restrictions': {
                            'GeoRestriction': {
                                'RestrictionType': 'blacklist'|'whitelist'|'none',
                                'Quantity': 123,
                                'Items': [
                                    'string',
                                ]
                            }
                        },
                        'WebACLId': 'string',
                        'HttpVersion': 'http1.1'|'http2',
                        'IsIPV6Enabled': True|False
                    },
                    'Tags': {
                        'Items': [
                            {
                                'Key': 'string',
                                'Value': 'string'
                            },
                        ]
                    }
                }
            )
        except ClientError as e:
            logging(e)


    def create_bucket(self):
        try:
            logging.info("Create s3 client")
            location = {'LocationConstraint': self.region}
            logging.info("Set localtion")
            self.s3_client.create_bucket(Bucket=self.client_name,CreateBucketConfiguration=location)
            logging.info("Created Bucket")
            return True
        except ClientError as e:
            logging.error(e)
            return e

    def get_sqs_url(self):
        try:
            response = self.sqs_client.get_queue_url(
                QueueName='TenantDbCreateQueue',
                QueueOwnerAWSAccountId='723567309652'
            )
            return str(response['QueueUrl'])
        except ClientError as e:
            logging.error(e)
            return False

    def send_message(self):
        try:
            response = self.sqs_client.send_message(
                    QueueUrl='{}'.format(self.get_sqs_url()),
                    MessageBody='New client register on {}'.format(time.time()),
                    DelaySeconds=0,
                    MessageAttributes={
                        'title': {
                            'StringValue': 'new client',
                            'DataType': 'String'
                        },
                        'client_name': {
                            'StringValue': '{}'.format(self.client_name),
                            'DataType': 'String'
                        },
                        'cloudfront_distribution_id': {
                            'StringValue': '{}'.format("testing"),
                            'DataType': 'String'
                        }
                    }
            )
            print(response)
        except ClientError as e:
            logging.error(e)
            return False


@app.route("/health")
def health_check():
    return flask.jsonify(success=True)

@app.route("/register", methods = ['GET', 'POST'])
def main():
    client_info = flask.request.json
    new_user = register(client_info['client_name'])
    result = new_user.create_bucket()
    new_user.send_message()
    if result == True: 
        return flask.jsonify(success=True)
    else:
        return flask.jsonify(Error=str(result)), 400
