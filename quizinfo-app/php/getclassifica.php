<?php
header("Access-Control-Allow-Origin: http://localhost:8081");
header("Access-Control-Allow-Headers: Content-Type");
header("Access-Control-Allow-Methods: GET, OPTIONS");
header("Content-Type: application/json; charset=UTF-8");

if ($_SERVER["REQUEST_METHOD"] === "OPTIONS") {
    http_response_code(204);
    exit;
}

$host = "mysql";
$user = "user";
$password = "password";
$database = "quizinformatico";
$conn = new mysqli($host, $user, $password, $database);

if ($conn->connect_error) {
    http_response_code(500);
    echo json_encode(["errore" => "Errore connessione DB"]);
    exit;
}

$sql = "SELECT nome, punteggio FROM classifica ORDER BY punteggio DESC LIMIT 100";
$result = $conn->query($sql);

if (!$result) {
    http_response_code(500);
    echo json_encode(["errore" => "Errore query"]);
    exit;
}

$classifica = [];
while ($row = $result->fetch_assoc()) {
    $classifica[] = [
        "nome" => $row["nome"],
        "punteggio" => (int)$row["punteggio"]
    ];
}

echo json_encode($classifica, JSON_UNESCAPED_UNICODE);
$conn->close();
