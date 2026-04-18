<?php
header("Access-Control-Allow-Origin: http://localhost:8081");
header("Access-Control-Allow-Headers: Content-Type");
header("Access-Control-Allow-Methods: GET, POST, OPTIONS");
header("Content-Type: application/json; charset=UTF-8");

if ($_SERVER["REQUEST_METHOD"] === "OPTIONS") {
    http_response_code(204);
    exit;
}

if ($_SERVER["REQUEST_METHOD"] !== "POST") {
    http_response_code(405);
    echo json_encode(["errore" => "Metodo non consentito"]);
    exit;
}

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

$data = json_decode(file_get_contents("php://input"), true);

if (!isset($data["nome"]) || !isset($data["punteggio"])) {
    http_response_code(400);
    echo json_encode(["errore" => "Dati mancanti"]);
    exit;
}

$nome = trim($data["nome"]);
$punteggio = (int)$data["punteggio"];

if ($nome === "") {
    http_response_code(400);
    echo json_encode(["errore" => "Nome vuoto"]);
    exit;
}

$stmt = $conn->prepare("INSERT INTO classifica (nome, punteggio) VALUES (?, ?)");

if (!$stmt) {
    http_response_code(500);
    echo json_encode(["errore" => "Errore prepare"]);
    exit;
}

$stmt->bind_param("si", $nome, $punteggio);

if (!$stmt->execute()) {
    http_response_code(500);
    echo json_encode(["errore" => "Errore execute"]);
    exit;
}

echo json_encode([
    "ok" => true,
    "nome" => $nome,
    "punteggio" => $punteggio
]);

$stmt->close();
$conn->close();