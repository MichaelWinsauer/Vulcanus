//TODO: Mit Ajax regelmäßig die Datenbank abfragen nach vKoeche
//Tabelle mit diesen Daten erzeugen, dabei nach Koch == null oder Koch == eingeloggter Koch filtern
//Je nach Status den richtigen Knopf verfügbar machen.
//Auf Knopfdruck mit Ajax die Datenbank updaten
//Fertig gebackene Pizzen aus der Tabelle entfernen.

$(document).ready(() =>
{
	$.ajax(
	{
        url: "../../php/api/vKoeche.php",
        type: "GET",
        dataType: "JSON",
		success: (orderPositions) =>
		{
			$("tbody").empty();

			orderPositions.forEach(orderPosition => 
			{
				if(orderPosition.Koch == getCookie("Name") || orderPosition.Koch == null)
				{
					displayInTable(orderPosition);
				}
			});
		}
	});

});

function displayInTable(orderPosition)
{
	$("tbody").append(newTr(orderPosition));
}

function newTr(orderPosition)
{
	var tr = "<tr>";
	tr += newTd(orderPosition.BestellID);
	tr += newTd(orderPosition.BestellpositionID);
	tr += newTd(orderPosition.Pizza);
	tr += newTd(orderPosition.Groesse);
	tr += newTd(orderPosition.Rezept);
	tr += newTd(orderPosition.Backzeit);
	tr += newTd(orderPosition.Status);
	tr += newTd(createButtons());

	tr += "</tr>";

	return tr;
}

function newTd(data)
{
	var td = "<td>";
	td += data;
	td += "</td>";

	return td;
}

function createButtons()
{
	return "Buttons";
}