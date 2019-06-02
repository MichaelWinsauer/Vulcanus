<?php
//Retrieve vSpeisekarte in JSON encoded format

//Method: GET

//Format of returned JSON: Array of Objects, where each Object has the properties:
//Id, Pizza, Rezept, Schärfe, 28cm, 32cm

//Example of returned JSON:
/*
[
   {
      "Id":"1",
      "Pizza":"Margherita",
      "Rezept":"Emmentaler",
      "Schärfe":"0",
      "28cm":"6,00 €",
      "32cm":"7,00 €"
   },
   {
      "Id":"2",
      "Pizza":"Salami",
      "Rezept":"Salami, Emmentaler",
      "Schärfe":"1",
      "28cm":"6,50 €",
      "32cm":"7,50 €"
   }
]
*/

require_once("../connect.php");

$pdo = PdoSingleton::getInstance();

$statement = $pdo->prepare("SELECT * FROM `vSpeisekarte`");
$statement->execute();
$result = $statement->fetchAll(PDO::FETCH_ASSOC);

echo json_encode($result);