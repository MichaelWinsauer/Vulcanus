<?php
//Retrieve vLieferanten in JSON encoded format

//Method: GET

//Example of returned JSON
/*
[
  {
    "BestellID": "1",
    "BestellpositionID": "6",
    "Pizza": "Peperoni",
    "Groesse": "32",
    "Name": "Benjamin Brandtner",
    "Strasse": "Am K\u00f6nigsberg 7",
    "Ort": "97070 W\u00fcrzburg",
    "Preis": "7,50 \u20ac",
    "Status": "Fertig gebacken",
    "Lieferant": null
  },
  {
    "BestellID": "3",
    "BestellpositionID": "3",
    "Pizza": "Margherita",
    "Groesse": "32",
    "Name": "Michael Winsauer",
    "Strasse": "W\u00fcrzburger Stra\u00dfe 56",
    "Ort": "57072 Siegen",
    "Preis": "7,00 \u20ac",
    "Status": "Wird ausgeliefert",
    "Lieferant": "Anne"
  }
]
*/

require_once("../connect.php");

$pdo = PdoSingleton::getInstance();

$statement = $pdo->prepare("SELECT * FROM `vLieferanten`");
$statement->execute();
$result = $statement->fetchAll(PDO::FETCH_ASSOC);

echo json_encode($result);