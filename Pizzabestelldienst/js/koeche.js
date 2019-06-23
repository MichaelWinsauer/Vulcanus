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
			url: "../../php/api/vKoeche.php",
			type: "GET",
			dataType: "JSON",
			success: (orderPositions) =>
			{
				$("tbody").empty();

				orderPositions.forEach(orderPosition =>
				{
					if (orderPosition.Koch === getCookie("Name") || orderPosition.Koch === null)
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
	let cookAssignRequest =
		{
			BestellpositionId: orderPositionId,
			Koch: getCookie("Id")
		};

	let statusChangeRequest =
		{
			BestellpositionId: orderPositionId,
			Status: newStatus
		};

	$.ajax(
		{
			url: "../../php/api/assignCook.php",
			type: "POST",
			contentType: "application/json",
			dataType: "JSON",
			data: JSON.stringify(cookAssignRequest),
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
	tr += newTd(orderPosition.Rezept);
	tr += newTd(orderPosition.Backzeit);
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
	let buttons = `<button type="button" onclick="changeStatus(${orderPosition.BestellpositionID},2)">Zubereiten</button>`;
	buttons += `<button type="button" onclick="changeStatus(${orderPosition.BestellpositionID},3)">In Ofen</button>`;
	buttons += `<button type="button" onclick="changeStatus(${orderPosition.BestellpositionID},4)">Fertig gebacken</button>`;

	return buttons;
}