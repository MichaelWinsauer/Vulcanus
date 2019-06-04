<?php
//Retrieve list of Vulcanus-locations

//Method: GET

//Format of returned JSON: Array of Objects, where each Object has the properties:
//Id, PLZ, Ortsname

//Example of returned JSON:
/*
[
   {
      "Id":"1",
      "PLZ": "97070",
      "Ort":"Würzburg"
   },
   {
      "Id":"2",
      "PLZ": "57072",
      "Ort":"Siegen"
   }
]
*/

require_once("../connect.php");

$pdo = PdoSingleton::getInstance();

$statement = $pdo->prepare("SELECT * FROM `Ort`");
$statement->execute();
$result = $statement->fetchAll(PDO::FETCH_ASSOC);

echo json_encode($result);