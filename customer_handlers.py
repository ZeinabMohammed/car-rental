from flask_mysqldb import MySQL
from flask import jsonify
from typing import Dict
#TODO: create data modeling for inputs & outputs

def respond(message:str =None, developer_message: str =None, data: list =None, code: int =200):
	if not data:
		data=[]
	return {'code':code, 'message': message, 'developer_message': developer_message, 'data': data}


def validate_required_params(input_data: Dict, required_params: list):
	for param in required_params:
		if not input_data.get(param):
			return False, respond(message="Missing required input: {0}".format(param), developer_message="Missing Inputs", code=417)
	return True, None


def customer_is_found(cursor, customer_id):
	return cursor.execute("SELECT customer_ID FROM Customer WHERE customer_ID = %s", (customer_id,))


def create_customer(data_input: Dict, mysql):
	valid_inputs, inputs_res = validate_required_params(data_input, ['customer_name', 'customer_email'])

	if not valid_inputs:
		return inputs_res
	try:
		customer_name = data_input.get('customer_name')
		customer_email = data_input.get("customer_email")
		conn = mysql.connection
		cursor = conn.cursor()
		sql = "INSERT INTO Customer(customer_name, customer_email) VALUES(%s, %s)"
		data = (customer_name, customer_email)

		cursor.execute(sql, data)
		conn.commit()
		cursor.close()
		return respond(code=200, message="Customer {0} was created successfully".format(customer_email), developer_message="Success")

	except Exception as e:
		return respond(message="An error occured; please contact support", developer_message=str(e), code=417)


def update_customer(data_input,mysql):
	valid_params, params_res = validate_required_params(data_input, ['customer_id'])

	if not valid_params:
		return params_res

	set_statement = ''
	customer_id = data_input.get('customer_id')

	customer_name = data_input.get('customer_name')
	customer_email = data_input.get('customer_email')
	if not customer_name and not customer_email:
		return respond(message="Nothing to update!", developer_message="Pass columns to be updated", code=417)

	if customer_name:
		set_statement += " customer_name='{0}' ".format(customer_name)
	if customer_email:
		if customer_name:
			set_statement += " , "
		set_statement += " customer_email='{0}' ".format(customer_email)

	if set_statement:
		try:
			conn = mysql.connection
			cursor = conn.cursor()
			if not customer_is_found(cursor, customer_id):
				return respond(message="Customer {0} is not found".format(customer_id), developer_message="Not Found", code=404)
			sql = "UPDATE Customer SET {0} WHERE customer_ID={1}".format(set_statement, customer_id)
			data=(customer_name, customer_email,set_statement, customer_id)

			cursor.execute(sql)
			conn.commit()
			cursor.close()
			return respond(code=200, message="Customer {0} updated successfully".format(customer_email), developer_message="Success")
		except Exception as e:
			return respond(message="An error occured; please contact support", developer_message=str(e), code=417)



def get_customer_details(customer_id,mysql):
	try:
		connection = mysql.connection
		connection_cursor = mysql.connection.cursor()
		if not customer_is_found(connection_cursor, customer_id):
			return respond(message="Customer {0} is not found".format(customer_id), developer_message="Not Found", code=404)

		connection_cursor.execute("SELECT *  FROM Customer WHERE customer_ID=%s", (customer_id,))
		row_data = [dict(zip([column[0] for column in connection_cursor.description], row))
             for row in connection_cursor.fetchall()]

		connection.commit()
		connection_cursor.close()
		return respond(code=200, data= row_data, developer_message="Success")
	except Exception as e:
		return respond(message="An error occurred; please contact support", developer_message=str(e), code=417)

def delete_customer(customer_id,mysql):
	try:
		conn = mysql.connection
		cursor = mysql.connection.cursor()
		if not customer_is_found(cursor, customer_id):
			return respond(message="Customer {0} is not found".format(customer_id), developer_message="Not Found", code=404)

		cursor.execute("DELETE FROM Customer WHERE customer_ID=%s", (customer_id,))
		conn.commit()
		cursor.close()
		return respond(code=200, message="Customer {0} deleted successfully".format(customer_id), developer_message="Success")

	except Exception as e:
		return respond(message="An error occurred; please contact support", developer_message=str(e), code=417)
