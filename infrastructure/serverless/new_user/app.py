import json
import flask
import boto3
import logging
import time
from botocore.exceptions import ClientError


app = flask.Flask(__name__)

class register():
    def __init__(self,client_name,region=None):
        self.client_name = client_name
        self.region = region
        self.sqs_url = ""
        try:
            if self.region is None:
                self.region = "us-east-2"
            self.s3_client = boto3.client('s3', region_name=self.region)
            self.sqs_client = boto3.client("sqs")
        except ClientError as e:
            logging.error(e)
        

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
                QueueName='tenant-service-queue',
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
