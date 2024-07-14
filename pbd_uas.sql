-- phpMyAdmin SQL Dump
-- version 5.2.1
-- https://www.phpmyadmin.net/
--
-- Host: 127.0.0.1
-- Generation Time: Jul 14, 2024 at 06:04 PM
-- Server version: 10.4.32-MariaDB
-- PHP Version: 8.2.12

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Database: `pbd_uas`
--

DELIMITER $$
--
-- Procedures
--
CREATE DEFINER=`root`@`localhost` PROCEDURE `tampilProdukByParameter` (`nama` VARCHAR(50), `harga` INT)   BEGIN 
    SELECT nama_produk, harga, IF(harga >= 15000, 'Harga produk lebih dari 15000', 'Harga produk kurang dari 15000') AS Note
    FROM produk
    WHERE nama_produk LIKE CONCAT('%', nama, '%') AND harga = harga
    ORDER BY nama_produk ASC;

END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `tampilSemuaProduk` ()   BEGIN 
    SELECT nama_produk, harga, 
    IF(harga >= 15000, 'Harga produk lebih dari 15000', 'Harga produk kurang dari 15000') AS Note, 
    deskripsi
    FROM produk
    ORDER BY nama_produk ASC;
END$$

--
-- Functions
--
CREATE DEFINER=`root`@`localhost` FUNCTION `GetOrderTotalHarga` (`order_id` INT, `user_id` INT) RETURNS INT(11)  BEGIN
    DECLARE TotalHarga INT;

    SELECT SUM(o.quantity * p.harga) INTO TotalHarga
    FROM orders o
    JOIN produk p ON o.produk_id = p.produk_id
    WHERE o.order_id = order_id AND o.user_id = user_id;

    RETURN TotalHarga;
END$$

CREATE DEFINER=`root`@`localhost` FUNCTION `GetTotalOrders` () RETURNS INT(11)  BEGIN 
	DECLARE TotalOrders INT; 
	SELECT COUNT(*) INTO TotalOrders FROM orders; 
	RETURN TotalOrders; 
END$$

DELIMITER ;

-- --------------------------------------------------------

--
-- Table structure for table `admin`
--

