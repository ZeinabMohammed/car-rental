![car_rental_logo.png](car_rental_logo.png)

# Car Rental System
Car rental system enables customers to hire cars for a period not exceeding 7 days.
ORM is not used in this task as required, just solid principles.
## Database models used in the solution
- Database as SQL file : [car_rental.sql](car_rental.sql)
- Business models ERD: [car_rental_erd](car_rental_erd.png)
## Further enhancements: 
- Handle different payment methods & different payment currencies.
- Handle users & customer authentication & permissions..


# Dependencies & configurations needed to run the code.
- clone this repo on your computerby running int your terminal or cmd:

    `git clone https://github.com/ZeinabMohammed/car-rental.git`
- Download [Database SQL file] [car_rental.sql](car_rental.sql)
- To Add database and tables; Connect to your local server and run SQL file in mysql query editor or any db tool, I can recommend [Dbeaver](https://dbeaver.io/download/), it's free!
- Make a separate [python virtual environment](https://packaging.python.org/guides/installing-using-pip-and-virtual-environments/) or use the default one already installed on your machine if you have.
  - Navigate o the project directory
    - Run 
  
    **``` pip install -r requirements.txt ```** 
    - Run 
      **``` flask --app app run  ```** inside the directory to run the project
    - You can use [Postman] to test Customer endpoints, but please read [the docs]([customer_docs.md](customer_docs.md)) first.

