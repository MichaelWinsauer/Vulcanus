<?php
class PdoSingleton
{
    static $pdo;

    static function getInstance()
    {
        if (self::$pdo == null)
        {
            self::$pdo = new PDO("mysql:host=localhost;dbname=fi2017_gruppe1_projekt2_brandtnerduererwinsauer;charset=utf8", "root", "");
        }

        return self::$pdo;
    }
}

//Test
// $pdo = PdoSingleton::getInstance();

// $statement = $pdo->prepare("SELECT * FROM `Pizza`");
// $statement->execute();
// $angestellte = $statement->fetchAll(PDO::FETCH_NUM);

// echo json_encode($angestellte);