<?php
//Retrieve vKoeche in JSON encoded format

//Method: GET

//Example of returned JSON
/*
[  
   {  
      "BestellID":"1",
      "BestellpositionID":"1",
      "Pizza":"Margherita",
      "Groesse":"32",
      "Rezept":"Emmentaler",
      "Backzeit":"12",
      "Status":"Bestellung angenommen",
      "Koch":null
   },
   {  
      "BestellID":"1",
      "BestellpositionID":"6",
      "Pizza":"Peperoni",
      "Groesse":"32",
      "Rezept":"Pepperoni, Emmentaler",
      "Backzeit":"12",
      "Status":"Bestellung angenommen",
      "Koch":null
   }
]
*/

require_once("../connect.php");

$pdo = PdoSingleton::getInstance();

$statement = $pdo->prepare("SELECT * FROM `vKoeche`");
$statement->execute();
$result = $statement->fetchAll(PDO::FETCH_ASSOC);

echo json_encode($result);