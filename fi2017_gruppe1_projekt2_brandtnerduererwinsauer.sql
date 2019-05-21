-- phpMyAdmin SQL Dump
-- version 4.8.0.1
-- https://www.phpmyadmin.net/
--
-- Host: 127.0.0.1
-- Erstellungszeit: 21. Mai 2019 um 11:12
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
-- Tabellenstruktur für Tabelle `angestellte`
--

CREATE TABLE `angestellte` (
  `Id` int(11) NOT NULL,
  `Name` varchar(64) COLLATE utf8_german2_ci NOT NULL,
  `Stelle` int(11) NOT NULL,
  `Pwhash` varchar(255) COLLATE utf8_german2_ci NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_german2_ci;

--
-- Daten für Tabelle `angestellte`
--

INSERT INTO `angestellte` (`Id`, `Name`, `Stelle`, `Pwhash`) VALUES
(1, 'Joseph', 1, '$2y$10$WlFzNwb5DUZ7e1E1RIOtNO1Rf0xHTEPxHLpNTT0Sl/oF7diayI8AC'),
(2, 'Adolf', 1, '$2y$10$UTpq2T/npYerZNuvGq0ioexZA.xzDGOosMgfvfHm1pkzTxGpRNLIa'),
(3, 'Josef', 2, '$2y$10$UReQOKgYlK3eyiIto1NsMeXYv.BtXmFGrKm5wm16wACgoDxt4FTYm'),
(4, 'Anne', 2, '$2y$10$IKckIzFSuOY4.BkvxZUgluWHTFcVSJqfewL0Kgu.hU7cXgF2DOD9O');

-- --------------------------------------------------------

--
-- Tabellenstruktur für Tabelle `bestellposition`
--

CREATE TABLE `bestellposition` (
  `Id` int(11) NOT NULL,
  `Bestellung` int(11) NOT NULL,
  `Pizza` int(11) NOT NULL,
  `Groesse` int(11) NOT NULL,
  `Status` int(11) NOT NULL,
  `Koch` int(11) NOT NULL,
  `Lieferant` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_german2_ci;

-- --------------------------------------------------------

--
-- Tabellenstruktur für Tabelle `bestellung`
--

CREATE TABLE `bestellung` (
  `Id` int(11) NOT NULL,
  `Name` varchar(64) COLLATE utf8_german2_ci NOT NULL,
  `Strasse` varchar(64) COLLATE utf8_german2_ci NOT NULL,
  `Ort` int(11) NOT NULL,
  `Telefon` varchar(20) COLLATE utf8_german2_ci NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_german2_ci;

-- --------------------------------------------------------

--
-- Tabellenstruktur für Tabelle `groesse`
--

CREATE TABLE `groesse` (
  `Id` int(11) NOT NULL,
  `Groesse` int(11) NOT NULL,
  `Zuschlag` float NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_german2_ci;

-- --------------------------------------------------------

--
-- Tabellenstruktur für Tabelle `ort`
--

CREATE TABLE `ort` (
  `Id` int(11) NOT NULL,
  `PLZ` int(5) NOT NULL,
  `Ortsname` varchar(64) COLLATE utf8_german2_ci NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_german2_ci;

-- --------------------------------------------------------

--
-- Tabellenstruktur für Tabelle `pizza`
--

CREATE TABLE `pizza` (
  `Id` int(11) NOT NULL,
  `Name` varchar(64) COLLATE utf8_german2_ci NOT NULL,
  `Dauer` int(2) NOT NULL,
  `Grundpreis` float NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_german2_ci;

-- --------------------------------------------------------

--
-- Tabellenstruktur für Tabelle `pizzazutat`
--

CREATE TABLE `pizzazutat` (
  `Id` int(11) NOT NULL,
  `Pizza` int(11) NOT NULL,
  `Zutat` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_german2_ci;

-- --------------------------------------------------------

--
-- Tabellenstruktur für Tabelle `status`
--

CREATE TABLE `status` (
  `Id` int(11) NOT NULL,
  `Bezeichnung` varchar(64) COLLATE utf8_german2_ci NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_german2_ci;

-- --------------------------------------------------------

--
-- Tabellenstruktur für Tabelle `stelle`
--

CREATE TABLE `stelle` (
  `Id` int(11) NOT NULL,
  `Bezeichnung` varchar(64) COLLATE utf8_german2_ci NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_german2_ci;

--
-- Daten für Tabelle `stelle`
--

INSERT INTO `stelle` (`Id`, `Bezeichnung`) VALUES
(1, 'Koch'),
(2, 'Lieferant');

-- --------------------------------------------------------

--
-- Tabellenstruktur für Tabelle `zutat`
--

CREATE TABLE `zutat` (
  `Id` int(11) NOT NULL,
  `Bezeichnung` varchar(64) COLLATE utf8_german2_ci NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_german2_ci;

--
-- Indizes der exportierten Tabellen
--

--
-- Indizes für die Tabelle `angestellte`
--
ALTER TABLE `angestellte`
  ADD PRIMARY KEY (`Id`),
  ADD KEY `Angestellte_Stelle` (`Stelle`);

--
-- Indizes für die Tabelle `bestellposition`
--
ALTER TABLE `bestellposition`
  ADD PRIMARY KEY (`Id`),
  ADD KEY `Bestellposition_Bestellung` (`Bestellung`),
  ADD KEY `Bestellposition_Pizza` (`Pizza`),
  ADD KEY `Bestellposition_Groesse` (`Groesse`),
  ADD KEY `Bestellposition_Stauts` (`Status`),
  ADD KEY `Bestellposition_Koch` (`Koch`),
  ADD KEY `Bestellposition_Lieferant` (`Lieferant`);

--
-- Indizes für die Tabelle `bestellung`
--
ALTER TABLE `bestellung`
  ADD PRIMARY KEY (`Id`),
  ADD KEY `bestellung_ort` (`Ort`);

--
-- Indizes für die Tabelle `groesse`
--
ALTER TABLE `groesse`
  ADD PRIMARY KEY (`Id`);

--
-- Indizes für die Tabelle `ort`
--
ALTER TABLE `ort`
  ADD PRIMARY KEY (`Id`);

--
-- Indizes für die Tabelle `pizza`
--
ALTER TABLE `pizza`
  ADD PRIMARY KEY (`Id`);

--
-- Indizes für die Tabelle `pizzazutat`
--
ALTER TABLE `pizzazutat`
  ADD PRIMARY KEY (`Id`),
  ADD KEY `PizzaFK` (`Pizza`),
  ADD KEY `ZutatFK` (`Zutat`);

--
-- Indizes für die Tabelle `status`
--
ALTER TABLE `status`
  ADD PRIMARY KEY (`Id`);

--
-- Indizes für die Tabelle `stelle`
--
ALTER TABLE `stelle`
  ADD PRIMARY KEY (`Id`);

--
-- Indizes für die Tabelle `zutat`
--
ALTER TABLE `zutat`
  ADD PRIMARY KEY (`Id`);

--
-- AUTO_INCREMENT für exportierte Tabellen
--

--
-- AUTO_INCREMENT für Tabelle `angestellte`
--
ALTER TABLE `angestellte`
  MODIFY `Id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=5;

--
-- AUTO_INCREMENT für Tabelle `bestellposition`
--
ALTER TABLE `bestellposition`
  MODIFY `Id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT für Tabelle `bestellung`
--
ALTER TABLE `bestellung`
  MODIFY `Id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT für Tabelle `groesse`
--
ALTER TABLE `groesse`
  MODIFY `Id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT für Tabelle `ort`
--
ALTER TABLE `ort`
  MODIFY `Id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT für Tabelle `pizza`
--
ALTER TABLE `pizza`
  MODIFY `Id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT für Tabelle `pizzazutat`
--
ALTER TABLE `pizzazutat`
  MODIFY `Id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT für Tabelle `status`
--
ALTER TABLE `status`
  MODIFY `Id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT für Tabelle `stelle`
--
ALTER TABLE `stelle`
  MODIFY `Id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=3;

--
-- AUTO_INCREMENT für Tabelle `zutat`
--
ALTER TABLE `zutat`
  MODIFY `Id` int(11) NOT NULL AUTO_INCREMENT;

--
-- Constraints der exportierten Tabellen
--

--
-- Constraints der Tabelle `angestellte`
--
ALTER TABLE `angestellte`
  ADD CONSTRAINT `Angestellte_Stelle` FOREIGN KEY (`Stelle`) REFERENCES `stelle` (`Id`);

--
-- Constraints der Tabelle `bestellposition`
--
ALTER TABLE `bestellposition`
  ADD CONSTRAINT `Bestellposition_Bestellung` FOREIGN KEY (`Bestellung`) REFERENCES `bestellung` (`Id`),
  ADD CONSTRAINT `Bestellposition_Groesse` FOREIGN KEY (`Groesse`) REFERENCES `groesse` (`Id`),
  ADD CONSTRAINT `Bestellposition_Koch` FOREIGN KEY (`Koch`) REFERENCES `angestellte` (`Id`),
  ADD CONSTRAINT `Bestellposition_Lieferant` FOREIGN KEY (`Lieferant`) REFERENCES `angestellte` (`Id`),
  ADD CONSTRAINT `Bestellposition_Pizza` FOREIGN KEY (`Pizza`) REFERENCES `pizza` (`Id`),
  ADD CONSTRAINT `Bestellposition_Stauts` FOREIGN KEY (`Status`) REFERENCES `status` (`Id`);

--
-- Constraints der Tabelle `bestellung`
--
ALTER TABLE `bestellung`
  ADD CONSTRAINT `bestellung_ort` FOREIGN KEY (`Ort`) REFERENCES `ort` (`Id`);

--
-- Constraints der Tabelle `pizzazutat`
--
ALTER TABLE `pizzazutat`
  ADD CONSTRAINT `PizzaFK` FOREIGN KEY (`Pizza`) REFERENCES `pizza` (`Id`),
  ADD CONSTRAINT `ZutatFK` FOREIGN KEY (`Zutat`) REFERENCES `zutat` (`Id`);
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
