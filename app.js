function startButton(){
    window.location.href="accesso.html";
}
function cominciaDomande(){
    window.location.href="quiz.html";
}
function visualizzaClassifica(){
    window.location.href="classifica.html";
}
function ritornaHome(){
    window.location.href="index.html";
}

window.onload = async function () {
    let domande = [];
    let current = 0;
    let punteggio = 0;
    let tempo = 10;
    let timer;
    const domandaEl = document.getElementById("domanda");
    const form = document.getElementById("form");
    const radio = document.querySelectorAll("input[name='risposta']");
    const punteggioEl = document.getElementById("punteggio");
    const tempoEl = document.getElementById("tempo");
    const r0 = document.getElementById("r0");
    const r1 = document.getElementById("r1");
    const r2 = document.getElementById("r2");
    const r3 = document.getElementById("r3");
    async function caricaDomande() {
        const res = await fetch("http://localhost:8080/domande");
        domande = await res.json();
        mostraDomanda();
    }
    function mostraDomanda() {
        if (current >= domande.length) {
            fineQuiz();
            return;
        }
        const d = domande[current];
        domandaEl.innerHTML = "<b>Domanda:</b> " + d.domande;
        r0.textContent = d.risposta1;
        r1.textContent = d.risposta2;
        r2.textContent = d.risposta3;
        r3.textContent = d.risposta4;
        radio.forEach(r => r.checked = false);
        startTimer();
    }
    function startTimer() {
        tempo = 10;
        tempoEl.textContent = "Tempo: " + tempo + " sec";
        clearInterval(timer);
        timer = setInterval(() => {
            tempo--;
            tempoEl.textContent = "Tempo: " + tempo + " sec";
            if (tempo <= 0) {
                clearInterval(timer);
                current++;
                mostraDomanda();
            }
        }, 1000);
    }
    form.addEventListener("submit", function (e) {
        e.preventDefault();
        let scelta = -1;
        radio.forEach((r, i) => {
            if (r.checked) scelta = i + 1; // DB parte da 1
        });
        if (scelta === domande[current].soluzione) {
            punteggio++;
        }
        punteggioEl.textContent = "Punteggio: " + punteggio;
        clearInterval(timer);
        current++;
        mostraDomanda();
    });
    async function fineQuiz() {
        clearInterval(timer);
        document.body.innerHTML = `
            <h1>Fine quiz!</h1>
            <h2>Punteggio: ${punteggio}</h2>
            <input id="nome" placeholder="Inserisci nome">
            <button id="salva">Salva in classifica</button>
            <button onclick="visualizzaClassifica()">Vai alla classifica</button>
        `;
        document.getElementById("salva").addEventListener("click", async () => {
            const nome = document.getElementById("nome").value;
            await fetch("http://localhost:8080/classifica", {
                method: "POST",
                headers: { "Content-Type": "application/json" },
                body: JSON.stringify({
                    nome: nome,
                    punteggio: punteggio
                })
            });
            alert("Punteggio salvato!");
            visualizzaClassifica();
        });
    }
    caricaDomande();
};