from flask import Flask, request
from flask_mysqldb import MySQL
from flask import jsonify
from typing import Dict
from .customer_handlers import create_customer, update_customer, get_customer_details, delete_customer


app = Flask(__name__)
if __name__ == "__main__":
	app.run()


app.config['MYSQL_HOST'] = 'localhost'
app.config['MYSQL_USER'] = 'root'
app.config['MYSQL_PASSWORD'] = '123' #replace with your root password
app.config['MYSQL_DB'] = 'carRental' #database should be created first using SQL file 'car_rental.sql'

mysql = MySQL(app)



@app.route('/customer', methods=["POST", "PUT"])
def post_or_update_customer():
	input_data = request.json
	if request.method == 'POST':
		return create_customer(input_data, mysql)

	elif request.method == "PUT":
		return update_customer(input_data, mysql)


@app.route('/customer/<int:id>', methods=["GET", "DELETE"])
def get_or_delete_customer(id):
	if request.method == 'GET':
		return get_customer_details(id,mysql)

	elif request.method == "DELETE":
		return delete_customer(id, mysql)





