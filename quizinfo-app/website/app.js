/* ─── Navigation ─────────────────────────────────────── */
function startButton()        { window.location.href = "accesso.html"; }
function visualizzaClassifica(){ window.location.href = "classifica.html"; }
function ritornaHome()         { window.location.href = "index.html"; }

function cominciaDomande() {
    const nome = document.getElementById("nome").value.trim();
    if (!nome) { showAlert("Inserisci il tuo nome prima di continuare!"); return; }
    localStorage.setItem("nomeUtente", nome);
    window.location.href = "quiz.html";
}

function showAlert(msg) {
    const el = document.getElementById("alertMsg");
    if (el) { el.textContent = msg; el.classList.add("show"); setTimeout(() => el.classList.remove("show"), 3000); }
    else alert(msg);
}

/* ─── Quiz logic (quiz.html only) ───────────────────── */
window.onload = async function () {
    /* ── classifica.html ── */
    const tabellaBody=document.getElementById("classificaBody");
    if (tabellaBody){
        const loading=document.getElementById("loadingMsg");
        try {
            const res=await fetch("http://localhost:8080/getclassifica.php");
            const dati=await res.json();
            if (loading) loading.remove();
            if (dati.length===0) {
                tabellaBody.innerHTML='<tr><td colspan="3" style="text-align:center;opacity:.6">Nessun risultato ancora</td></tr>';
            } else {
                dati.forEach((riga, i)=>{
                    const tr= document.createElement("tr");
                    const medal= i===0 ? "🥇" : i===1 ? "🥈" : i===2 ? "🥉" : (i+1);
                    tr.innerHTML = `<td>${medal}</td><td>${riga.nome}</td><td>${riga.punteggio}</td>`;
                    tabellaBody.appendChild(tr);
                });
            }
        } catch(err) {
            if (loading) loading.textContent = "Errore nel caricamento della classifica.";
            console.error("Errore classifica:", err);
        }
        return;
    }

    /* ── quiz.html ── */
    const domandaEl= document.getElementById("domanda");
    if (!domandaEl) return;
    let domande= [], current=0, punteggio=0, tempo=15, timer;

    const form= document.getElementById("form");
    const radio= document.querySelectorAll("input[name='risposta']");
    const punteggioEl= document.getElementById("punteggio");
    const tempoEl= document.getElementById("tempo");
    const timerBar= document.getElementById("timerBar");
    const progressEl= document.getElementById("progress");
    const r0= document.getElementById("r0");
    const r1= document.getElementById("r1");
    const r2= document.getElementById("r2");
    const r3= document.getElementById("r3");
    const labels= document.querySelectorAll(".option-label");

    async function caricaDomande(){
        try{
            const res= await fetch("http://localhost:8080/domande.php");
            const text= await res.text();
            try{
                domande= JSON.parse(text);
            }catch(e){
                console.error("Risposta NON JSON:", text); return; 
            }
            mostraDomanda();
        }catch(err){
            console.error("Errore fetch:", err); 
        }
    }
    function mostraDomanda(){
        if(!domande||domande.length===0) return;
        if(current>=domande.length){
            fineQuiz(); return;
        }
        // Reset styles
        labels.forEach(l=> {
            l.classList.remove("correct","wrong","selected"); 
        });
        radio.forEach(r=>{
            r.checked = false; r.disabled = false;
        });
        document.getElementById("submitBtn").disabled = false;

        const d=domande[current];
        domandaEl.textContent=d.domanda;
        r0.textContent=d.risposta1;
        r1.textContent=d.risposta2;
        r2.textContent=d.risposta3;
        r3.textContent=d.risposta4;
        if (progressEl) progressEl.textContent=`${current+1}/${domande.length}`;
        startTimer();
    }
    function startTimer(){
        tempo=15;
        updateTimerUI();
        clearInterval(timer);
        timer=setInterval(()=>{
            tempo--;
            updateTimerUI();
            if (tempo <= 0) {
                clearInterval(timer); submitAnswer();
            }
        },1000);
    }

    function updateTimerUI(){
        if(tempoEl) tempoEl.textContent=tempo;
        if(timerBar){
            const pct= (tempo/15)*100;
            timerBar.style.width=pct+"%";
            timerBar.className= "timer-fill"+(pct<=33 ? " danger" : pct<=60 ? " warning":"");
        }
    }

    function submitAnswer(){
        if (!domande||!domande[current]) return;
        clearInterval(timer);
        document.getElementById("submitBtn").disabled = true;
        radio.forEach(r =>
            r.disabled = true
        );
        let scelta = -1;
        radio.forEach((r, i)=>{
            if (r.checked) scelta = i + 1; 
        });
        const corretta=domande[current].soluzione;
        // Highlight correct / wrong
        labels.forEach((l, i)=>{
            if (i + 1 === corretta) l.classList.add("correct");
            else if (i + 1 === scelta) l.classList.add("wrong");
        });

        if(scelta === corretta) punteggio++;
        if(punteggioEl) punteggioEl.textContent=punteggio;

        setTimeout(()=>{
            current++; mostraDomanda(); 
        },1000);
    }
    form.addEventListener("submit", function(e){
        e.preventDefault(); submitAnswer();
    });
    async function fineQuiz() {
        clearInterval(timer);
        const nome = localStorage.getItem("nomeUtente") || "Anonimo";
        document.body.innerHTML = `
        <div class="end-screen">
            <div class="end-card">
                <div class="trophy">${punteggio >= domande.length * 0.8 ? "🏆" : punteggio >= domande.length * 0.5 ? "🎯" : "📚"}</div>
                <h1>Quiz completato!</h1>
                <p class="player-name">${nome}</p>
                <div class="score-display">
                    <span class="score-num">${punteggio}</span>
                    <span class="score-sep">/</span>
                    <span class="score-total">${domande.length}</span>
                </div>
                <p class="score-label">${getLabel(punteggio, domande.length)}</p>
                <button class="btn-primary" id="btnSalva">Salva e vai alla classifica</button>
                <button class="btn-secondary" onclick="ritornaHome()">Torna alla home</button>
            </div>
        </div>`;
        document.getElementById("btnSalva").addEventListener("click", async()=>{
            try {
                await fetch("http://localhost:8080/classifica.php",{
                    method: "POST",
                    headers: {"Content-Type": "application/json"},
                    body: JSON.stringify({nome,punteggio})
                });
                visualizzaClassifica();
            }catch(err){
                console.error(err); visualizzaClassifica(); 
            }
        });
    }

    function getLabel(p, tot){
        const r= p/tot;
        if(r === 1)return "Perfetto! Sei un mago dell'informatica 🌟";
        if(r >= 0.8)return "Ottimo risultato! Sei sulla strada giusta 💪";
        if(r >= 0.6)return "Buono! Ripassia qualche argomento 📖";
        if(r >= 0.4)return "Sufficiente. Studia ancora un po' 🔍";
        return "Continua a studiare, ce la farai! 💡";
    }
    caricaDomande();
};
