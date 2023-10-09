-- Create a database for the E-Tender Management System
CREATE DATABASE e_tender_management;

-- Use the newly created database
USE e_tender_management;

-- Create tables for the system
-- Users table to store information about users (administrators, vendors, and evaluators)
CREATE TABLE users (
    user_id INT AUTO_INCREMENT PRIMARY KEY,
    username VARCHAR(50) NOT NULL UNIQUE,
    password VARCHAR(100) NOT NULL,
    user_type ENUM('admin', 'vendor', 'evaluator') NOT NULL
);

-- Tenders table to store information about tenders
CREATE TABLE tenders (
    tender_id INT AUTO_INCREMENT PRIMARY KEY,
    title VARCHAR(255) NOT NULL,
    description TEXT NOT NULL,
    published_date DATE NOT NULL,
    closing_date DATE NOT NULL,
    status ENUM('open', 'closed') DEFAULT 'open',
    created_by INT NOT NULL,
    FOREIGN KEY (created_by) REFERENCES users(user_id)
);

-- Bids table to store information about vendor bids
CREATE TABLE bids (
    bid_id INT AUTO_INCREMENT PRIMARY KEY,
    tender_id INT NOT NULL,
    vendor_id INT NOT NULL,
    bid_amount DECIMAL(10, 2) NOT NULL,
    bid_description TEXT NOT NULL,
    bid_status ENUM('submitted', 'accepted', 'rejected') DEFAULT 'submitted',
    submission_date TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY (tender_id) REFERENCES tenders(tender_id),
    FOREIGN KEY (vendor_id) REFERENCES users(user_id)
);

-- Evaluation table to store information about the evaluation of bids
CREATE TABLE evaluation (
    evaluation_id INT AUTO_INCREMENT PRIMARY KEY,
    bid_id INT NOT NULL,
    evaluator_id INT NOT NULL,
    score DECIMAL(5, 2) NOT NULL,
    comments TEXT,
    evaluation_date TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY (bid_id) REFERENCES bids(bid_id),
    FOREIGN KEY (evaluator_id) REFERENCES users(user_id)
);

SELECT *FROM users;
