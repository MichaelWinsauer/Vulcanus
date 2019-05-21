-- phpMyAdmin SQL Dump
-- version 4.8.0.1
-- https://www.phpmyadmin.net/
--
-- Host: 127.0.0.1
-- Erstellungszeit: 14. Mai 2019 um 11:02
-- Server-Version: 10.1.32-MariaDB
-- PHP-Version: 7.2.5

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
SET AUTOCOMMIT = 0;
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Datenbank: `fi2017_gruppe1_projekt2_brandtnerduererwinsauer`
--

-- --------------------------------------------------------

--
-- Tabellenstruktur für Tabelle `Stelle`
--

CREATE TABLE `stelle` (
  `Id` int(11) NOT NULL PRIMARY KEY AUTO_INCREMENT,
  `Bezeichnung` varchar(64) COLLATE utf8_german2_ci NOT NULL
  ) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_german2_ci;


-- --------------------------------------------------------
--
-- Tabellenstruktur für Tabelle `angestellte`
--

CREATE TABLE `angestellte` (
  `Id` int(11) NOT NULL PRIMARY KEY AUTO_INCREMENT,
  `Name` varchar(64) COLLATE utf8_german2_ci NOT NULL,
  `Stelle` int(11) NOT NULL,
  `Pwhash` varchar(255) COLLATE utf8_german2_ci NOT NULL,
	CONSTRAINT Angestellte_Stelle FOREIGN KEY (Stelle)
		REFERENCES Stelle(id)
	
  ) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_german2_ci;


-- --------------------------------------------------------
--
-- Tabellenstruktur für Tabelle `ort`
--

CREATE TABLE `ort` (
  `Id` int(11) NOT NULL PRIMARY KEY AUTO_INCREMENT,
  `PLZ` int(5) NOT NULL,
  `Ortsname` varchar(64) COLLATE utf8_german2_ci NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_german2_ci;

-- --------------------------------------------------------
--
-- Tabellenstruktur für Tabelle `Bestellung`
--

CREATE TABLE `bestellung` (
  `Id` int(11) NOT NULL PRIMARY KEY AUTO_INCREMENT,
  `Name` varchar(64) COLLATE utf8_german2_ci NOT NULL,
  `Strasse` varchar(64) COLLATE utf8_german2_ci NOT NULL,
  `Ort` int(11) NOT NULL, 
  `Telefon` varchar(20) COLLATE utf8_german2_ci NOT NULL,
  CONSTRAINT bestellung_ort FOREIGN KEY(Ort)
	REFERENCES ort(Id)
  ) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_german2_ci;

-- --------------------------------------------------------


--
-- Tabellenstruktur für Tabelle `groesse`
--

CREATE TABLE `groesse` (
  `Id` int(11) NOT NULL PRIMARY KEY AUTO_INCREMENT,
  `Groesse` int(11) NOT NULL,
  `Zuschlag` float NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_german2_ci;

-- --------------------------------------------------------
--
-- Tabellenstruktur für Tabelle `zutat`
--

CREATE TABLE `zutat` (
  `Id` int(11) NOT NULL PRIMARY KEY AUTO_INCREMENT,
  `Bezeichnung` varchar(64) COLLATE utf8_german2_ci NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_german2_ci;

-- --------------------------------------------------------
--
-- Tabellenstruktur für Tabelle `Pizza`
--

CREATE TABLE `pizza` (
  `Id` int(11) NOT NULL PRIMARY KEY AUTO_INCREMENT,
  `Name` varchar(64) COLLATE utf8_german2_ci NOT NULL,
  `Dauer` int (2) NOT NULL,
  `Grundpreis` float NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_german2_ci;

-- --------------------------------------------------------
--
-- Tabellenstruktur für Tabelle `pizzazutat`
--

CREATE TABLE `pizzazutat` (
  `Id` int(11) NOT NULL PRIMARY KEY AUTO_INCREMENT,
  `Pizza` int(11) NOT NULL,
  `Zutat` int(11) NOT NULL, 
  CONSTRAINT PizzaFK FOREIGN KEY(Pizza) 
	REFERENCES Pizza(ID),
  CONSTRAINT ZutatFK FOREIGN KEY(Zutat) 
	REFERENCES Zutat(id)	
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_german2_ci;

-- --------------------------------------------------------

--
-- Tabellenstruktur für Tabelle `status`
--

CREATE TABLE `status` (
  `Id` int(11) NOT NULL PRIMARY KEY AUTO_INCREMENT,
  `Bezeichnung` varchar(64) COLLATE utf8_german2_ci NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_german2_ci;

-- --------------------------------------------------------
--
-- Tabellenstruktur für Tabelle `Bestellposition`
--

CREATE TABLE `bestellposition` (
  `Id` int(11) NOT NULL PRIMARY KEY AUTO_INCREMENT,
  `Bestellung` int(11)  NOT NULL,
  `Pizza` int(11)  NOT NULL,
  `Groesse` int(11)  NOT NULL,
  `Status` int(11)  NOT NULL,
  `Koch` int(11)  NOT NULL,
  `Lieferant` int(11)  NOT NULL,
	CONSTRAINT Bestellposition_Bestellung FOREIGN KEY (Bestellung)
		REFERENCES bestellung(Id),
	CONSTRAINT Bestellposition_Pizza FOREIGN KEY (Pizza)
		REFERENCES pizza(Id),
	CONSTRAINT Bestellposition_Groesse FOREIGN KEY (Groesse)
		REFERENCES Groesse(Id),		
	CONSTRAINT Bestellposition_Stauts FOREIGN KEY (Status)
		REFERENCES status(Id),
	CONSTRAINT Bestellposition_Koch FOREIGN KEY (Koch)
		REFERENCES angestellte(Id),
	CONSTRAINT Bestellposition_Lieferant FOREIGN KEY (Lieferant)
		REFERENCES angestellte(Id)		
  ) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_german2_ci;

COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
