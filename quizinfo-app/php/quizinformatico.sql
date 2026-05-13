USE quizinformatico;

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
SET time_zone = "+00:00";
/*!40101 SET NAMES utf8mb4 */;

CREATE TABLE IF NOT EXISTS `classifica` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `nome` varchar(256) NOT NULL,
  `punteggio` int(11) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

CREATE TABLE IF NOT EXISTS `domande` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `domanda` varchar(512) NOT NULL,
  `risposta1` varchar(256) NOT NULL,
  `risposta2` varchar(256) NOT NULL,
  `risposta3` varchar(256) NOT NULL,
  `risposta4` varchar(256) NOT NULL,
  `soluzione` int(11) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

TRUNCATE TABLE `domande`;

INSERT INTO `domande` (`domanda`, `risposta1`, `risposta2`, `risposta3`, `risposta4`, `soluzione`) VALUES
-- RETI
('Quale dei seguenti è un protocollo di livello applicazione nel modello OSI?', 'TCP', 'IP', 'HTTP', 'Ethernet', 3),
('In quale livello del modello OSI opera il protocollo IP?', 'Livello 2 - Data Link', 'Livello 3 - Rete', 'Livello 4 - Trasporto', 'Livello 1 - Fisico', 2),
('Cosa indica la subnet mask 255.255.255.0?', 'Una rete di classe A', 'Una rete con 254 host utilizzabili', 'Una rete con 65534 host utilizzabili', 'Una rete senza host', 2),
('Qual è la differenza principale tra TCP e UDP?', 'TCP è più veloce di UDP', 'UDP garantisce la consegna, TCP no', 'TCP garantisce la consegna affidabile, UDP no', 'TCP lavora solo su reti locali', 3),
('Che cos''è un indirizzo MAC?', 'Un indirizzo logico assegnato dal router', 'Un indirizzo fisico univoco della scheda di rete', 'Un indirizzo IP privato', 'Un identificatore del sistema operativo', 2),
('Quale dispositivo opera al livello 3 del modello OSI?', 'Hub', 'Switch', 'Router', 'Ripetitore', 3),
('Cosa significa NAT nelle reti?', 'Network Access Token', 'Network Address Translation', 'Node Assignment Table', 'Network Analysis Tool', 2),
('Qual è il range degli indirizzi IP privati della classe C?', '10.0.0.0 - 10.255.255.255', '172.16.0.0 - 172.31.255.255', '192.168.0.0 - 192.168.255.255', '127.0.0.0 - 127.255.255.255', 3),
('Il protocollo DHCP serve a:', 'Risolvere nomi di dominio in IP', 'Assegnare automaticamente indirizzi IP ai dispositivi', 'Cifrare le comunicazioni di rete', 'Instradare i pacchetti tra reti diverse', 2),
('Cos''è il DNS?', 'Un protocollo di sicurezza', 'Un servizio che traduce nomi di dominio in indirizzi IP', 'Un tipo di firewall', 'Un protocollo di routing', 2),
('Quale porta usa di default il protocollo HTTPS?', '80', '21', '443', '8080', 3),
('In una topologia a stella, se il nodo centrale si guasta:', 'Solo due nodi si disconnettono', 'L''intera rete smette di funzionare', 'La rete continua normalmente', 'Solo i nodi periferici si disconnettono', 2),
('Cosa indica il prefisso /24 in notazione CIDR come 192.168.1.0/24?', 'Il numero di host nella rete', 'I primi 24 bit sono la parte di rete', 'Ci sono 24 sottoreti', 'La rete ha 24 router', 2),
('Qual è la porta di default del protocollo FTP?', '22', '25', '21', '110', 3),
('Cosa fa il comando traceroute/tracert?', 'Mostra le connessioni TCP attive', 'Verifica la disponibilità di un host', 'Mostra il percorso dei pacchetti verso un host', 'Assegna un indirizzo IP', 3),
-- SISTEMI OPERATIVI
('Cos''è il kernel di un sistema operativo?', 'L''interfaccia grafica del sistema', 'Il nucleo del SO che gestisce hardware e risorse', 'Il bootloader del sistema', 'Un tipo di file system', 2),
('Cosa fa uno scheduler in un sistema operativo?', 'Gestisce la memoria virtuale', 'Decide quale processo eseguire e per quanto tempo', 'Formatta il file system', 'Gestisce le connessioni di rete', 2),
('Cos''è la memoria virtuale?', 'Una RAM aggiuntiva fisica', 'Una tecnica che usa lo spazio su disco come estensione della RAM', 'Una cache del processore', 'Un tipo di memoria flash', 2),
('Quale algoritmo di scheduling assegna la CPU al processo con il burst time più breve?', 'FIFO', 'Round Robin', 'SJF (Shortest Job First)', 'Priority Scheduling', 3),
('Cos''è un deadlock in informatica?', 'Un errore di compilazione', 'Una situazione in cui due o più processi si bloccano aspettando risorse a vicenda', 'Un tipo di malware', 'Un crash del kernel', 2),
('Cosa significa RAID 1?', 'Striping dei dati senza ridondanza', 'Mirroring: i dati sono duplicati su due dischi', 'Striping con parità distribuita', 'Nessuna ridondanza, solo prestazioni', 2),
('In un sistema a 32 bit, qual è lo spazio di indirizzamento massimo della RAM?', '2 GB', '4 GB', '8 GB', '16 GB', 2),
-- DATABASE
('Cosa si intende per chiave primaria in un database relazionale?', 'Un campo che può contenere valori NULL', 'Un campo che identifica univocamente ogni record di una tabella', 'Una tabella di collegamento tra due relazioni', 'Un indice secondario', 2),
('Cosa fa il comando SQL SELECT?', 'Inserisce nuovi dati nella tabella', 'Elimina record dalla tabella', 'Recupera dati da una o più tabelle', 'Modifica la struttura di una tabella', 3),
('Cosa si intende per JOIN in SQL?', 'Unire due database distinti', 'Combinare righe di due o più tabelle in base a una condizione', 'Creare una nuova tabella', 'Eliminare record duplicati', 2),
('Quale forma normale elimina le dipendenze parziali?', 'Prima Forma Normale (1NF)', 'Seconda Forma Normale (2NF)', 'Terza Forma Normale (3NF)', 'Forma Normale di Boyce-Codd', 2),
('Cos''è una foreign key?', 'Una chiave cifrata', 'Un campo che fa riferimento alla chiave primaria di un''altra tabella', 'Un indice unico su più colonne', 'Un campo con valore di default', 2),
('Cosa fa il comando SQL GROUP BY?', 'Ordina i record in ordine crescente', 'Raggruppa i record con valori uguali in un campo specificato', 'Filtra i gruppi con una condizione', 'Unisce due tabelle', 2),
('Cosa significa ACID nelle transazioni di un database?', 'Atomicity, Consistency, Isolation, Durability', 'Availability, Consistency, Integrity, Durability', 'Atomicity, Concurrency, Integrity, Data', 'Availability, Concurrency, Isolation, Data', 1),
('Qual è la differenza tra DELETE e TRUNCATE in SQL?', 'Non c''è differenza', 'DELETE rimuove righe selezionabili, TRUNCATE svuota l''intera tabella velocemente', 'TRUNCATE può usare WHERE, DELETE no', 'DELETE non logga le operazioni', 2),
-- PROGRAMMAZIONE
('Qual è la complessità temporale della ricerca binaria?', 'O(n)', 'O(n²)', 'O(log n)', 'O(1)', 3),
('Cosa fa una funzione ricorsiva?', 'Un ciclo che non termina mai', 'Una funzione che chiama se stessa', 'Un tipo di array multidimensionale', 'Un pattern di progettazione', 2),
('La complessità del bubble sort nel caso peggiore è:', 'O(n log n)', 'O(n)', 'O(n²)', 'O(log n)', 3),
('Cos''è una struttura dati stack?', 'Una lista con inserimento e rimozione da entrambi i lati', 'Una struttura LIFO: l''ultimo inserito è il primo ad uscire', 'Una struttura FIFO: il primo inserito è il primo ad uscire', 'Un array associativo', 2),
('In OOP, cosa si intende per ereditarietà?', 'La capacità di un oggetto di cambiare comportamento a runtime', 'Il meccanismo per cui una classe acquisisce attributi e metodi da un''altra', 'La possibilità di avere più metodi con lo stesso nome', 'L''incapsulamento dei dati in un oggetto', 2),
('Cos''è il polimorfismo in OOP?', 'La capacità di definire classi astratte', 'La possibilità di trattare oggetti di classi diverse attraverso un''interfaccia comune', 'L''insieme di attributi privati di una classe', 'La creazione di oggetti da una classe', 2),
('Cosa si intende per API REST?', 'Un tipo di database NoSQL', 'Un''architettura per servizi web basata su HTTP e risorse', 'Un linguaggio di programmazione per il backend', 'Un protocollo di rete del livello 3', 2),
('Cosa fa il costrutto try-catch?', 'Ottimizza le prestazioni del codice', 'Gestisce le eccezioni che si verificano a runtime', 'Crea un nuovo thread di esecuzione', 'Esegue il codice in modo asincrono', 2),
-- SICUREZZA
('Cosa si intende per crittografia simmetrica?', 'Usa due chiavi diverse per cifrare e decifrare', 'Usa la stessa chiave per cifrare e decifrare', 'Non usa chiavi, solo algoritmi hash', 'Usa certificati digitali', 2),
('Cos''è un certificato SSL/TLS?', 'Un tipo di firewall', 'Un file che autentica l''identità di un server e abilita la cifratura', 'Un protocollo di routing sicuro', 'Un tipo di VPN', 2),
('Cosa si intende per SQL Injection?', 'Un errore di sintassi SQL', 'Un attacco che inserisce codice SQL malevolo in input non validati', 'Un metodo per ottimizzare le query', 'Un tipo di backup del database', 2),
('Cosa fa un firewall?', 'Accelera la connessione internet', 'Monitora e filtra il traffico di rete in base a regole definite', 'Cifra automaticamente tutti i dati', 'Gestisce gli indirizzi IP della rete', 2),
('Cosa si intende per autenticazione a due fattori (2FA)?', 'Due password diverse', 'Un sistema che richiede due forme distinte di verifica identità', 'Un doppio firewall', 'Un certificato digitale doppio', 2);

COMMIT;
