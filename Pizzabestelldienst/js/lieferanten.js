let requestTimer;

$(document).ready(() =>
{
	requestData();
	requestTimer = window.setInterval(requestData, 5000); //5 seconds
});

function requestData()
{
	$("#loadingIndicator").fadeIn();
	$.ajax(
		{
			url: "../../php/api/vLieferanten.php",
			type: "GET",
			dataType: "JSON",
			success: (orderPositions) =>
			{
				$("tbody").empty();

				orderPositions.forEach(orderPosition =>
				{
					if (orderPosition.Lieferant === getCookie("Name") || orderPosition.Lieferant === null)
					{
						displayInTable(orderPosition);
					}
				});

				$("#loadingIndicator").fadeOut();
			}
		});

}

function changeStatus(orderPositionId, newStatus)
{
	let deliveryAssignRequest =
		{
			BestellpositionId: orderPositionId,
			Lieferant: getCookie("Id")
		};

	let statusChangeRequest =
		{
			BestellpositionId: orderPositionId,
			Status: newStatus
		};

	$.ajax(
		{
			url: "../../php/api/assignDelivery.php",
			type: "POST",
			contentType: "application/json",
			dataType: "JSON",
			data: JSON.stringify(deliveryAssignRequest),
			success: (result) =>
			{
				if (!result.Success)
				{
					window.alert("Couldn't assign cook: " + result.ErrorMessage);
				}
			}
		});

	$.ajax(
		{
			url: "../../php/api/changeStatus.php",
			type: "POST",
			contentType: "application/json",
			dataType: "JSON",
			data: JSON.stringify(statusChangeRequest),
			success: (result) =>
			{
				if (!result.Success)
				{
					window.alert("Couldn't update status: " + result.ErrorMessage);
				}

				window.clearInterval(requestTimer);
				requestTimer = window.setInterval(requestData, 5000);
				requestData();
			}
		});
}

function displayInTable(orderPosition)
{
	$("tbody").append(newTr(orderPosition));
}

function newTr(orderPosition)
{
	let tr = "<tr>";
	tr += newTd(orderPosition.BestellID);
	tr += newTd(orderPosition.BestellpositionID);
	tr += newTd(orderPosition.Pizza);
	tr += newTd(orderPosition.Groesse);
	tr += newTd(orderPosition.Name);
	tr += newTd(orderPosition.Strasse);
	tr += newTd(orderPosition.Ort);
	tr += newTd(orderPosition.Preis);
	tr += newTd(orderPosition.Status);
	tr += newTd(createButtons(orderPosition));

	tr += "</tr>";

	return tr;
}

function newTd(data)
{
	let td = "<td>";
	td += data;
	td += "</td>";

	return td;
}

function createButtons(orderPosition)
{
	let buttons = `<button type="button" onclick="changeStatus(${orderPosition.BestellpositionID},5)">Geladen</button>`;
	buttons += `<button type="button" onclick="changeStatus(${orderPosition.BestellpositionID},6)">Ausgeliefert</button>`;

	return buttons;
}
