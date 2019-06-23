<?php
//Change Cook of order position
//Expects: JSON Object with the Orderposition Id and new Cook
//Returns: JSON Data indicating Success and Error Message

//Method: POST
//Content-Type: application/json

//Format of Expected Data: JSON Object with the properties:
//BestellpositionId, Koch (Id)

//Example of valid, expected JSON:
/*
{
	"BestellpositionId": 21,
	"Koch": 2
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

$cookAssignRequest = decodeJson($inputText);

insertIntoDb($cookAssignRequest);

function insertIntoDb($cookAssignRequest)
{
	require_once("../connect.php");

	$pdo = PdoSingleton::getInstance();

	$sql = '
	UPDATE bestellposition
	SET Koch = :Koch
	WHERE Id = :Id
	';

	$statement = $pdo->prepare($sql);

	$statement->bindValue(':Koch', $cookAssignRequest["Koch"]);
	$statement->bindValue(':Id', $cookAssignRequest["BestellpositionId"], PDO::PARAM_INT);

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
