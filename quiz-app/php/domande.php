<?php
    header("Access-Control-Allow-Origin: *");
    header("Content-Type: application/json");
    $conn = new mysqli("mysql", "root", "root", "quizinformatico");
    if($conn->connect_error){
        http_response_code(500);
        echo json_encode(["errore" => $conn->connect_error]);
        exit;
    }
    $result = $conn->query("SELECT id, domande, risposta1, risposta2, risposta3, risposta4, soluzione FROM domande");
    if(!$result){
        http_response_code(500);
        echo json_encode(["errore" => $conn->error]);
        exit;
    }
    $domande=[];
    while($row=$result->fetch_assoc()){
        $domande[]=[
            "id"=> (int)$row["id"],
            "domande"=> $row["domande"],
            "risposta1"=> $row["risposta1"],
            "risposta2"=> $row["risposta2"],
            "risposta3"=> $row["risposta3"],
            "risposta4"=> $row["risposta4"],
            "soluzione"=> (int)$row["soluzione"]
        ];
    }
    echo json_encode($domande);
    $conn->close();