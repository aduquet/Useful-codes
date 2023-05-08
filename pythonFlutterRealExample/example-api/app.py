from flask import Flask, request
from flask_restful import reqparse, abort, Api, Resource
import argparse as parser


app = Flask(__name__)
# api = Api(app)

TODOS = {
    'A': 0,
    'B': 0,
}

def saveCounter(id, count):
    print(id)
    print('***')
    print(count)
    print('wohooo')
    return {id:count}


@app.route('/a', methods=['POST'])
def adding_a():
    global TODOS
    a = request.json['a']
    TODOS.update({'A':a})
    return 'done'

@app.route('/b', methods=['POST'])
def adding_b():
    global TODOS
    a = request.json['b']
    TODOS.update({'B':a})
    return 'done'

@app.route('/addition', methods=['GET'])
def adding():
    global TODOS
    
    result = int(TODOS['A'])+int(TODOS['B']) 
    
    return str(result)


@app.route("/")
def hello_world():
    return TODOS

if __name__ == '__main__':
    app.run(port=8080,debug=True)