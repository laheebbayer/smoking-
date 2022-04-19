-- phpMyAdmin SQL Dump
-- version 5.1.1
-- https://www.phpmyadmin.net/
--
-- Host: 127.0.0.1
-- Generation Time: Apr 19, 2022 at 10:01 PM
-- Server version: 10.4.22-MariaDB
-- PHP Version: 7.4.27

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Database: `nocotine_test`
--

-- --------------------------------------------------------

--
-- Table structure for table `comments`
--

CREATE TABLE `comments` (
  `comment_id` int(11) NOT NULL,
  `post_id` int(11) NOT NULL,
  `user_id` int(11) NOT NULL,
  `comment_text` longtext NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Dumping data for table `comments`
--

INSERT INTO `comments` (`comment_id`, `post_id`, `user_id`, `comment_text`) VALUES
(70, 64, 42, 'lassdksjd;a;kds'),
(71, 65, 48, 'hhhhhhhhhh'),
(72, 70, 55, 'fffff'),
(73, 75, 55, 'fffffff'),
(74, 75, 55, 'dddddd'),
(75, 75, 55, 'rrrrrrr'),
(76, 75, 55, 'rrrdddd'),
(77, 75, 55, 'ssssssss'),
(78, 75, 55, 'fffffff'),
(79, 75, 55, 'dddddddddddddddddddddd'),
(80, 75, 55, 'The default value of the maxLengthEnforcement parameter is inferred from the TargetPlatform of the application, to conform to the platform’s conventions:'),
(81, 74, 55, 'hello'),
(82, 94, 55, 'test'),
(83, 99, 55, 'test'),
(84, 99, 47, 'test2'),
(85, 100, 55, 'test'),
(86, 100, 55, 'test2'),
(87, 100, 55, 'test2'),
(88, 100, 55, 'ttttttttt'),
(89, 99, 55, 'test3'),
(90, 100, 55, 'test4'),
(91, 97, 47, 'test4'),
(92, 100, 55, 'test'),
(93, 100, 47, 'ok'),
(94, 99, 47, 'tttt'),
(95, 99, 58, 'test5');

-- --------------------------------------------------------

--
-- Table structure for table `feedback`
--

CREATE TABLE `feedback` (
  `feedback_id` int(11) NOT NULL,
  `user_id` int(11) NOT NULL,
  `rate` double NOT NULL,
  `feedback_comment` text NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Dumping data for table `feedback`
--

INSERT INTO `feedback` (`feedback_id`, `user_id`, `rate`, `feedback_comment`) VALUES
(1, 42, 2.5, 'test'),
(2, 42, 5, 'test2'),
(3, 42, 0, ''),
(4, 48, 5, 'test3'),
(5, 55, 2.5, 'gfdg');

-- --------------------------------------------------------

--
-- Table structure for table `likes`
--

CREATE TABLE `likes` (
  `post_id` int(11) NOT NULL,
  `user_id` int(11) NOT NULL,
  `visable_like` varchar(20) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Dumping data for table `likes`
--

INSERT INTO `likes` (`post_id`, `user_id`, `visable_like`) VALUES
(64, 42, 'true'),
(63, 42, 'true'),
(63, 47, 'true'),
(64, 48, 'true'),
(65, 48, 'true'),
(68, 55, 'true'),
(70, 55, 'true'),
(73, 55, 'true'),
(75, 55, 'true'),
(75, 42, 'true'),
(74, 42, 'true'),
(74, 55, 'true'),
(95, 55, 'true'),
(94, 55, 'true'),
(99, 55, 'true'),
(97, 47, 'true'),
(99, 47, 'true'),
(100, 55, 'true'),
(99, 58, 'true'),
(103, 58, 'true');

-- --------------------------------------------------------

--
-- Table structure for table `notification`
--

CREATE TABLE `notification` (
  `notification_id` int(11) NOT NULL,
  `user_id_sender` int(11) NOT NULL,
  `user_id_reciever` int(11) NOT NULL,
  `post_id` int(11) NOT NULL,
  `body` text NOT NULL,
  `icon` text NOT NULL,
  `date` text NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Dumping data for table `notification`
--

INSERT INTO `notification` (`notification_id`, `user_id_sender`, `user_id_reciever`, `post_id`, `body`, `icon`, `date`) VALUES
(12, 55, 47, 100, 'Commented on Your Post', 'mode_comment', '13/4/2022'),
(36, 55, 47, 100, 'Commented on Your Post', 'mode_comment', '16/4/2022'),
(41, 47, 55, 97, 'Liked Your Post', 'favorite', '17/4/2022'),
(42, 47, 55, 97, 'Commented on Your Post', 'mode_comment', '17/4/2022'),
(44, 55, 47, 100, 'Commented on Your Post', 'mode_comment', '17/4/2022'),
(48, 47, 55, 99, 'Commented on Your Post', 'mode_comment', '17/4/2022'),
(180, 47, 55, 99, 'Liked Your Post', 'favorite', '18/4/2022'),
(182, 55, 47, 100, 'Liked Your Post', 'favorite', '18/4/2022'),
(183, 58, 55, 99, 'Liked Your Post', 'favorite', '18/4/2022'),
(184, 58, 55, 99, 'Commented on Your Post', 'mode_comment', '18/4/2022'),
(185, 58, 55, 103, 'Liked Your Post', 'favorite', '18/4/2022');

-- --------------------------------------------------------

--
-- Table structure for table `posts`
--

CREATE TABLE `posts` (
  `post_id` int(11) NOT NULL,
  `user_id` int(11) NOT NULL,
  `post_text` longtext NOT NULL,
  `feeling` varchar(30) NOT NULL,
  `image_post` longtext NOT NULL,
  `total_comments` varchar(50) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Dumping data for table `posts`
--

INSERT INTO `posts` (`post_id`, `user_id`, `post_text`, `feeling`, `image_post`, `total_comments`) VALUES
(63, 42, 'hello', 'Happy 😄', '', '0'),
(64, 42, 'dasddasd', 'Happy 😄', '', '1'),
(66, 55, 'hellooo', 'Happy 😄', '', '0'),
(67, 55, 'adfdsdsdsdsdsdsdsdsdsdsdsdsdsdsdsddsdsdsdsdsdsdsdsdsdsdsdsdsdsdsdsdsdsdsdsdsdsdsdsdsdsdsdsdsdsdsdsdsdsdsdsdsdsdsdsdsdsdsdsdsdsdsdsdsdsdsdsdsdsdsdsdsdsdsdsdsdsdsdsdsdsdsdsdsdsdsdsdsdsdsdsdsdsdsdsdsdsdsdsdsdsdsdsdsdsdsdsdsdsdsdsdsdsdsdsdsdsdsdsdsdsdsds', '', '', '0'),
(68, 55, 'hello', '', '', '0'),
(69, 55, 'hello2', 'Happy 😄', '', '0'),
(70, 55, 'The default value of the maxLengthEnforcement parameter is inferred from the TargetPlatform of the application, to conform to the platform’s conventions:', '', '', '0'),
(71, 43, 'hhhhhhhhhhhhh', '', '', '0'),
(72, 43, 'ffffffffffffffff', '', '', '0'),
(73, 43, 'ttttttttttttttttttttttttttttttttttt', '', '', '0'),
(74, 43, 'jjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjj', '', '', '1'),
(75, 43, 'kkkkkkkkkkkkkkkkkkkkkkkkkkkkkk', '', '', '7'),
(76, 55, 'gsdfgds', '', '', '0'),
(77, 55, 'hello', '', '', '0'),
(78, 55, 'helllllllllllllllllllll', '', '', '0'),
(79, 55, 'ttttttttttttt', '', '', '0'),
(80, 55, 'ggg', '', '', '0'),
(81, 55, 'tttttttttttttt', '', '', '0'),
(82, 55, 'fffffffffffffff', '', 'image_picker6753801828602370126.jpg', '0'),
(83, 55, 'ffffffff', '', 'image_picker4597478484457152964.png', '0'),
(84, 55, 'hhhhh', 'Happy 😄', 'image_picker8231222334268591210.png', '0'),
(85, 55, 'fffffffffffffffff', '', '', '0'),
(86, 55, 'gggggggggggggggg', 'Tired 😪', '', '0'),
(87, 55, 'helloo', 'Happy 😄', '', '0'),
(88, 55, 'trrrrrrrrrrrrrr', '', 'image_picker2340563756134049624.png', '0'),
(89, 55, 'gggggggggggggggggggggggg', '', 'image_picker1111001790837033109.png', '0'),
(90, 55, 'test', 'Happy 😄', '', '0'),
(91, 55, 'ttttt', 'Tired 😪', '', '0'),
(92, 55, 'ggggg', '', '', '0'),
(94, 55, 'ggggggggggggg', '', 'image_picker5196278279560993725.png', '0'),
(97, 55, 'hello', '', '', '0'),
(99, 55, 'hello', '', '78fe7a1a-3f51-40a7-a95b-b15392ff50054056261085944170851.jpg', '4'),
(100, 47, 'test', 'Happy 😄', '', '7'),
(101, 58, 'hello', 'Happy 😄', '058f1d9b-f37a-4e31-a311-7659b9be2c475481332773793573437.jpg', '0'),
(102, 58, 'test2', '', '47502897-0a42-48b5-ab27-0de82badfc234108638158738579361.jpg', '0'),
(103, 55, 'test', '', '4a8dafda-353a-474e-b94b-4d45771863de3773983003397197391.jpg', '0'),
(104, 55, 'testttttttttttttt', '', '', '0'),
(105, 55, 'dsfdsfsdf', '', 'b9bfe10e-dc84-46a1-92a7-34d0e43a64148906713214620542641.jpg', '0'),
(106, 55, 'sfdfd', '', '041c70c2-45d6-4181-8862-e2e6131d90d99033721624075475914.jpg', '0'),
(107, 55, 'test', '', 'cc861840-4e18-4fb9-b7ad-597afd2a82799198008196122833183.jpg', '0'),
(108, 55, 'testtttt', '', 'ca316762-eea1-45a3-9358-fd65b49683e52517184067075719102.jpg', '0'),
(109, 55, 'test5555', '', '2345ac20-54e6-48f3-831c-6a1dded75a812350396081769715827.jpg', '0'),
(110, 47, 'rrrrrrrrrrrrrrr', '', '4e316943-6127-49d5-aeef-c6ee4b2838b76380666998568277203.jpg', '0'),
(111, 55, 'ffffffffffff', '', '5cf7b9b1-2c6b-4060-ad1a-8fead25cffcd3377394129803579053.jpg', '0'),
(112, 58, 'ttttttttttttt', '', '9d7b8576-0f81-47b8-b9de-d6d076569bd94581180434180106504.jpg', '0'),
(113, 47, 'yyyyyyyyyyyyyyyyy', '', 'df0695e5-bcec-4dae-948e-a4d33f19b9957402725521245309690.jpg', '0'),
(114, 58, 'rwefwefweew', '', 'cde1f298-a010-4015-b5bd-d066f9b1a8134647547113730163706.jpg', '0'),
(115, 47, 'test111', '', '2b390dd3-e65a-4c9d-b5c0-bada0664eae8306257109102495682.jpg', '0'),
(117, 47, 'testtttttt', '', '60a61cb6-5719-4918-b9d1-17c1950e85cb1253113158770252928.jpg', '0'),
(118, 55, 'testttttttttttttttttttt', '', 'a3f8c131-4600-46de-a28c-233df120c0977083167516740045147.jpg', '0'),
(119, 55, 'tttt', '', '28a5e21b-2c3a-4ac1-9af8-1418a85a137c5678839182087786492.jpg', '0'),
(121, 55, 'ttttttttttttttttttttttttttttttt', '', '385fc653-2fcb-4683-9f6d-e4c0052b05f76652308122789077381.jpg', '0'),
(123, 55, 'gggggggggggggggg', '', '281954dc-0775-43dd-8297-263ceb9cd1d44227950650024452444.jpg', '0');

-- --------------------------------------------------------

--
-- Table structure for table `smoking_counter`
--

CREATE TABLE `smoking_counter` (
  `counter_id` int(11) NOT NULL,
  `user_id` int(11) NOT NULL,
  `number_of_cigarette` int(11) NOT NULL,
  `cost_of_cigarette` double NOT NULL,
  `save_health` double NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Dumping data for table `smoking_counter`
--

INSERT INTO `smoking_counter` (`counter_id`, `user_id`, `number_of_cigarette`, `cost_of_cigarette`, `save_health`) VALUES
(6, 42, 13, 0.9, -1.3),
(7, 43, 10, 1.06, -1),
(8, 44, 0, 0, 0),
(9, 47, 6, 0.18, -0.6),
(10, 48, 8, 1.2, -0.8),
(11, 49, 0, 0, 0),
(12, 50, 0, 0, 0),
(13, 51, 4, 0.6, -0.4),
(14, 53, 0, 0, 0),
(15, 55, 2, 0.14, -0.2),
(16, 56, 0, 0, 0),
(17, 58, 0, 0, 0);

-- --------------------------------------------------------

--
-- Table structure for table `users`
--

CREATE TABLE `users` (
  `id` int(11) NOT NULL,
  `first_name` varchar(50) NOT NULL,
  `last_name` varchar(50) NOT NULL,
  `email` varchar(150) NOT NULL,
  `password` text NOT NULL,
  `gender` varchar(20) NOT NULL,
  `Age` varchar(50) NOT NULL,
  `bio` text NOT NULL,
  `image` longtext NOT NULL,
  `Token` longtext NOT NULL,
  `count_notification` int(11) NOT NULL,
  `visable_sheet` int(11) NOT NULL,
  `number_of_packets` double NOT NULL,
  `price_of_packets` double NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Dumping data for table `users`
--

INSERT INTO `users` (`id`, `first_name`, `last_name`, `email`, `password`, `gender`, `Age`, `bio`, `image`, `Token`, `count_notification`, `visable_sheet`, `number_of_packets`, `price_of_packets`) VALUES
(42, 'faris2', 'aljohari2', 'faris@gmail.com', '81dc9bdb52d04dc20036dbd8313ed055', 'Male', '4', 'I\'m dasdasd\'saad', 'user.png', '', 0, 2, 2, 2),
(43, 'mohammad', 'ahmad', 'mohammad@gmail.com', '202cb962ac59075b964b07152d234b70', 'Male', '18', 'I\'m not really sure what you\'re after when it comes to the height of th', 'user.png', '', 0, 2, 2, 2.5),
(44, 'ahmad', 'ahmad', 'ahmad@gmail.com', '202cb962ac59075b964b07152d234b70', 'Male', '30', '', 'user.png', '', 0, 2, 1.5, 1.5),
(45, 'ahmad', 'ahmad', 'ahmad1@gmail.com', '202cb962ac59075b964b07152d234b70', 'Male', '22', '', 'user.png', '', 0, 1, 0, 0),
(46, 'ahmad', 'ahmad', 'ahmad2@gmail.com', '202cb962ac59075b964b07152d234b70', 'Male', '7', '', 'user.png', '', 0, 1, 0, 0),
(47, 'dana', 'turki', 'dana@gmail.com', '202cb962ac59075b964b07152d234b70', 'Female', '6', '', 'user.png', 'doQ29SKjRbSJ2FnSF_m-z2:APA91bF0LKHasxoCCedirnoyhAKUon6cZmliWVWQ9i7r4pfJqVT5hUhF_Pq5pnRrxvDS-xMO5fPRgrpOz_xpCNmvqtxSkzTMkXDsxzDLHGTGF0a_eQIWzhWNopg8PgvFQhMwsaNAac8w', 4, 2, 2, 0.6),
(51, 'aaaa', 'cccc', 'c@gmail.com', '202cb962ac59075b964b07152d234b70', 'Female', '2', '', 'user.png', '', 0, 2, 2, 3),
(54, 'faris', 'Ali', 'Faris2@gmail.com', '86f4d272cdb6241be9ff1233f541b248', 'Male', '1', '', 'user.png', '', 0, 1, 0, 0),
(55, 'Fariss', 'Mohammad', 'farisaljohari2@gmail.com', 'ff499ab84fc4f246e2de3a9049f4e160', 'Male', '22', 'Biooooooo', 'image_picker3878221442054410306.png', 'e4vNpDg7Tqe1tGvRU26Y1y:APA91bHxZtuJbCrly_zlFMUx5GPz7omHIrXHtS7fdbZIWO0McHXsOgJmi7iE9BD6n3ieCsL2yzYCfdDqUO0SE5ipsmaK19ucz4trSWkYzVlVOFD7fMG1nHnxzbEH3WOpOSFg9tuVsqXu', 0, 2, 2.5, 0.7),
(56, 'Ali', 'Ali', 'Ali2@gmail.com', '86f4d272cdb6241be9ff1233f541b248', 'Male', '3', '', 'user.png', '', 0, 2, 2.5, 0.6),
(57, 'Test', 'Test', 'test@gmail.com', 'ff499ab84fc4f246e2de3a9049f4e160', 'Male', '2', '', 'user.png', '', 0, 1, 0, 0),
(58, 'Laheeb', 'Alabbadi', 'Lahheb@gmail.com', '427aa97eefee3b579341e37486e1a7a0', 'Female', '10', '', 'user.png', 'c2Rtux4ATm6I6Mdg9pJviL:APA91bHY7TUtXCoPnKBt39XwE51zA28h0uP7XqRB5P-d1J8lgmpkgeOGp9DYvyrS0DdqeEadwdDoWIO8hGPrPbYfxEZExNQJy6OXxlBUvfawxaORwks--W-9zYsS1mUfW3KRHxYheT0c', 2, 2, 2, 2);

--
-- Indexes for dumped tables
--

--
-- Indexes for table `comments`
--
ALTER TABLE `comments`
  ADD PRIMARY KEY (`comment_id`);

--
-- Indexes for table `feedback`
--
ALTER TABLE `feedback`
  ADD PRIMARY KEY (`feedback_id`);

--
-- Indexes for table `notification`
--
ALTER TABLE `notification`
  ADD PRIMARY KEY (`notification_id`);

--
-- Indexes for table `posts`
--
ALTER TABLE `posts`
  ADD PRIMARY KEY (`post_id`);

--
-- Indexes for table `smoking_counter`
--
ALTER TABLE `smoking_counter`
  ADD PRIMARY KEY (`counter_id`);

--
-- Indexes for table `users`
--
ALTER TABLE `users`
  ADD PRIMARY KEY (`id`,`email`),
  ADD UNIQUE KEY `email` (`email`);

--
-- AUTO_INCREMENT for dumped tables
--

--
-- AUTO_INCREMENT for table `comments`
--
ALTER TABLE `comments`
  MODIFY `comment_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=96;

--
-- AUTO_INCREMENT for table `feedback`
--
ALTER TABLE `feedback`
  MODIFY `feedback_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=6;

--
-- AUTO_INCREMENT for table `notification`
--
ALTER TABLE `notification`
  MODIFY `notification_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=195;

--
-- AUTO_INCREMENT for table `posts`
--
ALTER TABLE `posts`
  MODIFY `post_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=124;

--
-- AUTO_INCREMENT for table `smoking_counter`
--
ALTER TABLE `smoking_counter`
  MODIFY `counter_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=18;

--
-- AUTO_INCREMENT for table `users`
--
ALTER TABLE `users`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=59;
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
