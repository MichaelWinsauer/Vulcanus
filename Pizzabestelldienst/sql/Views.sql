-- Speißekarte
CREATE OR REPLACE VIEW vSpeisekarte AS
SELECT
	p.Id,
	p.Name AS Pizza,
	(		
		SELECT GROUP_CONCAT(z.Bezeichnung SEPARATOR ', ')
		FROM zutat z
		INNER JOIN pizzazutat pz ON z.Id = pz.Zutat
		INNER JOIN Pizza p2 ON pz.Pizza = p2.Id
		WHERE p2.Id = p.Id
	) AS Rezept,
	p.Schärfe,
	CONCAT(FORMAT(p.Grundpreis, 2, 'de_DE'), ' €') AS '28cm',
	CONCAT(FORMAT(
		(
			SELECT p.Grundpreis + g.Zuschlag
			FROM groesse g
			WHERE g.Groesse = 32
		)
		, 2, 'de_DE'), ' €') AS '32cm'
FROM pizza p
ORDER BY p.Id ASC

-- Köche
CREATE OR REPLACE VIEW vKoeche AS
SELECT 
	b.Id AS 'Bestell-ID',
	bp.Id AS 'Bestellposition-ID',
	p.Name AS Pizza,
	g.Groesse AS Groesse,
	(		
		SELECT GROUP_CONCAT(z.Bezeichnung SEPARATOR ', ')
		FROM zutat z
		INNER JOIN pizzazutat pz ON z.Id = pz.Zutat
		INNER JOIN Pizza p2 ON pz.Pizza = p2.Id
		WHERE p2.Id = p.Id
	) AS Rezept,
	p.Dauer AS Backzeit,
	s.Bezeichnung AS Status,
	a.Name AS Koch
FROM bestellung b
INNER JOIN bestellposition bp ON b.Id = bp.Bestellung
INNER JOIN pizza p ON bp.Pizza = p.Id
INNER JOIN groesse g ON bp.Groesse = g.Id
INNER JOIN status s ON bp.Status = s.Id
LEFT JOIN angestellte a ON bp.Koch = a.Id
WHERE s.Bezeichnung = "Bestellung angenommen"
OR s.Bezeichnung = "Wird zubereitet"
OR s.Bezeichnung = "Im Ofen"
ORDER BY b.Id ASC, bp.Id ASC;

-- Lieferanten
CREATE OR REPLACE VIEW vLieferanten AS
SELECT
	b.Id AS 'Bestell-ID',
	bp.Id AS 'Bestellposition-ID',
	p.Name AS Pizza,
    g.Groesse,
	b.Name,
	b.Strasse,
	CONCAT(o.PLZ, ' ', o.Ortsname) AS Ort,
	CONCAT(FORMAT(p.Grundpreis + g.Zuschlag, 2, 'de_DE'), ' €') AS Preis,
	s.Bezeichnung AS Status,
	a.Name AS Lieferant
FROM bestellung b
INNER JOIN bestellposition bp ON b.Id = bp.Bestellung
INNER JOIN pizza p ON bp.Pizza = p.Id
INNER JOIN groesse g ON bp.Groesse = g.Id
INNER JOIN status s ON bp.Status = s.Id
INNER JOIN ort o ON b.Ort = o.Id
LEFT JOIN angestellte a ON bp.Lieferant = a.Id
WHERE s.Bezeichnung = "Fertig gebacken"
OR s.Bezeichnung = "Wird ausgeliefert"
ORDER BY b.Id ASC, bp.Id ASC;