-- phpMyAdmin SQL Dump
-- version 4.8.0.1
-- https://www.phpmyadmin.net/
--
-- Host: 127.0.0.1
-- Erstellungszeit: 06. Jun 2019 um 12:20
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
  `Koch` int(11) DEFAULT NULL,
  `Lieferant` int(11) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_german2_ci;

--
-- Daten für Tabelle `bestellposition`
--

INSERT INTO `bestellposition` (`Id`, `Bestellung`, `Pizza`, `Groesse`, `Status`, `Koch`, `Lieferant`) VALUES
(1, 1, 1, 2, 1, NULL, NULL),
(2, 2, 12, 2, 2, 1, NULL),
(3, 3, 1, 2, 5, 2, 4),
(4, 4, 9, 1, 3, 2, NULL),
(5, 5, 7, 2, 6, 2, 3),
(6, 1, 4, 2, 1, NULL, NULL),
(7, 3, 7, 2, 4, 2, NULL),
(16, 14, 6, 2, 1, NULL, NULL),
(17, 14, 8, 1, 1, NULL, NULL),
(34, 17, 6, 1, 1, NULL, NULL),
(35, 17, 6, 1, 1, NULL, NULL),
(36, 17, 6, 1, 1, NULL, NULL),
(37, 17, 6, 1, 1, NULL, NULL),
(38, 17, 6, 1, 1, NULL, NULL),
(39, 17, 6, 1, 1, NULL, NULL),
(40, 17, 6, 1, 1, NULL, NULL),
(41, 17, 6, 1, 1, NULL, NULL),
(42, 17, 6, 1, 1, NULL, NULL),
(43, 17, 6, 1, 1, NULL, NULL),
(44, 17, 6, 1, 1, NULL, NULL),
(45, 17, 6, 1, 1, NULL, NULL),
(46, 17, 6, 1, 1, NULL, NULL),
(47, 17, 6, 1, 1, NULL, NULL);

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

--
-- Daten für Tabelle `bestellung`
--

INSERT INTO `bestellung` (`Id`, `Name`, `Strasse`, `Ort`, `Telefon`) VALUES
(1, 'Benjamin Brandtner', 'Am Königsberg 7', 1, '0931 672843'),
(2, 'Lukas Dürer', 'Friedrich-Ebert-Ring 13', 6, '09391 171345'),
(3, 'Michael Winsauer', 'Würzburger Straße 56', 2, '0931 134545'),
(4, 'Marcel Scheinpflug', 'Daheim 24', 3, '09391 67345'),
(5, 'Philipp Hägerich', 'Eueracher Straße 99', 5, '0931 19145'),
(14, 'Tobias', 'Zeunrich-Heiner-Strasse 80', 1, '0931 672847');

-- --------------------------------------------------------

--
-- Tabellenstruktur für Tabelle `groesse`
--

