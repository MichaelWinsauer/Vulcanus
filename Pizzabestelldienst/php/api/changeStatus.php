<?php
//Change Status of order position
//Expects: JSON Object with the Orderposition Id and new status
//Returns: JSON Data indicating Success and Error Message

//Method: POST
//Content-Type: application/json

//Format of Expected Data: JSON Object with the properties:
//BestellpositionID, Status (Integer 1 - 6)

//Example of valid, expected JSON:
/*
{
	"BestellpositionId": 21,
	"Status": 2
}
*/

//Format of returned JSON: Object with the Properties
//Success, ErrorMessage

//Examples of returned JSON:
/*
{
	"Success": true,
	"ErrorMessage": null
}

{
	"Success": false,
	"ErrorMessage": "Description of problem"
}
*/

$inputText = file_get_contents("php://input"); //get body of POST-Request

$statusChangeRequest = decodeJson($inputText);

checkOrderpositionExists($statusChangeRequest["BestellpositionId"]);
//checkStatusExists($statusChangeRequest["Status"]);

insertIntoDb($statusChangeRequest);

function checkOrderpositionExists($orderposition)
{
	require_once("../connect.php");

	$pdo = PdoSingleton::getInstance();

	$sql = '
	SELECT Id
	FROM bestellposition
	WHERE Id = :Id
	';

	$statement = $pdo->prepare($sql);

	$statement->bindValue(':Id', $orderposition, PDO::PARAM_INT);

	$statement->execute();

	if($statement->rowCount() === 1)
	{
		return true;
	}
	else
	{
		$answer = new stdClass();
		$answer->Success = false;
		$answer->ErrorMessage = "Orderposition does not exist in DB";
		sendAnswerAndDie($answer);
	}
}

function insertIntoDb($statusChangeRequest)
{
	require_once("../connect.php");

	$pdo = PdoSingleton::getInstance();

	$sql = '
	UPDATE bestellposition
	SET Status = :Status
	WHERE Id = :Id
	';

	$statement = $pdo->prepare($sql);

	$statement->bindValue(':Status', $statusChangeRequest["Status"]);
	$statement->bindValue(':Id', $statusChangeRequest["BestellpositionId"], PDO::PARAM_INT);

	$success = $statement->execute();

	if(!$success)
	{
		$answer = new stdClass();
		$answer->Success = false;
		$answer->ErrorMessage = ($statement->errorInfo())[2];
		sendAnswerAndDie($answer);
	}
	else
	{
		$answer = new stdClass();
		$answer->Success = true;
		$answer->ErrorMessage = null;
		sendAnswerAndDie($answer);
	}
}

function decodeJson($inputText)
{
	$changeStatusRequest = json_decode($inputText, true); //decode into associative array

	if(is_null($changeStatusRequest))
	{
		//JSON could not be parsed
		$answer = new stdClass();
		$answer->Success = false;
		$answer->ErrorMessage = json_last_error_msg();
		sendAnswerAndDie($answer);
	}
	else
	{
		return $changeStatusRequest;
	}
}

function sendAnswerAndDie($answer)
{
	echo json_encode($answer);
	die();
}
