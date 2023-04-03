# Customer APIs

## Objective

To create, update, get or delete customer

## 1. Create Customer
### URL

`POST {{url}}/customer`

### Input

#### Json Body

```json
{
    "customer_email":"ali@gmail.com", //required
    "customer_name": "Ali" //required
}
```

### Output

```json
{
    "code": 200,
    "data": [],
    "developer_message": "Success",
    "message": "Customer created successfully"
}
```
#### Expected exception examples
 ##### #1 Duplicate customer
```json
{
    "code": 417,
    "data": [],
    "developer_message": "(1062, \"Duplicate entry 'ahmed@yahoo.com' for key 'customer_email'\")",
    "message": "An error occurred; please contact support"
}
```
 ##### #2 Missing required inputs
```json
{
    "code": 417,
    "data": [],
    "developer_message": "Missing Inputs",
    "message": "Missing required input: customer_id"
}

```
## 2. Update Customer
### URL

`PUT {{url}}/customer`

### Input

#### Json Body

```json
{
    "customer_id": 1, //required
    "customer_email":"ali@gmail.com", //optional
    "customer_name": "Ali" //optional
}
```

#### Output
```json
{
    "code": 200,
    "data": [],
    "developer_message": "Success",
    "message": "Customer ali@gmail.com was created successfully"
}
```
#### Expected exception response examples
 ##### #1 Missing required inputs
```json
{
    "code": 417,
    "data": [],
    "developer_message": "Missing Inputs",
    "message": "Missing required input: customer_email"
}

```
 ##### #2 Duplicate entry
```json
{
    "code": 417,
    "data": [],
    "developer_message": "(1062, \"Duplicate entry 'aswwsswb@a.com' for key 'customer_email'\")",
    "message": "An error occurred; please contact support"
}
```

 ##### #3 Not exist customer_id
```json
{
    "code": 404,
    "data": [],
    "developer_message": "Not Found",
    "message": "Customer 9 is not found"
}
```

## 3. Get Customer
### URL

`GET {{url}}/customer/<{id}>`

### Input

#### Query parms

| Param | Required | Description                          | Type    |
|------|----------|--------------------------------------|---------|
| {id} | True     | ID of the customer to get details of | Integer |

#### Output
```json
{
    "code": 200,
    "data": [
        {
            "customer_ID": 26,
            "customer_email": "hanahany@gmail.com",
            "customer_name": "hanahany"
        }
    ],
    "developer_message": "Success",
    "message": null
}
```
#### Expected exception examples
 ##### #1 Customer not found
```json
{
    "code": 404,
    "data": [],
    "developer_message": "Not Found",
    "message": "Customer 1 is not found"
}
```
## 4. Delete Customer
### URL

`DELETE {{url}}/customer/{id}`

### Input

#### Query parms


| Param | Required | Description                      | Type    |
|------|----------|----------------------------------|---------|
| {id} | True     | ID of the customer to be deleted | Integer |

#### Output
```json
{
    "code": 200,
    "data": [],
    "developer_message": "Success",
    "message": "Customer 12 deleted successfully"
}
```
#### Expected exception examples
 ##### #1 Customer not found
```json
{
    "code": 404,
    "data": [],
    "developer_message": "Not Found",
    "message": "Customer 1 is not found"
}
```

