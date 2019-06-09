<?php
require_once("connect.php");
require_once("classes/Employee.php");

$employee = retrieveEmployee($_POST["inputName"]);

if (password_verify($_POST["inputPassword"], $employee->Pwhash))
{
	if (intval($employee->Stelle) == 1) //Cook
	{
		setcookie("Id", "$employee->Id", null, '/');
		setcookie("Name", $employee->Name, null, '/');
		setcookie("Stelle", $employee->Stelle, null, '/');
		header("Location: ../html/personal/koeche.html");

		die();
	}
	elseif (intval($employee->Stelle) == 2) //Deliverymen
	{
		setcookie("Id", "$employee->Id", null, '/');
		setcookie("Name", $employee->Name, null, '/');
		setcookie("Stelle", $employee->Stelle, null, '/');
		header("Location: ../html/personal/lieferanten.html");

		die();
	}

	die("Ungültige Stelle");
}

function retrieveEmployee($username)
{
	$pdo = PdoSingleton::getInstance();
	$statement = $pdo->prepare("SELECT * FROM angestellte WHERE Name = ?");
	$statement->execute([$username]);
	$statement->setFetchMode(PDO::FETCH_CLASS, "Employee", []);
	return $statement->fetch();
}
