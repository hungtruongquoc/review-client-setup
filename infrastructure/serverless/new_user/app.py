import json
import flask
import boto3

app = flask.Flask(__name__)

@app.route("/health")
def health_check():
    return flask.jsonify(success=True)

@app.route("/register", methods = ['GET', 'POST'])
def sns():
    #print(flask.request.json)
    sqs = boto3.client('sqs')
    queue_url = 'https://sqs.us-east-2.amazonaws.com/723567309652/TenantDbCreateQueue'
    response = sqs.send_message(
        QueueUrl=queue_url,
        DelaySeconds=10,
        MessageAttributes={
            'Title': {
                'DataType': 'String',
                'StringValue': 'The Whistler'
            },
            'Author': {
                'DataType': 'String',
                'StringValue': 'John Grisham'
            },
            'WeeksOn': {
                'DataType': 'Number',
                'StringValue': '6'
            }
        },
        MessageBody=(
            'Information about current NY Times fiction bestseller for '
            'week of 12/11/2016.'
        )
    )
    print(response['MessageId'])
    return flask.jsonify(flask.request.json)