from flask import Flask, jsonify
import os

app = Flask(__name__)

@app.route('/health')
def health():
    return jsonify({"status": "healthy"})

@app.route('/orders', methods=['GET'])
def get_orders():
    return jsonify({"message": "Order service is running"})

if __name__ == '__main__':
    app.run(host='0.0.0.0', port=8080)
