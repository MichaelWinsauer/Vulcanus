<?php
//Create an order in the database
//Expects: JSON Data describing the order
//Returns: JSON Data indicating Success and Error Message

//Method: POST
//Content-Type: application/json

//Format of Expected Data: JSON Object with the properties:
//Name, Strasse, Ort-Id, Telefon, Bestellpositionen
//Where Bestellpositionen is an Array of Objects with the properties:
//Pizza-Id, Groesse

//Example of valid, expected JSON:
/*
{
	"Name": "Benjamin Brandtner",
	"Strasse": "Am Königsberg 7",
	"Ort-Id": 1,
	"Telefon": "0931 672843",
	"Bestellpositionen":
	[
		{
			"Pizza-Id": 1,
			"Groesse": 32
		},
		{
			"Pizza-Id": 4,
			"Groesse": 32
		}
	]
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

$inputText = file_get_contents("php://input");
$order = json_decode($inputText, true);

$answer = new stdClass();
$answerJson;

if(is_null($order))
{
	//JSON could not be parsed

	$answer->Success = false;
	$answer->ErrorMessage = json_last_error_msg();

	$answerJson = json_encode($answer);
}
elseif(false)
{
	//TODO: Check if all necessary properties are there, if they're the right datatype, etc.
	//if something's wrong, send Error Message
}
else
{
	//Recieved JSON is valid, INSERT into DB

	//TODO: INSERT into DB

	$answer->Success = false;
	$answer->ErrorMessage = "Ordering is not implemented yet.";

	$answerJson = json_encode($answer);
}

echo $answerJson;