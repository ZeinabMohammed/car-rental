CREATE DATABASE `carRental`;
USE `carRental`;

-- Create Tables and dump data


-- Create 'Vehicle' Table

CREATE TABLE `Vehicle` (
	`vehicle_ID` VARCHAR(50) NOT NULL,
	`vehicle_type` ENUM ('Small', 'Family', 'Van'),
	`rental_fees_per_day` FLOAT(255,2),
	PRIMARY KEY (`vehicle_ID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;




-- Create 'Customer' Table
CREATE OR REPLACE TABLE `Customer` (
	`customer_ID` INT AUTO_INCREMENT NOT NULL,
	`customer_name` VARCHAR(50) NOT NULL,
	`customer_email` VARCHAR(50) NOT NULL,
	PRIMARY KEY (`customer_ID`),
	UNIQUE(`customer_email`),
	INDEX (customer_ID, customer_name, customer_email)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;


-- Create 'Booking' Table
CREATE OR REPLACE TABLE `Booking` (
	`booking_ID` INT AUTO_INCREMENT NOT NULL,
	`customer_ID` INT NOT NULL ,
	`customer_name` VARCHAR(50) NOT NULL,
	`customer_email` VARCHAR(50) NOT NULL,
	`vehicle_ID` VARCHAR(50) NOT NULL,
	`pickup_date` DATE NOT NULL,
	`return_date` DATE NOT NULL,
	`status` ENUM ('Booked', 'IN Progress', 'Completed'), 
	
	PRIMARY KEY (`booking_ID`),
	 INDEX (customer_ID, customer_name, customer_email),
	 
	FOREIGN KEY (`customer_ID`, `customer_name`, `customer_email`) 
      REFERENCES Customer(`customer_ID`, `customer_name`, `customer_email`)
      ON DELETE CASCADE ON UPDATE CASCADE,

     
    FOREIGN KEY (`vehicle_ID`)
    	REFERENCES Vehicle(vehicle_ID)
        ON UPDATE CASCADE ON DELETE CASCADE) ENGINE=InnoDB DEFAULT CHARSET=utf8;


--- Add date constrains
ALTER TABLE Booking ADD CHECK (return_date > pickup_date);

ALTER TABLE Booking ADD CHECK (DATE(return_date) - DATE(pickup_date) <= 7);


-- Create 'Booking Invoice' Table

CREATE TABLE `Booking Invoice` (
	`invoice_ID` INT AUTO_INCREMENT NOT NULL,
	`booking_ID` INT NOT NULL,
	`payment_date` DATE,
	`payment_amount` FLOAT(255,2),
	`status` ENUM ('Paid', 'Unpaid') NOT NULL DEFAULT 'Unpaid',
	PRIMARY KEY (`invoice_ID`),
	UNIQUE(`booking_ID`),
    FOREIGN KEY (booking_ID)
    	REFERENCES Booking(booking_ID)
    	ON UPDATE CASCADE ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8;



CREATE OR REPLACE VIEW BookingDailyReport AS
SELECT `Booking`.booking_ID AS Booking,`Booking`.customer_ID AS Customer, 
	`Booking`.vehicle_ID AS Vehicle,
	`Booking Invoice`.status AS `Payment Status`
	FROM `Booking`
	JOIN `Booking Invoice`
		ON `Booking Invoice`.booking_ID = `Booking`.booking_ID
	WHERE `Booking`.status IN ('Booked', 'In Progress')
	AND `Booking`.pickup_date = CURDATE()






-- Dumping data for table `Customer`
--

INSERT INTO `Customer` (`customer_ID`, `customer_name`, `customer_email`) VALUES
(1, 'Ahmed', 'ahmed@gmail.com'),
(2, 'Mohammed', 'mohammed@gmail.com'),
(3, 'Ali', 'ali@gmail.com'),
(4, 'OLa', 'ola@gmail.com')

-- Dumping data for table `Vehicle`
--

INSERT INTO `Vehicle` (`vehicle_ID`, `vehicle_type`, `rental_fees_per_day`) VALUES
('VAN-0001', 'Van', 100.00),
('VAN-0002', 'Van', 150.0),
('FAMILY-0001', 'Family', 500.0),
('FAMILY-0002', 'Family', 700.0),
('SMALL-0001', 'Small', 100),
('SMALL-0002', 'Small', 75)

-- Dumping data for table `Booking`

INSERT INTO `Booking` (`booking_ID`, `customer_ID`, `customer_email`, `customer_name`, `vehicle_ID`, `pickup_date`, `return_date`, `status`) VALUES
(1, 1, 'ahmed@gmail.com','Ahmed', 'VAN-0001', '2023-03-01','2023-03-03', 'Completed'),
(2, 2, 'mohammed@gmail.com','Mohammed', 'VAN-0002', '2023-03-10','2023-03-16', 'In Progress'),
(3, 3, 'ali@gmail.com', 'Ali', 'SMALL-0001','2023-03-20','2023-03-21', 'Completed'),
(4, 4, 'ola@gmail.com', 'Ola','FAMILY-0001','2023-05-01','2023-05-03', 'Booked')



-- Dumping data for table `Booking Invoice`

INSERT INTO `Booking Invoice` (`invoice_ID`, `booking_ID`, `payment_date`, `payment_amount`, `status`) VALUES
(1, 1,'2023-03-01', 200.0 ,'Paid'),
(2, 2,'2023-03-10',4500.0, 'Paid'),
(3, 3,'2023-03-20',100.0 ,'Paid'),
(4, 4,NULL,1000.0, 'Unpaid')




