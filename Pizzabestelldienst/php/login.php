<?php
	require_once("../connect.php");

	$pwHash = retrievePassword($_POST["inputName"]);

	if(password_verify($_POST["inputPassword"], $pwHash))
	{
		$employeeType = retrieveEmployeeType($_POST["inputName"]);
		$id = retrieveId($_POST["inputName"]);

		if(intval($employeeType) == 1)
		{
			setcookie("Id","$id");
			setcookie("Name",$_POST["inputName"]);
			header("Location: koeche.php");
		}
		else
		{
			setcookie("Id","$id");
			setcookie("Name",$_POST["inputName"]);
			header("Location: lieferanten.php");
		}
	}
	

function retrieveId($username)
{
	//sucht den Usernamen in der Datenbank, gibt das Passwort zurück
	$pdo = PdoSingleton::getInstance();
	$statement = $pdo->prepare("SELECT Id FROM angestellte WHERE Name = ?");
	$statement->execute([$username]);
	$row=$statement->fetch(PDO::FETCH_ASSOC);
	return $row["Id"]; //string
}

function retrievePassword($username)
{
	//sucht den Usernamen in der Datenbank, gibt das Passwort zurück
	$pdo = PdoSingleton::getInstance();
	$statement = $pdo->prepare("SELECT Pwhash FROM angestellte WHERE Name = ?");
	$statement->execute([$username]);
	$row=$statement->fetch(PDO::FETCH_ASSOC);
	return $row["Pwhash"]; //string
}

function retrieveEmployeeType($username)
{
	$pdo = PdoSingleton::getInstance();
	$statement = $pdo->prepare("SELECT Stelle FROM angestellte WHERE Name = ?");
	$statement->execute([$username]);
	$row=$statement->fetch(PDO::FETCH_ASSOC);
	return $row["Stelle"]; //string

}
?>