CREATE TABLE `admin` (
  `adm_id` int(11) NOT NULL,
  `username` varchar(50) DEFAULT NULL,
  `password` varchar(222) DEFAULT NULL,
  `email` varchar(100) DEFAULT NULL,
  `date` timestamp NOT NULL DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `admin`
--

INSERT INTO `admin` (`adm_id`, `username`, `password`, `email`, `date`) VALUES
(1, 'admin1', 'pass', 'admin1@gmail.com', '2024-07-14 08:39:39'),
(2, 'dkadmn2', 'adminDK2024', 'admin2@gmail.com', '2024-07-14 08:39:39'),
(3, 'agnadmn3', 'adminAGNS2024', 'admin3@gmail.com', '2024-07-14 08:39:39'),
(4, 'admin4', 'pass', 'admin4@gmail.com', '2024-07-14 08:39:39'),
(5, 'admin5', 'pass', 'admin5@gmail.com', '2024-07-14 08:39:39');

-- --------------------------------------------------------

--
-- Table structure for table `changelog`
--

CREATE TABLE `changelog` (
  `change_id` int(11) NOT NULL,
  `activity` varchar(50) NOT NULL,
  `table_name` varchar(50) NOT NULL,
  `produk_id` int(11) NOT NULL,
  `date_created` date DEFAULT NULL,
  `by_who` varchar(10) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `changelog`
--

INSERT INTO `changelog` (`change_id`, `activity`, `table_name`, `produk_id`, `date_created`, `by_who`) VALUES
(1, 'INSERT', 'produk', 0, '2024-07-14', 'root@local'),
(2, 'INSERT', 'produk', 0, '2024-07-14', 'root@local'),
(3, 'INSERT', 'produk', 0, '2024-07-14', 'root@local'),
(4, 'DELETE', 'produk', 22, '2024-07-14', 'root@local'),
(5, 'UPDATE', 'produk', 21, '2024-07-14', 'root@local');

-- --------------------------------------------------------

--
-- Table structure for table `changelog_after`
--

CREATE TABLE `changelog_after` (
  `change_id` int(11) NOT NULL,
  `activity` varchar(50) NOT NULL,
  `table_name` varchar(50) NOT NULL,
  `user_id` int(11) NOT NULL,
  `date_created` date DEFAULT NULL,
  `by_who` varchar(10) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `changelog_after`
--

INSERT INTO `changelog_after` (`change_id`, `activity`, `table_name`, `user_id`, `date_created`, `by_who`) VALUES
(1, 'INSERT', 'users', 6, '2024-07-14', 'root@local'),
(2, 'INSERT', 'users', 7, '2024-07-14', 'root@local'),
(3, 'INSERT', 'users', 8, '2024-07-14', 'root@local'),
(4, 'DELETE', 'users', 7, '2024-07-14', 'root@local'),
(5, 'UPDATE', 'users', 8, '2024-07-14', 'root@local');

-- --------------------------------------------------------

--
-- Stand-in structure for view `horizontal_view`
-- (See below for the actual view)
--
CREATE TABLE `horizontal_view` (
`username` varchar(50)
,`email` varchar(100)
,`phone` varchar(20)
);

-- --------------------------------------------------------

--
-- Stand-in structure for view `inside_view_withcheckoption`
-- (See below for the actual view)
--
CREATE TABLE `inside_view_withcheckoption` (
`username` varchar(50)
,`email` varchar(100)
,`phone` varchar(20)
);

-- --------------------------------------------------------

--
-- Table structure for table `keranjang`
--

CREATE TABLE `keranjang` (
  `keranjang_id` int(11) NOT NULL,
  `produk_id` int(11) NOT NULL,
  `user_id` int(11) NOT NULL,
  `quantity` int(3) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `keranjang`
--

INSERT INTO `keranjang` (`keranjang_id`, `produk_id`, `user_id`, `quantity`) VALUES
(1, 4, 1, 2),
(2, 3, 1, 1),
(3, 5, 5, 1),
(4, 7, 5, 1),
(5, 1, 4, 1);

-- --------------------------------------------------------

--
-- Table structure for table `orders`
--

CREATE TABLE `orders` (
  `order_id` int(11) NOT NULL,
  `user_id` int(11) DEFAULT NULL,
  `quantity` int(11) DEFAULT NULL,
  `order_date` timestamp NOT NULL DEFAULT current_timestamp(),
  `status` enum('pending','diproses','dikirim','selesai') DEFAULT NULL,
  `catatan` text DEFAULT NULL,
  `metode_bayar` enum('COD','Transfer Bank') DEFAULT NULL,
  `total_harga` int(11) DEFAULT NULL,
  `produk_id` int(11) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `orders`
--

INSERT INTO `orders` (`order_id`, `user_id`, `quantity`, `order_date`, `status`, `catatan`, `metode_bayar`, `total_harga`, `produk_id`) VALUES
(1, 2, 2, '2024-07-14 05:00:00', 'pending', 'Order for Roti Pisang', 'COD', 26000, 1),
(2, 2, 1, '2024-07-13 05:05:00', 'selesai', 'Order for Pisang Coklat', 'Transfer Bank', 12000, 2),
(3, 3, 3, '2024-07-14 05:10:00', 'diproses', 'Order for Banana Cheese Pie', 'COD', 45000, 3),
(4, 3, 4, '2024-07-13 05:15:00', 'selesai', 'Order for Banana Chips', 'Transfer Bank', 40000, 4),
(5, 4, 2, '2024-07-14 05:20:00', 'dikirim', 'Order for Kolak Pisang', 'COD', 24000, 5);

-- --------------------------------------------------------

--
-- Table structure for table `pembeli`
--

CREATE TABLE `pembeli` (
  `pembeli_id` int(11) NOT NULL,
  `nama` varchar(50) DEFAULT NULL,
  `jenis_kelamin` enum('laki-laki','perempuan') DEFAULT NULL,
  `alamat` varchar(50) DEFAULT NULL,
  `tanggal_beli` date DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Table structure for table `produk`
--

CREATE TABLE `produk` (
  `produk_id` int(11) NOT NULL,
  `nama_produk` varchar(222) DEFAULT NULL,
  `deskripsi` text DEFAULT NULL,
  `harga` int(11) DEFAULT NULL,
  `img` varchar(255) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `produk`
--

INSERT INTO `produk` (`produk_id`, `nama_produk`, `deskripsi`, `harga`, `img`) VALUES
(1, 'Roti Pisang', 'Roti yang diisi dengan adonan pisang yang matang dalam lapisan roti lembut.', 13000, 'ropis.jpg'),
(2, 'Pisang Coklat', 'Pisang coklat adalah potongan pisang yang manis dengan lapisan coklat.', 12000, 'piscok.jpg'),
(3, 'Banana Cheese Pie', 'Banana cheese pie adalah kue pie yang menggabungkan pisang dan keju.', 15000, 'paipis.jpg'),
(4, 'Banana Chips', 'Camilan renyah dari potongan pisang yang digoreng kering.', 10000, 'kerpis.jpg'),
(5, 'Kolak Pisang', 'Hidangan tradisional yang terbuat dari potongan pisang yang dimasak dalam santan.', 12000, 'kolack.jpg'),
(6, 'Pisang Cokju', 'Banana cheese pie adalah kue pie yang menggabungkan pisang dan keju.', 23000, 'chesban.jpg'),
(7, 'Nugget Piscok', 'Nugget Pisang dengan isian coklat lumer yang di siapkan dengan tepung renyah.', 20000, 'nucok.jpg'),
(8, 'Pisang Goreng', 'Pisang goreng terbuat dari pisang matang yang digoreng dengan tepung renyah.', 11000, 'pisgor.jpg'),
(9, 'Pisang Sulawesi', 'Pisang yang manis dilengkapi dengan sambal cocol dari Sulawesi.', 15000, 'piskemul.jpg'),
(10, 'MilkBan', 'Susu Pisang dengan rasa susu dari Boyolali yang menyegarkan.', 10000, 'supis.jpg'),
(20, 'Pisang cocol', 'Pisang yang manis dilengkapi dengan saus cocol dengan rasa coklat khas itali', 25000, NULL),
(21, 'Pisang Kemul', 'Pisang dibaluri dengan kremes tepung sehingga terasa renyah serta diberi topping yang melimpah no pelit pelit', 10000, NULL);

--
-- Triggers `produk`
--
DELIMITER $$
CREATE TRIGGER `before_delete_trigger` BEFORE DELETE ON `produk` FOR EACH ROW BEGIN
    INSERT INTO changelog (activity, table_name,produk_id, date_created, by_who)
    VALUES ('DELETE', 'produk',OLD.produk_id, NOW(), SESSION_USER());
END
$$
DELIMITER ;
DELIMITER $$
CREATE TRIGGER `before_insert_trigger` BEFORE INSERT ON `produk` FOR EACH ROW BEGIN
    INSERT INTO changelog (activity, table_name,produk_id, date_created, by_who)
    VALUES ('INSERT', 'produk',NEW.produk_id, NOW(), SESSION_USER());
END
$$
DELIMITER ;
DELIMITER $$
CREATE TRIGGER `before_update_trigger` BEFORE UPDATE ON `produk` FOR EACH ROW BEGIN
    INSERT INTO changelog (activity, table_name,produk_id, date_created, by_who)
    VALUES ('UPDATE', 'produk',OLD.produk_id, NOW(), SESSION_USER());
END
$$
DELIMITER ;

-- --------------------------------------------------------

--
-- Table structure for table `review`
--

CREATE TABLE `review` (
  `review_id` int(5) NOT NULL,
  `isi` text DEFAULT NULL,
  `user_id` int(11) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Table structure for table `users`
--

CREATE TABLE `users` (
  `user_id` int(11) NOT NULL,
  `username` varchar(50) DEFAULT NULL,
  `f_name` varchar(100) DEFAULT NULL,
  `l_name` varchar(100) DEFAULT NULL,
  `email` varchar(100) DEFAULT NULL,
  `phone` varchar(20) DEFAULT NULL,
  `password` varchar(222) DEFAULT NULL,
  `alamat` text DEFAULT NULL,
  `date` timestamp NOT NULL DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `users`
--

INSERT INTO `users` (`user_id`, `username`, `f_name`, `l_name`, `email`, `phone`, `password`, `alamat`, `date`) VALUES
(1, 'mariaagnes', 'Agnes', 'Maria', 'agnessal123@gmail.com', '081234567890', 'agnes123', 'Maguwoharo, Sleman, DI Yogyakarta', '2024-06-27 16:34:42'),
(2, 'dekaaja', 'Lutfiana', 'Deka', 'lutfian@gmail.com', '087883678670', 'sarokak17', 'Omah e dewe, Gunungkidul', '2024-07-01 17:15:45'),
(3, 'pipiyah', 'Luthfiyyah', 'Nur', 'nur@gmail.com', '0987654567', 'pipip1234', 'Kotagede', '2024-07-03 06:29:50'),
(4, 'esteaa', 'Esti', 'Dwi Puspita', 'Estii11@gmail.com', '082356742398', 'esti1234', 'Piyungan, Bantul', '2024-07-01 17:16:42'),
(5, 'elsaa', 'Elsa', 'Dinanti', 'elsa12@gmail.com', '081234567812', 'elsa1234', 'Ngawi', '2024-06-30 04:42:19'),
(6, 'Andrew', 'Andrea', 'Mahesa', 'and@gmail.com', '98787878787', NULL, 'Kebun raya gembira loka', '2024-07-14 15:44:22'),
(8, 'Elsabri', 'Elsabrina', 'Putri', 'el@gmail.com', '87555555555', NULL, 'Condongcatur', '2024-07-14 15:44:22');

--
-- Triggers `users`
--
DELIMITER $$
CREATE TRIGGER `after_delete_trigger` AFTER DELETE ON `users` FOR EACH ROW BEGIN
    INSERT INTO changelog_after (activity, table_name,user_id, date_created, by_who)
    VALUES ('DELETE', 'users',OLD.user_id, NOW(), SESSION_USER());
END
$$
DELIMITER ;
DELIMITER $$
CREATE TRIGGER `after_insert_trigger` AFTER INSERT ON `users` FOR EACH ROW BEGIN
    INSERT INTO changelog_after (activity, table_name,user_id, date_created, by_who)
    VALUES ('INSERT', 'users',NEW.user_id, NOW(), SESSION_USER());
END
$$
DELIMITER ;
DELIMITER $$
CREATE TRIGGER `after_update_trigger` AFTER UPDATE ON `users` FOR EACH ROW BEGIN
    INSERT INTO changelog_after (activity, table_name,user_id, date_created, by_who)
    VALUES ('UPDATE', 'users',NEW.user_id, NOW(), SESSION_USER());
END
$$
DELIMITER ;

-- --------------------------------------------------------

--
-- Stand-in structure for view `vertikal_view`
-- (See below for the actual view)
--
CREATE TABLE `vertikal_view` (
`user_id` int(11)
,`username` varchar(50)
,`email` varchar(100)
,`phone` varchar(20)
,`alamat` text
);

-- --------------------------------------------------------

--
-- Structure for view `horizontal_view`
--
DROP TABLE IF EXISTS `horizontal_view`;

CREATE ALGORITHM=UNDEFINED DEFINER=`root`@`localhost` SQL SECURITY DEFINER VIEW `horizontal_view`  AS SELECT `users`.`username` AS `username`, `users`.`email` AS `email`, `users`.`phone` AS `phone` FROM `users` ;

-- --------------------------------------------------------

--
-- Structure for view `inside_view_withcheckoption`
--
DROP TABLE IF EXISTS `inside_view_withcheckoption`;

CREATE ALGORITHM=UNDEFINED DEFINER=`root`@`localhost` SQL SECURITY DEFINER VIEW `inside_view_withcheckoption`  AS SELECT `horizontal_view`.`username` AS `username`, `horizontal_view`.`email` AS `email`, `horizontal_view`.`phone` AS `phone` FROM `horizontal_view` WHERE `horizontal_view`.`username` like 'd%'WITH CASCADED CHECK OPTION  ;

-- --------------------------------------------------------

--
-- Structure for view `vertikal_view`
--
DROP TABLE IF EXISTS `vertikal_view`;

CREATE ALGORITHM=UNDEFINED DEFINER=`root`@`localhost` SQL SECURITY DEFINER VIEW `vertikal_view`  AS SELECT `users`.`user_id` AS `user_id`, `users`.`username` AS `username`, `users`.`email` AS `email`, `users`.`phone` AS `phone`, `users`.`alamat` AS `alamat` FROM `users` LIMIT 0, 3 ;

--
-- Indexes for dumped tables
--

--
-- Indexes for table `admin`
--
ALTER TABLE `admin`
  ADD PRIMARY KEY (`adm_id`);

--
-- Indexes for table `changelog`
--
ALTER TABLE `changelog`
  ADD PRIMARY KEY (`change_id`);

--
-- Indexes for table `changelog_after`
--
ALTER TABLE `changelog_after`
  ADD PRIMARY KEY (`change_id`);

--
-- Indexes for table `keranjang`
--
ALTER TABLE `keranjang`
  ADD PRIMARY KEY (`keranjang_id`),
  ADD KEY `produk_id` (`produk_id`),
  ADD KEY `user_id` (`user_id`);

--
-- Indexes for table `orders`
--
ALTER TABLE `orders`
  ADD PRIMARY KEY (`order_id`),
  ADD KEY `user_id` (`user_id`),
  ADD KEY `fk_produk` (`produk_id`);

--
-- Indexes for table `pembeli`
--
ALTER TABLE `pembeli`
  ADD PRIMARY KEY (`pembeli_id`),
  ADD KEY `idxNamaAlamat` (`nama`,`alamat`),
  ADD KEY `idxAlamatGender` (`alamat`,`jenis_kelamin`),
  ADD KEY `idxNamaTanggalbeli` (`nama`,`tanggal_beli`);

--
-- Indexes for table `produk`
--
ALTER TABLE `produk`
  ADD PRIMARY KEY (`produk_id`);

--
-- Indexes for table `review`
--
ALTER TABLE `review`
  ADD PRIMARY KEY (`review_id`),
  ADD KEY `user_id` (`user_id`);

--
-- Indexes for table `users`
--
ALTER TABLE `users`
  ADD PRIMARY KEY (`user_id`);

--
-- AUTO_INCREMENT for dumped tables
--

--
-- AUTO_INCREMENT for table `admin`
--
ALTER TABLE `admin`
  MODIFY `adm_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=6;

--
-- AUTO_INCREMENT for table `changelog`
--
ALTER TABLE `changelog`
  MODIFY `change_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=6;

--
-- AUTO_INCREMENT for table `changelog_after`
--
ALTER TABLE `changelog_after`
  MODIFY `change_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=6;

--
-- AUTO_INCREMENT for table `keranjang`
--
ALTER TABLE `keranjang`
  MODIFY `keranjang_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=6;

--
-- AUTO_INCREMENT for table `orders`
--
ALTER TABLE `orders`
  MODIFY `order_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=6;

--
-- AUTO_INCREMENT for table `pembeli`
--
ALTER TABLE `pembeli`
  MODIFY `pembeli_id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `produk`
--
ALTER TABLE `produk`
  MODIFY `produk_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=23;

--
-- AUTO_INCREMENT for table `review`
--
ALTER TABLE `review`
  MODIFY `review_id` int(5) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `users`
--
ALTER TABLE `users`
  MODIFY `user_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=9;

--
-- Constraints for dumped tables
--

--
-- Constraints for table `keranjang`
--
ALTER TABLE `keranjang`
  ADD CONSTRAINT `keranjang_ibfk_1` FOREIGN KEY (`produk_id`) REFERENCES `produk` (`produk_id`) ON DELETE CASCADE,
  ADD CONSTRAINT `keranjang_ibfk_2` FOREIGN KEY (`user_id`) REFERENCES `users` (`user_id`) ON DELETE CASCADE;

--
-- Constraints for table `orders`
--
ALTER TABLE `orders`
  ADD CONSTRAINT `fk_produk` FOREIGN KEY (`produk_id`) REFERENCES `produk` (`produk_id`),
  ADD CONSTRAINT `orders_ibfk_1` FOREIGN KEY (`user_id`) REFERENCES `users` (`user_id`) ON DELETE CASCADE;

--
-- Constraints for table `review`
--
ALTER TABLE `review`
  ADD CONSTRAINT `review_ibfk_1` FOREIGN KEY (`user_id`) REFERENCES `users` (`user_id`) ON DELETE CASCADE;
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
