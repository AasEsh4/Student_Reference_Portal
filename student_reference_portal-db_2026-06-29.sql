-- phpMyAdmin SQL Dump
-- version 5.2.1
-- https://www.phpmyadmin.net/
--
-- Host: 127.0.0.1:3306
-- Generation Time: Jun 29, 2026 at 11:17 AM
-- Server version: 8.2.0
-- PHP Version: 8.3.0

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Database: `student_reference_portal`
--

-- --------------------------------------------------------

--
-- Table structure for table `articles`
--

CREATE TABLE `articles` (
  `article_id` int NOT NULL,
  `title` varchar(255) NOT NULL,
  `content` longtext,
  `subject_id` int NOT NULL,
  `category_id` int NOT NULL,
  `created_by` int NOT NULL,
  `status` enum('Published','Draft') DEFAULT 'Published',
  `created_at` timestamp NULL DEFAULT CURRENT_TIMESTAMP,
  `updated_at` timestamp NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

--
-- Dumping data for table `articles`
--

INSERT INTO `articles` (`article_id`, `title`, `content`, `subject_id`, `category_id`, `created_by`, `status`, `created_at`, `updated_at`) VALUES
(1, 'Claude Monet Biogr', 'Biography of Claude Monet...', 1, 1, 2, 'Published', '2026-06-29 06:05:56', '2026-06-29 06:09:07'),
(2, 'Leonardo da Vinci Biography', 'Biography of Leonardo da Vinci...', 1, 1, 2, 'Published', '2026-06-29 06:05:56', '2026-06-29 06:05:56'),
(5, 'my program', 'nddjdjkdkdkddkdkdkdkd', 2, 1, 2, 'Published', '2026-06-29 06:10:32', '2026-06-29 06:10:32'),
(6, 'bsnsn', 'bbsbsshshs', 1, 1, 1, 'Published', '2026-06-29 06:14:48', '2026-06-29 06:14:48'),
(9, 'Updated Test Article', 'This is a test article for database testing', 2, 2, 2, 'Published', '2026-06-29 10:07:52', '2026-06-29 10:09:54');

-- --------------------------------------------------------

--
-- Table structure for table `article_artworks`
--

CREATE TABLE `article_artworks` (
  `article_id` int NOT NULL,
  `artwork_id` int NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

-- --------------------------------------------------------

--
-- Table structure for table `article_events`
--

CREATE TABLE `article_events` (
  `article_id` int NOT NULL,
  `event_id` int NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

-- --------------------------------------------------------

--
-- Table structure for table `article_people`
--

CREATE TABLE `article_people` (
  `article_id` int NOT NULL,
  `person_id` int NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

--
-- Dumping data for table `article_people`
--

INSERT INTO `article_people` (`article_id`, `person_id`) VALUES
(1, 1),
(2, 2);

-- --------------------------------------------------------

--
-- Table structure for table `artworks`
--

CREATE TABLE `artworks` (
  `artwork_id` int NOT NULL,
  `name` varchar(150) DEFAULT NULL,
  `year` smallint DEFAULT NULL,
  `medium` varchar(150) DEFAULT NULL,
  `dimensions` varchar(150) DEFAULT NULL,
  `location` varchar(150) DEFAULT NULL,
  `designed_by` varchar(150) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

--
-- Dumping data for table `artworks`
--

INSERT INTO `artworks` (`artwork_id`, `name`, `year`, `medium`, `dimensions`, `location`, `designed_by`) VALUES
(1, 'Mona Lisa', 1503, 'Oil on poplar', '77 cm × 53 cm', 'Louvre Museum', 'Leonardo da Vinci');

-- --------------------------------------------------------

--
-- Table structure for table `categories`
--

CREATE TABLE `categories` (
  `category_id` int NOT NULL,
  `category_type` varchar(50) NOT NULL,
  `category_name` varchar(100) NOT NULL,
  `description` text
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

--
-- Dumping data for table `categories`
--

INSERT INTO `categories` (`category_id`, `category_type`, `category_name`, `description`) VALUES
(1, 'Arts', 'Biography', 'Artist biographies'),
(2, 'Arts', 'Painting', 'Paintings');

-- --------------------------------------------------------

--
-- Table structure for table `events`
--

CREATE TABLE `events` (
  `event_id` int NOT NULL,
  `name` varchar(150) DEFAULT NULL,
  `event_type` varchar(100) DEFAULT NULL,
  `year` smallint DEFAULT NULL,
  `description` text,
  `location` varchar(150) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

-- --------------------------------------------------------

--
-- Table structure for table `people`
--

CREATE TABLE `people` (
  `person_id` int NOT NULL,
  `name` varchar(150) DEFAULT NULL,
  `born` smallint DEFAULT NULL,
  `died` smallint DEFAULT NULL,
  `nationality` varchar(100) DEFAULT NULL,
  `known_for` varchar(255) DEFAULT NULL,
  `notable_work` varchar(255) DEFAULT NULL,
  `about` text
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

--
-- Dumping data for table `people`
--

INSERT INTO `people` (`person_id`, `name`, `born`, `died`, `nationality`, `known_for`, `notable_work`, `about`) VALUES
(1, 'Claude Monet', 1840, 1926, 'French', 'Painter', 'Water Lilies', 'Founder of French Impressionism.'),
(2, 'Leonardo da Vinci', 1452, 1519, 'Italian', 'Art and Science', 'Mona Lisa; The Last Supper', 'Italian polymath.');

-- --------------------------------------------------------

--
-- Table structure for table `roles`
--

CREATE TABLE `roles` (
  `role_id` int NOT NULL,
  `role_name` varchar(50) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

--
-- Dumping data for table `roles`
--

INSERT INTO `roles` (`role_id`, `role_name`) VALUES
(3, 'Administrator'),
(1, 'Student'),
(2, 'Tutor');

-- --------------------------------------------------------

--
-- Table structure for table `subjects`
--

CREATE TABLE `subjects` (
  `subject_id` int NOT NULL,
  `subject_name` varchar(100) NOT NULL,
  `description` text
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

--
-- Dumping data for table `subjects`
--

INSERT INTO `subjects` (`subject_id`, `subject_name`, `description`) VALUES
(1, 'Arts', 'Arts reference'),
(2, 'Mathematics', 'Mathematics reference'),
(3, 'Technology', 'Technology reference');

-- --------------------------------------------------------

--
-- Table structure for table `users`
--

CREATE TABLE `users` (
  `user_id` int NOT NULL,
  `full_name` varchar(100) NOT NULL,
  `email` varchar(100) NOT NULL,
  `password_hash` varchar(255) NOT NULL,
  `role_id` int NOT NULL,
  `status` enum('Active','Inactive') DEFAULT 'Active',
  `created_at` timestamp NULL DEFAULT CURRENT_TIMESTAMP
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

--
-- Dumping data for table `users`
--

INSERT INTO `users` (`user_id`, `full_name`, `email`, `password_hash`, `role_id`, `status`, `created_at`) VALUES
(1, 'Admin User', 'admin@example.com', '$2y$10$92IXUNpkjO0rOQ5byMi.Ye4oKoEa3Ro9llC/.og/at2.uheWG/igi', 3, 'Active', '2026-06-29 06:05:56'),
(2, 'Tutor User', 'tutor@example.com', '$2y$10$92IXUNpkjO0rOQ5byMi.Ye4oKoEa3Ro9llC/.og/at2.uheWG/igi', 2, 'Active', '2026-06-29 06:05:56'),
(3, 'Student User', 'student@example.com', '$2y$10$92IXUNpkjO0rOQ5byMi.Ye4oKoEa3Ro9llC/.og/at2.uheWG/igi', 1, 'Active', '2026-06-29 06:05:56');

--
-- Indexes for dumped tables
--

--
-- Indexes for table `articles`
--
ALTER TABLE `articles`
  ADD PRIMARY KEY (`article_id`),
  ADD KEY `subject_id` (`subject_id`),
  ADD KEY `category_id` (`category_id`),
  ADD KEY `created_by` (`created_by`);

--
-- Indexes for table `article_artworks`
--
ALTER TABLE `article_artworks`
  ADD PRIMARY KEY (`article_id`,`artwork_id`),
  ADD KEY `artwork_id` (`artwork_id`);

--
-- Indexes for table `article_events`
--
ALTER TABLE `article_events`
  ADD PRIMARY KEY (`article_id`,`event_id`),
  ADD KEY `event_id` (`event_id`);

--
-- Indexes for table `article_people`
--
ALTER TABLE `article_people`
  ADD PRIMARY KEY (`article_id`,`person_id`),
  ADD KEY `person_id` (`person_id`);

--
-- Indexes for table `artworks`
--
ALTER TABLE `artworks`
  ADD PRIMARY KEY (`artwork_id`);

--
-- Indexes for table `categories`
--
ALTER TABLE `categories`
  ADD PRIMARY KEY (`category_id`);

--
-- Indexes for table `events`
--
ALTER TABLE `events`
  ADD PRIMARY KEY (`event_id`);

--
-- Indexes for table `people`
--
ALTER TABLE `people`
  ADD PRIMARY KEY (`person_id`);

--
-- Indexes for table `roles`
--
ALTER TABLE `roles`
  ADD PRIMARY KEY (`role_id`),
  ADD UNIQUE KEY `role_name` (`role_name`);

--
-- Indexes for table `subjects`
--
ALTER TABLE `subjects`
  ADD PRIMARY KEY (`subject_id`),
  ADD UNIQUE KEY `subject_name` (`subject_name`);

--
-- Indexes for table `users`
--
ALTER TABLE `users`
  ADD PRIMARY KEY (`user_id`),
  ADD UNIQUE KEY `email` (`email`),
  ADD KEY `role_id` (`role_id`);

--
-- AUTO_INCREMENT for dumped tables
--

--
-- AUTO_INCREMENT for table `articles`
--
ALTER TABLE `articles`
  MODIFY `article_id` int NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=10;

--
-- AUTO_INCREMENT for table `artworks`
--
ALTER TABLE `artworks`
  MODIFY `artwork_id` int NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=2;

--
-- AUTO_INCREMENT for table `categories`
--
ALTER TABLE `categories`
  MODIFY `category_id` int NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=3;

--
-- AUTO_INCREMENT for table `events`
--
ALTER TABLE `events`
  MODIFY `event_id` int NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `people`
--
ALTER TABLE `people`
  MODIFY `person_id` int NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=3;

--
-- AUTO_INCREMENT for table `roles`
--
ALTER TABLE `roles`
  MODIFY `role_id` int NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=4;

--
-- AUTO_INCREMENT for table `subjects`
--
ALTER TABLE `subjects`
  MODIFY `subject_id` int NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=4;

--
-- AUTO_INCREMENT for table `users`
--
ALTER TABLE `users`
  MODIFY `user_id` int NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=4;

--
-- Constraints for dumped tables
--

--
-- Constraints for table `articles`
--
ALTER TABLE `articles`
  ADD CONSTRAINT `articles_ibfk_1` FOREIGN KEY (`subject_id`) REFERENCES `subjects` (`subject_id`),
  ADD CONSTRAINT `articles_ibfk_2` FOREIGN KEY (`category_id`) REFERENCES `categories` (`category_id`),
  ADD CONSTRAINT `articles_ibfk_3` FOREIGN KEY (`created_by`) REFERENCES `users` (`user_id`);

--
-- Constraints for table `article_artworks`
--
ALTER TABLE `article_artworks`
  ADD CONSTRAINT `article_artworks_ibfk_1` FOREIGN KEY (`article_id`) REFERENCES `articles` (`article_id`) ON DELETE CASCADE,
  ADD CONSTRAINT `article_artworks_ibfk_2` FOREIGN KEY (`artwork_id`) REFERENCES `artworks` (`artwork_id`) ON DELETE CASCADE;

--
-- Constraints for table `article_events`
--
ALTER TABLE `article_events`
  ADD CONSTRAINT `article_events_ibfk_1` FOREIGN KEY (`article_id`) REFERENCES `articles` (`article_id`) ON DELETE CASCADE,
  ADD CONSTRAINT `article_events_ibfk_2` FOREIGN KEY (`event_id`) REFERENCES `events` (`event_id`) ON DELETE CASCADE;

--
-- Constraints for table `article_people`
--
ALTER TABLE `article_people`
  ADD CONSTRAINT `article_people_ibfk_1` FOREIGN KEY (`article_id`) REFERENCES `articles` (`article_id`) ON DELETE CASCADE,
  ADD CONSTRAINT `article_people_ibfk_2` FOREIGN KEY (`person_id`) REFERENCES `people` (`person_id`) ON DELETE CASCADE;

--
-- Constraints for table `users`
--
ALTER TABLE `users`
  ADD CONSTRAINT `users_ibfk_1` FOREIGN KEY (`role_id`) REFERENCES `roles` (`role_id`);
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
