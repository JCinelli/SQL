-- phpMyAdmin SQL Dump
-- version 5.0.2
-- https://www.phpmyadmin.net/
--
-- Hôte : 127.0.0.1
-- Généré le : lun. 20 juil. 2020 à 16:50
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

--
-- Déchargement des données de la table `articles`
--

INSERT INTO `articles` (`id`, `ref`, `designation`, `prix`, `id_fou`) VALUES
(1, 'A01', 'Perceuse P1', 74.99, 1),
(2, 'F01', 'Boulon laiton 4 x 40 mm (sachet de 10)', 2.25, 2),
(3, 'F02', 'Boulon laiton 5 x 40 mm (sachet de 10)', 4.45, 2),
(4, 'D01', 'Boulon laiton 5 x 40 mm (sachet de 10)', 4.40, 3),
(5, 'A02', 'Meuleuse 125mm', 37.85, 1),
(6, 'D03', 'Boulon acier zingué 4 x 40mm (sachet de 10)', 1.80, 3),
(7, 'A03', 'Perceuse à colonne', 185.25, 1),
(8, 'D04', 'Coffret mêches à bois', 12.25, 3),
(9, 'F03', 'Coffret mêches plates', 6.25, 2),
(10, 'F04', 'Fraises d’encastrement', 8.14, 2);

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

--
-- Déchargement des données de la table `bon`
--

INSERT INTO `bon` (`id`, `numero`, `date_cmd`, `delais`, `id_fou`) VALUES
(1, 15236, '2020-07-20 14:46:00', 3, 1);

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
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=utf8;

--
-- Déchargement des données de la table `compo`
--

INSERT INTO `compo` (`id`, `quantite`, `id_art`, `id_bon`) VALUES
(1, 3, 1, 1),
(2, 4, 5, 1),
(3, 1, 7, 1);

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
-- Déchargement des données de la table `fournisseur`
--

INSERT INTO `fournisseur` (`id`, `nom`) VALUES
(1, 'Française d’Imports'),
(2, 'FDM SA'),
(3, 'Dubois & Fils');

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
