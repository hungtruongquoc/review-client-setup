import json
import flask
import requests

app = flask.Flask(__name__)

@app.route("/health")
def health_check():
    return flask.jsonify(success=True)

@app.route("/register", methods = ['GET', 'POST'])
def sns():
    #print(flask.request.json)
    return flask.jsonify(flask.request.json)