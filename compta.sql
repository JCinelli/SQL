-- phpMyAdmin SQL Dump
-- version 5.0.2
-- https://www.phpmyadmin.net/
--
-- Hôte : 127.0.0.1
-- Généré le : lun. 20 juil. 2020 à 16:14
-- Version du serveur :  10.4.13-MariaDB
-- Version de PHP : 7.2.32

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Base de données : `compta`
--
CREATE DATABASE IF NOT EXISTS `compta` DEFAULT CHARACTER SET utf8 COLLATE utf8_general_ci;
USE `compta`;

-- --------------------------------------------------------

--
-- Structure de la table `articles`
--

DROP TABLE IF EXISTS `articles`;
CREATE TABLE IF NOT EXISTS `articles` (
  `id` int(10) NOT NULL,
  `ref` varchar(55) NOT NULL,
  `designation` varchar(255) NOT NULL,
  `prix` float(7,2) NOT NULL,
  `id_fou` int(10) NOT NULL,
  PRIMARY KEY (`id`),
  KEY `FK_art_fou` (`id_fou`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- --------------------------------------------------------

--
-- Structure de la table `bon`
--

DROP TABLE IF EXISTS `bon`;
CREATE TABLE IF NOT EXISTS `bon` (
  `id` int(10) NOT NULL,
  `numero` int(10) NOT NULL,
  `date_cmd` timestamp NOT NULL DEFAULT current_timestamp(),
  `delais` int(10) NOT NULL,
  `id_fou` int(10) NOT NULL,
  PRIMARY KEY (`id`),
  KEY `FK_bon_fou` (`id_fou`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- --------------------------------------------------------

--
-- Structure de la table `compo`
--

DROP TABLE IF EXISTS `compo`;
CREATE TABLE IF NOT EXISTS `compo` (
  `id` int(10) NOT NULL AUTO_INCREMENT,
  `quantite` int(10) NOT NULL,
  `id_art` int(10) NOT NULL,
  `id_bon` int(10) NOT NULL,
  PRIMARY KEY (`id`),
  KEY `FK_art_compo` (`id_art`),
  KEY `FK_bon_compo` (`id_bon`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- --------------------------------------------------------

--
-- Structure de la table `fournisseur`
--

DROP TABLE IF EXISTS `fournisseur`;
CREATE TABLE IF NOT EXISTS `fournisseur` (
  `id` int(10) NOT NULL,
  `nom` varchar(50) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Contraintes pour les tables déchargées
--

--
-- Contraintes pour la table `articles`
--
ALTER TABLE `articles`
  ADD CONSTRAINT `FK_art_fou` FOREIGN KEY (`id_fou`) REFERENCES `fournisseur` (`id`);

--
-- Contraintes pour la table `bon`
--
ALTER TABLE `bon`
  ADD CONSTRAINT `FK_bon_fou` FOREIGN KEY (`id_fou`) REFERENCES `fournisseur` (`id`);

--
-- Contraintes pour la table `compo`
--
ALTER TABLE `compo`
  ADD CONSTRAINT `FK_art_compo` FOREIGN KEY (`id_art`) REFERENCES `articles` (`id`),
  ADD CONSTRAINT `FK_bon_compo` FOREIGN KEY (`id_bon`) REFERENCES `bon` (`id`);
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
