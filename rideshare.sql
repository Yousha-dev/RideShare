-- phpMyAdmin SQL Dump
-- version 5.1.1
-- https://www.phpmyadmin.net/
--
-- Host: 127.0.0.1
-- Generation Time: Dec 08, 2023 at 07:42 AM
-- Server version: 10.4.21-MariaDB
-- PHP Version: 7.4.24

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Database: `rideshare`
--

-- --------------------------------------------------------

-- Table structure for table `accounts`
CREATE TABLE `accounts` (
  `username` varchar(50) NOT NULL,
  `password` varchar(50) NOT NULL,
  PRIMARY KEY (`username`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- Table structure for table `admins`
CREATE TABLE `admins` (
  `ADM_EMAIL_ID` varchar(50) NOT NULL,
  PRIMARY KEY (`ADM_EMAIL_ID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- Table structure for table `cardinfo`
CREATE TABLE `cardinfo` (
  `passenger_id` varchar(50) NOT NULL,
  `cardholder_name` varchar(50) NOT NULL,
  `card_number` int(50) NOT NULL,
  `Expiry_date` date NOT NULL,
  PRIMARY KEY (`passenger_id`),
  FOREIGN KEY (`passenger_id`) REFERENCES `users` (`Email_ID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- Table structure for table `chat`
CREATE TABLE `chat` (
  `ride_id` int(10) NOT NULL,
  `passenger_id` varchar(50) NOT NULL,
  `message` varchar(100) NOT NULL,
  PRIMARY KEY (`ride_id`, `passenger_id`),
  FOREIGN KEY (`ride_id`) REFERENCES `offered_rides` (`Ride_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- Table structure for table `completed_rides`
CREATE TABLE `completed_rides` (
  `ride_id` int(10) NOT NULL,
  `driver_id` varchar(50) NOT NULL,
  `is_to_uni` int(10) NOT NULL,
  `Arrival_dep_time` timestamp NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp(),
  `Start_location` varchar(50) NOT NULL,
  `End_location` varchar(50) NOT NULL,
  PRIMARY KEY (`ride_id`),
  FOREIGN KEY (`driver_id`) REFERENCES `drivers` (`DRIVER_ID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- Table structure for table `confirmed_rides`
CREATE TABLE `confirmed_rides` (
  `Ride_ID` int(10) NOT NULL,
  `Passenger_ID` varchar(50) NOT NULL,
  PRIMARY KEY (`Ride_ID`, `Passenger_ID`),
  FOREIGN KEY (`Ride_ID`) REFERENCES `offered_rides` (`Ride_id`),
  FOREIGN KEY (`Passenger_ID`) REFERENCES `users` (`Email_ID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- Table structure for table `drivers`
CREATE TABLE `drivers` (
  `DRIVER_ID` varchar(50) NOT NULL,
  PRIMARY KEY (`DRIVER_ID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- Table structure for table `driver_applications`
CREATE TABLE `driver_applications` (
  `EMAIL_ID` varchar(50) NOT NULL,
  `CAR_MODEL` varchar(50) NOT NULL,
  `CAR_CAPACITY` int(10) NOT NULL,
  PRIMARY KEY (`EMAIL_ID`),
  FOREIGN KEY (`EMAIL_ID`) REFERENCES `users` (`Email_ID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- Table structure for table `offered_rides`
CREATE TABLE `offered_rides` (
  `Ride_id` int(10) NOT NULL,
  `Driver_id` varchar(50) NOT NULL,
  `Is_to_uni` int(10) NOT NULL,
  `Arrival_Dep_Time` timestamp NULL DEFAULT NULL,
  `Start_location` varchar(50) NOT NULL,
  `End_location` varchar(50) NOT NULL,
  `Current_Seat_Avail` int(10) NOT NULL,
  PRIMARY KEY (`Ride_id`),
  FOREIGN KEY (`Driver_id`) REFERENCES `drivers` (`DRIVER_ID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- Table structure for table `offered_single_rides`
CREATE TABLE `offered_single_rides` (
  `Ride_ID` int(10) NOT NULL,
  `Ride_Date` date NOT NULL,
  PRIMARY KEY (`Ride_ID`),
  FOREIGN KEY (`Ride_ID`) REFERENCES `offered_rides` (`Ride_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- Table structure for table `offered_weekly_rides`
CREATE TABLE `offered_weekly_rides` (
  `Ride_ID` int(10) NOT NULL,
  `Day` varchar(50) NOT NULL,
  PRIMARY KEY (`Ride_ID`),
  FOREIGN KEY (`Ride_ID`) REFERENCES `offered_rides` (`Ride_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- Table structure for table `payment`
CREATE TABLE `payment` (
  `ride_id` int(10) NOT NULL,
  `passenger_id` varchar(50) NOT NULL,
  `isCash` int(10) NOT NULL,
  `amount` int(10) NOT NULL,
  PRIMARY KEY (`ride_id`, `passenger_id`),
  FOREIGN KEY (`ride_id`) REFERENCES `completed_rides` (`ride_id`),
  FOREIGN KEY (`passenger_id`) REFERENCES `users` (`Email_ID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- Table structure for table `review`
CREATE TABLE `review` (
  `ride_id` int(10) NOT NULL,
  `passenger_id` varchar(50) NOT NULL,
  `message` varchar(100) NOT NULL,
  `stars` int(10) NOT NULL,
  PRIMARY KEY (`ride_id`, `passenger_id`),
  FOREIGN KEY (`ride_id`) REFERENCES `completed_rides` (`ride_id`),
  FOREIGN KEY (`passenger_id`) REFERENCES `users` (`Email_ID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- Table structure for table `ride_requests`
CREATE TABLE `ride_requests` (
  `Ride_ID` int(10) NOT NULL,
  `Passenger_ID` varchar(50) NOT NULL,
  `Pickup_Location` varchar(50) NOT NULL,
  `Dropoff_Location` varchar(50) NOT NULL,
  PRIMARY KEY (`Ride_ID`, `Passenger_ID`),
  FOREIGN KEY (`Ride_ID`) REFERENCES `offered_rides` (`Ride_id`),
  FOREIGN KEY (`Passenger_ID`) REFERENCES `users` (`Email_ID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- Table structure for table `users`
CREATE TABLE `users` (
  `Email_ID` varchar(50) NOT NULL,
  `First_Name` varchar(50) NOT NULL,
  `Last_name` varchar(50) NOT NULL,
  `Gender` varchar(10) NOT NULL,
  `Mobile_No` varchar(50) NOT NULL,
  PRIMARY KEY (`Email_ID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;


CREATE TABLE `log` (
  `ID` int(11) NOT NULL,
  `Email_ID` varchar(40) NOT NULL,
  `First_Name` varchar(40) NOT NULL,
  `Last_Name` varchar(30) NOT NULL,
  `Gender` varchar(30) NOT NULL,
  `Mobile_No` varchar(30) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;


CREATE TABLE `confirmed_ride_log` (
  `ID` int(11) NOT NULL,
  `Ride_id` int(11) NOT NULL,
  `Driver_id` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;


CREATE TABLE `offeredride_log` (
  `ID` int(11) NOT NULL,
  `Ride_id` int(11) NOT NULL,
  `Driver_id` int(11) NOT NULL,
  `Is_to_uni` varchar(40) NOT NULL,
  `Arrival_Dep_Time` varchar(40) NOT NULL,
  `Start_location` varchar(40) NOT NULL,
  `End_location` varchar(40) NOT NULL,
  `Current_Seat_Avail` varchar(40) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

DELIMITER $$
CREATE TRIGGER `confirmed_rides_record` AFTER INSERT ON `confirmed_rides` FOR EACH ROW INSERT INTO confirmed_ride_log(ID, Ride_ID, Passenger_ID)
    VALUES (null, NEW.Ride_ID, NEW.Passenger_ID)
$$
DELIMITER ;

DELIMITER $$
CREATE TRIGGER `Delete_rides` AFTER DELETE ON `offered_rides` FOR EACH ROW INSERT INTO offeredride_log (ID, Ride_id, Driver_id, Is_to_uni, Arrival_Dep_Time, Start_location, End_location, Current_Seat_Avail)
    VALUES (null, OLD.Ride_id, OLD.Driver_id, OLD.Is_to_uni, OLD.Arrival_Dep_Time, OLD.Start_location, OLD.End_location, OLD.Current_Seat_Avail)
$$
DELIMITER ;

DELIMITER $$
CREATE TRIGGER `user_audit_log` AFTER INSERT ON `users` FOR EACH ROW INSERT INTO log (ID, Email_ID, First_Name, Last_Name, Gender, Mobile_No)
    VALUES (null, NEW.Email_ID, NEW.First_Name, NEW.Last_Name, NEW.Gender, NEW.Mobile_No)
$$
DELIMITER ;

COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
