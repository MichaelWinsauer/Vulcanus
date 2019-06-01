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
OR s.Bezeichnung = "Im Ofen";