USE quizinformatico;
-- phpMyAdmin SQL Dump
-- version 5.2.1
-- https://www.phpmyadmin.net/
--
-- Host: 127.0.0.1
-- Creato il: Apr 18, 2026 alle 08:29
-- Versione del server: 10.4.32-MariaDB
-- Versione PHP: 8.2.12

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Database: `quizinformatico`
--

-- --------------------------------------------------------

--
-- Struttura della tabella `classifica`
--

CREATE TABLE `classifica` (
  `id` int(11) NOT NULL,
  `nome` varchar(256) NOT NULL,
  `punteggio` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Struttura della tabella `domande`
--

CREATE TABLE `domande` (
  `id` int(11) NOT NULL,
  `domanda` varchar(256) NOT NULL,
  `risposta1` varchar(256) NOT NULL,
  `risposta2` varchar(256) NOT NULL,
  `risposta3` varchar(256) NOT NULL,
  `risposta4` varchar(256) NOT NULL,
  `soluzione` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dump dei dati per la tabella `domande`
--

INSERT INTO `domande` (`id`, `domanda`, `risposta1`, `risposta2`, `risposta3`, `risposta4`, `soluzione`) VALUES
(1, 'Quale componente del computer elabora le informazioni?', 'RAM', 'CPU', 'Disco Fisso', 'Scheda Video', 2),
(2, 'Cosa significa l\'acronimo HTML?', 'HyperText Markup Language', 'HyperTabular Markup Language', 'HighText Machine Language', 'HyperText Management Language', 1),
(3, 'Quale di questi è un dispositivo di memoria temporanea?', 'Penna USB', 'SSD', 'Hard Disk', 'RAM', 4),
(4, 'Cosa fa un antivirus?', 'Aumenta la velocità del PC', 'Installa nuovi programmi', 'Copia i file', 'Rimuove virus dal computer', 4),
(5, 'Cos’è un file?', 'Un programma', 'Una cartella', 'Un insieme di dati memorizzati su un computer', 'Un icona del desktop', 3),
(6, 'Qual è il simbolo usato per rappresentare l’indirizzo web di un sito?', '#', 'www.', '@', '.it', 2),
(7, 'Cos’è un link?', 'Una pagina web', 'Un collegamento ipertestuale', 'Un file', 'Una stampante', 2),
(8, 'Cosa significa \"download\"?', 'Salvare file dal computer su internet', 'Trasferire file da internet al computer', 'Convertire un file in un\'immagine', 'Stampare un documento', 2),
(9, 'Che cosa fa il tasto \"Enter\" sulla tastiera?', 'Annulla un’operazione', 'Apre il menu start', 'Copia e incolla un testo', 'Conclude una riga di testo o lancia un comando', 4),
(10, 'Quale tra questi serve per ascoltare la musica sul computer?', 'Monitor', 'Mouse', 'Altoparlanti', 'Tastiera', 3);

--
-- Indici per le tabelle scaricate
--

--
-- Indici per le tabelle `classifica`
--
ALTER TABLE `classifica`
  ADD PRIMARY KEY (`id`);

--
-- Indici per le tabelle `domande`
--
ALTER TABLE `domande`
  ADD PRIMARY KEY (`id`);

--
-- AUTO_INCREMENT per le tabelle scaricate
--

--
-- AUTO_INCREMENT per la tabella `classifica`
--
ALTER TABLE `classifica`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT per la tabella `domande`
--
ALTER TABLE `domande`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=11;
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
