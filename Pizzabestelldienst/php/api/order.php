<?php
//Create an order in the database
//Expects: JSON Data describing the order
//Returns: JSON Data indicating Success and Error Message

//Method: POST
//Content-Type: application/json

//Format of Expected Data: JSON Object with the properties:
//Name, Strasse, OrtId, Telefon, Bestellpositionen
//Where Bestellpositionen is an Array of Objects with the properties:
//PizzaId, Groesse

//Example of valid, expected JSON:
/*
{
	"Name": "Benjamin Brandtner",
	"Strasse": "Am Koenigsberg 7",
	"OrtId": 1,
	"Telefon": "0931 672843",
	"Bestellpositionen":
	[
		{
			"PizzaId": 1,
			"Groesse": 32
		},
		{
			"PizzaId": 4,
			"Groesse": 32
		}
	]
}
*/

//Format of returned JSON: Object with the Properties
//Success, OrderId, ErrorMessage 

//Examples of returned JSON:
/*
{
	"Success": true,
	"OrderId": "3",
	"ErrorMessage": null
}

{
	"Success": false,
	"OrderId": null,
	"ErrorMessage": "Description of problem"
}
*/

$inputText = file_get_contents("php://input"); //get body of POST-Request

$order = decodeJson($inputText);
checkOrderForExpectedKeys($order);
checkOrderDataTypes($order);

$orderItems = $order["Bestellpositionen"];
$i=1;

foreach ($orderItems as $item) 
{
	checkItemForExpectedKeys($item, $i);
	checkItemDataTypes($item, $i);
	$i++;
}

insertOrderIntoDB($order);
$orderId = getOrderId($order); //Get Id of the order that was just created
insertItemsIntoDB($orderId, $orderItems);

$answer = new stdClass();
$answer->Success = true;
$answer->OrderId = $orderId;
$answer->ErrorMessage = null;
sendAnswerAndDie($answer);

function decodeJson($inputText)
{
	$order = json_decode($inputText, true); //decode into associative array

	if(is_null($order))
	{
		//JSON could not be parsed
		$answer = new stdClass();
		$answer->Success = false;
		$answer->OrderId = null;
		$answer->ErrorMessage = json_last_error_msg();
		sendAnswerAndDie($answer);
	}
	else
	{
		return $order;
	}
}

function checkOrderForExpectedKeys($order)
{
	$expectedKeys = array("Name","Strasse","OrtId","Telefon","Bestellpositionen");
	foreach ($expectedKeys as $key) 
	{
		if(!array_key_exists($key,$order))
		{
			$answer = new stdClass();
			$answer->Success = false;
			$answer->OrderId = null;
			$answer->ErrorMessage = "Invalid JSON. Key '$key' is missing.";
			sendAnswerAndDie($answer);
		}
	}
}

function checkOrderDataTypes($order)
{
	$tests = array();

	$tests["Name"] = is_string($order["Name"]);
	$tests["Strasse"] = is_string($order["Strasse"]);
	$tests["OrtId"] = is_numeric($order["OrtId"]);
	$tests["Telefon"] = is_string($order["Telefon"]);
	$tests["Bestellpositionen"] = is_array($order["Bestellpositionen"]);

	foreach ($tests as $key => $passed) 
	{
		if(!$passed)
		{
			$answer = new stdClass();
			$answer->Success = false;
			$answer->OrderId = null;
			$answer->ErrorMessage = "Value of '$key' is wrong datatype.";
			sendAnswerAndDie($answer);
		}
	}
}

function checkItemForExpectedKeys($item, $i)
{
	$expectedKeys = array("PizzaId","Groesse");

	foreach ($expectedKeys as $key) 
	{
		if(!array_key_exists($key,$item))
		{
			$answer = new stdClass();
			$answer->Success = false;
			$answer->OrderId = null;
			$answer->ErrorMessage = "Invalid JSON. Key '$key' is missing in item $i of Bestellpositionen.";
			sendAnswerAndDie($answer);
		}
	}
}

function checkItemDataTypes($item, $i)
{
	$tests = array();

	$tests["PizzaId"] = is_numeric($item["PizzaId"]);
	$tests["Groesse"] = is_numeric($item["Groesse"]);

	foreach ($tests as $key => $passed) 
	{
		if(!$passed)
		{
			$answer = new stdClass();
			$answer->Success = false;
			$answer->OrderId = null;
			$answer->ErrorMessage = "Value of '$key' is wrong datatype in item #$i of Bestellpositionen.";
			sendAnswerAndDie($answer);
		}
	}
}

function insertOrderIntoDb($order)
{
	require_once("../connect.php");

	$pdo = PdoSingleton::getInstance();

	$sql = '
	INSERT INTO bestellung 
	(
		Id,
		Name,
		Strasse,
		Ort,
		Telefon
	)
	VALUES
	(
		null,
		:Name,
		:Strasse,
		:OrtId,
		:Telefon
	)';

	$statement = $pdo->prepare($sql);

	$statement->bindValue(':Name', $order["Name"]);
	$statement->bindValue(':Strasse', $order["Strasse"]);
	$statement->bindValue(':OrtId', $order["OrtId"], PDO::PARAM_INT);
	$statement->bindValue(':Telefon', $order["Telefon"]);

	$success = $statement->execute();

	if(!$success)
	{
		$answer = new stdClass();
		$answer->Success = false;
		$answer->OrderId = null;
		$answer->ErrorMessage = ($statement->errorInfo())[2];
		sendAnswerAndDie($answer);
	}
}

function getOrderId($order)
{
	$pdo = PdoSingleton::getInstance();

	$sql = '
	SELECT b.Id
	FROM bestellung b
	WHERE b.Name = :Name
	AND b.Telefon = :Telefon
	ORDER BY Id DESC';

	$statement = $pdo->prepare($sql);

	$statement->bindValue(':Name', $order["Name"]);
	$statement->bindValue(':Telefon', $order["Telefon"]);

	$statement->execute();

	$result = $statement->fetch(PDO::FETCH_ASSOC);

	return $result["Id"];
}

function insertItemsIntoDB($orderId, $orderItems)
{
	$pdo = PdoSingleton::getInstance();

	$sql = '
	INSERT INTO bestellposition
	(
		Id,
		Bestellung,
		Pizza,
		Groesse,
		Status
	)
	VALUES
	(
		null,
		:orderId,
		:PizzaId,
		(
			SELECT g.Id
			FROM groesse g
			WHERE g.Groesse = :Groesse
		),
		(
			SELECT s.Id
			FROM status s
			WHERE s.Bezeichnung = \'Bestellung angenommen\'
		)
	)';

	$statement = $pdo->prepare($sql);
	$statement->bindValue(':orderId', $orderId);

	$i=1;

	foreach ($orderItems as $item)
	{
		$statement->bindValue(':PizzaId', $item["PizzaId"]);
		$statement->bindValue(':Groesse', $item["Groesse"]);
		
		$success = $statement->execute();

		if(!$success)
		{
			$answer = new stdClass();
			$answer->Success = false;
			$answer->OrderId = null;
			$answer->ErrorMessage = "Error while inserting order item #$i: " . ($statement->errorInfo())[2];
			sendAnswerAndDie($answer);
		}

		$i++;
	}
}

function sendAnswerAndDie($answer)
{
	echo json_encode($answer);
	die();
}