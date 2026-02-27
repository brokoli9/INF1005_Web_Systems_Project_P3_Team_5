-- ===========================
-- Database Setup
-- Run this in phpMyAdmin SQL tab
-- ===========================

-- Create and select the database
CREATE DATABASE IF NOT EXISTS carmarketplace;
USE carmarketplace;

-- ---- Users Table ----
CREATE TABLE users (
    user_id     INT AUTO_INCREMENT PRIMARY KEY,
    username    VARCHAR(50) NOT NULL UNIQUE,
    email       VARCHAR(100) NOT NULL UNIQUE,
    password    VARCHAR(255) NOT NULL,         -- store hashed passwords only
    phone       VARCHAR(20),
    role        ENUM('buyer', 'seller', 'admin') DEFAULT 'buyer',
    created_at  TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

-- ---- Car Listings Table ----
CREATE TABLE listings (
    listing_id  INT AUTO_INCREMENT PRIMARY KEY,
    seller_id   INT NOT NULL,
    title       VARCHAR(150) NOT NULL,
    make        VARCHAR(50) NOT NULL,
    model       VARCHAR(50) NOT NULL,
    year        INT NOT NULL,
    price       DECIMAL(10, 2) NOT NULL,
    mileage     INT DEFAULT 0,
    condition   ENUM('new', 'like_new', 'good', 'fair') NOT NULL,
    description TEXT,
    image_path  VARCHAR(255),
    status      ENUM('active', 'sold') DEFAULT 'active',
    created_at  TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    updated_at  TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
    FOREIGN KEY (seller_id) REFERENCES users(user_id) ON DELETE CASCADE
);

-- ---- Inquiries / Contact Messages Table ----
CREATE TABLE inquiries (
    inquiry_id  INT AUTO_INCREMENT PRIMARY KEY,
    listing_id  INT,
    name        VARCHAR(100),
    email       VARCHAR(100),
    message     TEXT NOT NULL,
    sent_at     TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY (listing_id) REFERENCES listings(listing_id) ON DELETE SET NULL
);

-- ---- Saved/Favourites Table ----
CREATE TABLE favourites (
    favourite_id    INT AUTO_INCREMENT PRIMARY KEY,
    user_id         INT NOT NULL,
    listing_id      INT NOT NULL,
    saved_at        TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY (user_id) REFERENCES users(user_id) ON DELETE CASCADE,
    FOREIGN KEY (listing_id) REFERENCES listings(listing_id) ON DELETE CASCADE,
    UNIQUE KEY unique_favourite (user_id, listing_id)
);
