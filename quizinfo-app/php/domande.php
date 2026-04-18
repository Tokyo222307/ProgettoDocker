<?php
header("Access-Control-Allow-Origin: http://localhost:8081");
header("Access-Control-Allow-Headers: Content-Type");
header("Access-Control-Allow-Methods: GET, POST, OPTIONS");
header("Content-Type: application/json; charset=UTF-8");

$host = "mysql";
$user = "root";
$password = "root";
$database = "quizinformatico";
$conn = new mysqli($host, $user, $password, $database);

if ($conn->connect_error) {
    http_response_code(500);
    echo json_encode(["errore" => "Errore connessione DB"]);
    exit;
}

$sql = "SELECT id, domanda, risposta1, risposta2, risposta3, risposta4, soluzione FROM domande";
$result = $conn->query($sql);
if (!$result) {
    http_response_code(500);
    echo json_encode(["errore" => "Errore query"]);
    exit;
}

$domande = [];

while ($row = $result->fetch_assoc()) {
    $domande[] = [
        "id" => (int)$row["id"],
        "domanda" => $row["domanda"],
        "risposta1" => $row["risposta1"],
        "risposta2" => $row["risposta2"],
        "risposta3" => $row["risposta3"],
        "risposta4" => $row["risposta4"],
        "soluzione" => (int)$row["soluzione"]
    ];
}

echo json_encode($domande, JSON_UNESCAPED_UNICODE);

$conn->close();