CREATE TABLE `groesse` (
  `Id` int(11) NOT NULL,
  `Groesse` int(11) NOT NULL,
  `Zuschlag` float NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_german2_ci;

--
-- Daten für Tabelle `groesse`
--

INSERT INTO `groesse` (`Id`, `Groesse`, `Zuschlag`) VALUES
(1, 28, 0),
(2, 32, 1);

-- --------------------------------------------------------

--
-- Tabellenstruktur für Tabelle `ort`
--

CREATE TABLE `ort` (
  `Id` int(11) NOT NULL,
  `PLZ` int(5) NOT NULL,
  `Ortsname` varchar(64) COLLATE utf8_german2_ci NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_german2_ci;

--
-- Daten für Tabelle `ort`
--

INSERT INTO `ort` (`Id`, `PLZ`, `Ortsname`) VALUES
(1, 97070, 'Würzburg'),
(2, 57072, 'Siegen'),
(3, 85049, 'Ingolstadt'),
(4, 9111, 'Chemnitz'),
(5, 51371, 'Leberkusen'),
(6, 89073, 'Ulm');

-- --------------------------------------------------------

--
-- Tabellenstruktur für Tabelle `pizza`
--

CREATE TABLE `pizza` (
  `Id` int(11) NOT NULL,
  `Name` varchar(64) COLLATE utf8_german2_ci NOT NULL,
  `Dauer` int(2) NOT NULL,
  `Grundpreis` float NOT NULL,
  `Schärfe` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_german2_ci;

--
-- Daten für Tabelle `pizza`
--

INSERT INTO `pizza` (`Id`, `Name`, `Dauer`, `Grundpreis`, `Schärfe`) VALUES
(1, 'Margherita', 12, 6, 0),
(2, 'Salami', 14, 6.5, 1),
(3, 'Prosciutto', 14, 6.5, 0),
(4, 'Peperoni', 12, 6.5, 3),
(5, 'Prosciutto Funghi', 13, 7, 0),
(6, 'Mary', 15, 7.5, 1),
(7, 'Hawaii', 16, 7, 0),
(8, 'Bolognese', 18, 6.5, 1),
(9, 'Thunfisch', 13, 8, 0),
(10, 'Mozzarella', 12, 7, 0),
(11, 'Quattro Formaggi', 13, 8, 0),
(12, 'Diavolo', 14, 7.5, 5);

-- --------------------------------------------------------

--
-- Tabellenstruktur für Tabelle `pizzazutat`
--

CREATE TABLE `pizzazutat` (
  `Id` int(11) NOT NULL,
  `Pizza` int(11) NOT NULL,
  `Zutat` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_german2_ci;

--
-- Daten für Tabelle `pizzazutat`
--

INSERT INTO `pizzazutat` (`Id`, `Pizza`, `Zutat`) VALUES
(5, 1, 1),
(6, 2, 16),
(7, 2, 1),
(8, 3, 18),
(9, 3, 1),
(10, 4, 21),
(11, 4, 1),
(12, 5, 18),
(13, 5, 13),
(14, 5, 1),
(26, 6, 18),
(27, 6, 16),
(28, 6, 13),
(29, 6, 1),
(30, 7, 18),
(31, 7, 20),
(32, 7, 1),
(33, 8, 22),
(34, 8, 1),
(35, 9, 9),
(36, 9, 11),
(37, 9, 1),
(38, 10, 7),
(39, 10, 2),
(40, 10, 1),
(41, 11, 1),
(42, 11, 4),
(43, 11, 6),
(44, 11, 2),
(45, 12, 11),
(46, 12, 12),
(47, 12, 21),
(48, 12, 1);

-- --------------------------------------------------------

--
-- Tabellenstruktur für Tabelle `status`
--

CREATE TABLE `status` (
  `Id` int(11) NOT NULL,
  `Bezeichnung` varchar(64) COLLATE utf8_german2_ci NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_german2_ci;

--
-- Daten für Tabelle `status`
--

INSERT INTO `status` (`Id`, `Bezeichnung`) VALUES
(1, 'Bestellung angenommen'),
(2, 'Wird zubereitet'),
(3, 'Im Ofen'),
(4, 'Fertig gebacken'),
(5, 'Wird ausgeliefert'),
(6, 'Ist ausgeliefert');

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
-- Stellvertreter-Struktur des Views `vkoeche`
-- (Siehe unten für die tatsächliche Ansicht)
--
CREATE TABLE `vkoeche` (
`BestellID` int(11)
,`BestellpositionID` int(11)
,`Pizza` varchar(64)
,`Groesse` int(11)
,`Rezept` text
,`Backzeit` int(2)
,`Status` varchar(64)
,`Koch` varchar(64)
);

-- --------------------------------------------------------

--
-- Stellvertreter-Struktur des Views `vlieferanten`
-- (Siehe unten für die tatsächliche Ansicht)
--
CREATE TABLE `vlieferanten` (
`BestellID` int(11)
,`BestellpositionID` int(11)
,`Pizza` varchar(64)
,`Groesse` int(11)
,`Name` varchar(64)
,`Strasse` varchar(64)
,`Ort` varchar(76)
,`Preis` varchar(65)
,`Status` varchar(64)
,`Lieferant` varchar(64)
);

-- --------------------------------------------------------

--
-- Stellvertreter-Struktur des Views `vspeisekarte`
-- (Siehe unten für die tatsächliche Ansicht)
--
CREATE TABLE `vspeisekarte` (
`Id` int(11)
,`Pizza` varchar(64)
,`Rezept` text
,`Schärfe` int(11)
,`28cm` varchar(51)
,`32cm` varchar(65)
);

-- --------------------------------------------------------

--
-- Stellvertreter-Struktur des Views `vstatus`
-- (Siehe unten für die tatsächliche Ansicht)
--
CREATE TABLE `vstatus` (
`BestellId` int(11)
,`StatusId` int(11)
,`Bezeichnung` varchar(64)
);

-- --------------------------------------------------------

--
-- Tabellenstruktur für Tabelle `zutat`
--

CREATE TABLE `zutat` (
  `Id` int(11) NOT NULL,
  `Bezeichnung` varchar(64) COLLATE utf8_german2_ci NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_german2_ci;

--
-- Daten für Tabelle `zutat`
--

INSERT INTO `zutat` (`Id`, `Bezeichnung`) VALUES
(1, 'Emmentaler'),
(2, 'Mozzarella'),
(3, 'Fontina'),
(4, 'Gorgonzola'),
(5, 'Parmesan'),
(6, 'Gouda'),
(7, 'Tomaten'),
(8, 'Oliven'),
(9, 'Thunfisch'),
(10, 'Pfefferschoten'),
(11, 'Zwiebeln'),
(12, 'Paprika'),
(13, 'Pilze'),
(14, 'Spinat'),
(15, 'Zucchini'),
(16, 'Salami'),
(17, 'Speck'),
(18, 'Schinken'),
(19, 'Knoblauch'),
(20, 'Ananas'),
(21, 'Pepperoni'),
(22, 'Fleischsoße');

-- --------------------------------------------------------

--
-- Struktur des Views `vkoeche`
--
DROP TABLE IF EXISTS `vkoeche`;

CREATE ALGORITHM=UNDEFINED DEFINER=`root`@`localhost` SQL SECURITY DEFINER VIEW `vkoeche`  AS  select `b`.`Id` AS `BestellID`,`bp`.`Id` AS `BestellpositionID`,`p`.`Name` AS `Pizza`,`g`.`Groesse` AS `Groesse`,(select group_concat(`z`.`Bezeichnung` separator ', ') from ((`zutat` `z` join `pizzazutat` `pz` on((`z`.`Id` = `pz`.`Zutat`))) join `pizza` `p2` on((`pz`.`Pizza` = `p2`.`Id`))) where (`p2`.`Id` = `p`.`Id`)) AS `Rezept`,`p`.`Dauer` AS `Backzeit`,`s`.`Bezeichnung` AS `Status`,`a`.`Name` AS `Koch` from (((((`bestellung` `b` join `bestellposition` `bp` on((`b`.`Id` = `bp`.`Bestellung`))) join `pizza` `p` on((`bp`.`Pizza` = `p`.`Id`))) join `groesse` `g` on((`bp`.`Groesse` = `g`.`Id`))) join `status` `s` on((`bp`.`Status` = `s`.`Id`))) left join `angestellte` `a` on((`bp`.`Koch` = `a`.`Id`))) where ((`s`.`Bezeichnung` = 'Bestellung angenommen') or (`s`.`Bezeichnung` = 'Wird zubereitet') or (`s`.`Bezeichnung` = 'Im Ofen')) order by `b`.`Id`,`bp`.`Id` ;

-- --------------------------------------------------------

--
-- Struktur des Views `vlieferanten`
--
DROP TABLE IF EXISTS `vlieferanten`;

CREATE ALGORITHM=UNDEFINED DEFINER=`root`@`localhost` SQL SECURITY DEFINER VIEW `vlieferanten`  AS  select `b`.`Id` AS `BestellID`,`bp`.`Id` AS `BestellpositionID`,`p`.`Name` AS `Pizza`,`g`.`Groesse` AS `Groesse`,`b`.`Name` AS `Name`,`b`.`Strasse` AS `Strasse`,concat(`o`.`PLZ`,' ',`o`.`Ortsname`) AS `Ort`,concat(format((`p`.`Grundpreis` + `g`.`Zuschlag`),2,'de_DE'),' €') AS `Preis`,`s`.`Bezeichnung` AS `Status`,`a`.`Name` AS `Lieferant` from ((((((`bestellung` `b` join `bestellposition` `bp` on((`b`.`Id` = `bp`.`Bestellung`))) join `pizza` `p` on((`bp`.`Pizza` = `p`.`Id`))) join `groesse` `g` on((`bp`.`Groesse` = `g`.`Id`))) join `status` `s` on((`bp`.`Status` = `s`.`Id`))) join `ort` `o` on((`b`.`Ort` = `o`.`Id`))) left join `angestellte` `a` on((`bp`.`Lieferant` = `a`.`Id`))) where ((`s`.`Bezeichnung` = 'Fertig gebacken') or (`s`.`Bezeichnung` = 'Wird ausgeliefert')) order by `b`.`Id`,`bp`.`Id` ;

-- --------------------------------------------------------

--
-- Struktur des Views `vspeisekarte`
--
DROP TABLE IF EXISTS `vspeisekarte`;

CREATE ALGORITHM=UNDEFINED DEFINER=`root`@`localhost` SQL SECURITY DEFINER VIEW `vspeisekarte`  AS  select `p`.`Id` AS `Id`,`p`.`Name` AS `Pizza`,(select group_concat(`z`.`Bezeichnung` separator ', ') from ((`zutat` `z` join `pizzazutat` `pz` on((`z`.`Id` = `pz`.`Zutat`))) join `pizza` `p2` on((`pz`.`Pizza` = `p2`.`Id`))) where (`p2`.`Id` = `p`.`Id`)) AS `Rezept`,`p`.`Schärfe` AS `Schärfe`,concat(format(`p`.`Grundpreis`,2,'de_DE'),' €') AS `28cm`,concat(format((select (`p`.`Grundpreis` + `g`.`Zuschlag`) from `groesse` `g` where (`g`.`Groesse` = 32)),2,'de_DE'),' €') AS `32cm` from `pizza` `p` ;

-- --------------------------------------------------------

--
-- Struktur des Views `vstatus`
--
DROP TABLE IF EXISTS `vstatus`;

CREATE ALGORITHM=UNDEFINED DEFINER=`root`@`localhost` SQL SECURITY DEFINER VIEW `vstatus`  AS  select `b`.`Id` AS `BestellId`,min(`bp`.`Status`) AS `StatusId`,`s`.`Bezeichnung` AS `Bezeichnung` from ((`bestellung` `b` join `bestellposition` `bp` on((`b`.`Id` = `bp`.`Bestellung`))) join `status` `s` on((`bp`.`Status` = `s`.`Id`))) group by `b`.`Id` order by `b`.`Id`,`bp`.`Id` ;

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
  MODIFY `Id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=48;

--
-- AUTO_INCREMENT für Tabelle `bestellung`
--
ALTER TABLE `bestellung`
  MODIFY `Id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=18;

--
-- AUTO_INCREMENT für Tabelle `groesse`
--
ALTER TABLE `groesse`
  MODIFY `Id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=3;

--
-- AUTO_INCREMENT für Tabelle `ort`
--
ALTER TABLE `ort`
  MODIFY `Id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=7;

--
-- AUTO_INCREMENT für Tabelle `pizza`
--
ALTER TABLE `pizza`
  MODIFY `Id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=13;

--
-- AUTO_INCREMENT für Tabelle `pizzazutat`
--
ALTER TABLE `pizzazutat`
  MODIFY `Id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=49;

--
-- AUTO_INCREMENT für Tabelle `status`
--
ALTER TABLE `status`
  MODIFY `Id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=7;

--
-- AUTO_INCREMENT für Tabelle `stelle`
--
ALTER TABLE `stelle`
  MODIFY `Id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=3;

--
-- AUTO_INCREMENT für Tabelle `zutat`
--
ALTER TABLE `zutat`
  MODIFY `Id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=23;

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
