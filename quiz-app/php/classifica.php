<?php
    header("Access-Control-Allow-Origin: *");
    header("Access-Control-Allow-Headers: Content-Type");
    header("Access-Control-Allow-Methods: POST, OPTIONS");
    header("Content-Type: application/json");

    if($_SERVER["REQUEST_METHOD"]==="OPTIONS"){
        http_response_code(204);
        exit;
    }

    if ($_SERVER["REQUEST_METHOD"] !== "POST"){
        http_response_code(405);
        echo json_encode(["errore" => "Metodo non consentito"]);
        exit;
    }

    $conn=new mysqli("mysql", "root", "root", "quizinformatico");
    if($conn->connect_error){
        http_response_code(500);
        echo json_encode(["errore" => $conn->connect_error]);
        exit;
    }
    $data = json_decode(file_get_contents("php://input"), true);
    if(!isset($data["nome"]) || !isset($data["punteggio"])){
        http_response_code(400);
        echo json_encode(["errore" => "Dati mancanti"]);
        exit;
    }
    $stmt = $conn->prepare("INSERT INTO classifica (nome, punteggio) VALUES (?, ?)");
    $stmt->bind_param("si", $data["nome"], $data["punteggio"]);
    $stmt->execute();
    $stmt->close();
    echo json_encode(["ok" => true]);
    $conn->close();