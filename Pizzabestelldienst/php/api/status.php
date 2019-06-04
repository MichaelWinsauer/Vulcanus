<?php
//Retrieve Status of order
//Expects: JSON Object with the Order Id
//Returns: JSON Object with the Status

//Method: POST
//Content-Type: application/json

//Format of Expected Data: JSON Object with the properties:
//BestellId

//Example of valid, expected JSON:
/*
{
	"BestellId": 12
}
*/

//Format of returned Data: JSON Object with the Properties
//Bestell-Id, Status

//Examples of returned JSON:
/*
{
	"BestellId": "12",
	"StatusId": "3",
	"Bezeichnung": "Im Ofen"
}
*/

$inputText = file_get_contents("php://input"); //get body of POST-Request

$query = json_decode($inputText, true); //decode into associative array

require_once("../connect.php");

$pdo = PdoSingleton::getInstance();

$sql = '
SELECT *
FROM vStatus
WHERE BestellID = :BestellId
';

$statement = $pdo->prepare($sql);
$statement->bindValue(':BestellId', $query["BestellId"]);

$statement->execute();
$result = $statement->fetchAll(PDO::FETCH_ASSOC);

echo json_encode($result);