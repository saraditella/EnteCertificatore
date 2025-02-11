DROP DATABASE IF EXISTS entecertificatore;
CREATE DATABASE entecertificatore;
USE entecertificatore;

CREATE TABLE Candidato(
IDCandidato CHAR(5) PRIMARY KEY,
Nome VARCHAR(20) NOT NULL, 
Cognome VARCHAR(20) NOT NULL,
Email VARCHAR(35) NOT NULL,
DataNascita DATE NOT NULL,
CAP CHAR(10) NOT NULL,
Citta VARCHAR(20) NOT NULL,
Via VARCHAR(30) NOT NULL
);

CREATE TABLE Commissario (
IDCommissario CHAR(5) PRIMARY KEY,
Nome VARCHAR(20) NOT NULL,
Cognome VARCHAR(20) NOT NULL,
Email VARCHAR(35) NOT NULL
);

CREATE TABLE PaeseAssegnato (
NomePaese VARCHAR(20) PRIMARY KEY,
Continente VARCHAR(20) NOT NULL
);

CREATE TABLE Esame (
IDEsame CHAR(5) PRIMARY KEY,
DataEsame DATE NOT NULL,
NomeEsame VARCHAR(30) NOT NULL,
Livello VARCHAR(20) NOT NULL,
IDCommissario CHAR(5) NOT NULL,
DataValutazione DATE NOT NULL,
FOREIGN KEY (IDCommissario) REFERENCES Commissario(IDCommissario) ON UPDATE CASCADE ON DELETE CASCADE
);

CREATE TABLE Prova (
DataProva DATE NOT NULL,
IDEsame CHAR(5) NOT NULL,
IDCandidato CHAR(5) NOT NULL,
Risultato VARCHAR(20) NOT NULL,
PRIMARY KEY (DataProva, IDEsame, IDCandidato),
FOREIGN KEY (IDEsame) REFERENCES Esame(IDEsame) ON UPDATE CASCADE ON DELETE CASCADE,
FOREIGN KEY (IDCandidato) REFERENCES Candidato(IDCandidato) ON UPDATE CASCADE ON DELETE CASCADE
);

CREATE TABLE AttestatodiCertificazione (
DataRilascio DATE,
IDEsame CHAR(5) NOT NULL,
Descrizione TEXT,
Punteggio INT NOT NULL CHECK (Punteggio BETWEEN 0 AND 100),
Commenti TEXT,
PRIMARY KEY (DataRilascio, IDEsame),
FOREIGN KEY (IDEsame) REFERENCES Esame(IDEsame) ON UPDATE CASCADE
);

CREATE TABLE EsameTeorico (
IDEsame CHAR(5) PRIMARY KEY,
TempoLimite TIME NOT NULL,
FOREIGN KEY (IDEsame) REFERENCES Esame(IDEsame) ON UPDATE CASCADE ON DELETE CASCADE
);

CREATE TABLE EsamePratico (
IDEsame CHAR(5) PRIMARY KEY,
Strumento VARCHAR(20) NOT NULL,
DurataPerformance TIME NOT NULL,
FOREIGN KEY (IDEsame) REFERENCES Esame(IDEsame) ON UPDATE CASCADE ON DELETE CASCADE
);

CREATE TABLE Assegnazione (
IDCommissario CHAR(5),
NomePaese VARCHAR(20),
DataAssegnazione DATE,
PRIMARY KEY (IDCommissario, NomePaese, DataAssegnazione),
FOREIGN KEY (NomePaese) REFERENCES PaeseAssegnato(NomePaese) ON UPDATE CASCADE ON DELETE CASCADE,
FOREIGN KEY (IDCommissario) REFERENCES Commissario(IDCommissario) ON UPDATE CASCADE ON DELETE CASCADE
);

CREATE VIEW ConteggioEsamiPerCommissario AS
SELECT E.IDCommissario, COUNT(*) AS NumeroEsami
FROM Esame E 
GROUP BY E.IDCommissario;


INSERT INTO Candidato VALUES 
(13201, 'Sara', 'Di Tella', 'saraditella5@gmail.com', '2001-02-05', '84126', 'Salerno', 'Via Calata San Vito 11'),
(13202, 'Francesco', 'Palmieri', 'francesco.palmieri@gmail.com', '1996-03-14', '84125', 'Salerno', 'Via Crispi 11'),
(13203, 'Carlos', 'García', 'carlos.garcia@gmail.com', '1985-03-12', '28001', 'Madrid', 'Calle Mayor 10'),
(13204, 'María', 'Fernández', 'maria.fernandez@gmail.com', '1990-07-22', '08002', 'Barcellona', 'Avenida de la Constitución 25'),
(13205, 'Hans', 'Müller', 'hans.mueller@gmail.com', '1978-11-05', '10115', 'Berlino', 'Hauptstraße 15'),
(13206, 'Anna', 'Schmidt', 'anna.schmidt@gmail.com', '1982-04-18', '80331', 'Monaco di Baviera', 'Bahnhofstraße 20'),
(13207, 'Yuki', 'Tanaka', 'yuki.tanaka@gmail.com', '1995-09-30', '150-0001', 'Tokyo', '1-2-3 Shibuya'),
(13208, 'Sofia', 'Bianchi', 'sofia.bianchi@gmail.com', '1988-12-14', '20121', 'Milano', 'Via Roma 10'),
(13209, 'John', 'Smith', 'john.smith@gmail.com', '1975-06-25', '10001', 'New York', '123 Main Street'),
(13210, 'Marie', 'Dubois', 'marie.dubois@gmail.com', '1992-02-08', '75001', 'Parigi', '45 Rue de Rivoli'),
(13211, 'Arjun', 'Sharma', 'arjun.sharma@gmail.com', '1983-10-19', '400001', 'Mumbai', '56 MG Road'),
(13212, 'Peter', 'Becker', 'peter.becker@gmail.com', '1987-05-23', '50667', 'Colonia', 'Schulstraße 12'),
(13213, 'Laura', 'López', 'laura.lopez@outlook.com', '1986-01-15', '41001', 'Siviglia', 'Plaza del Sol 5'),
(13214, 'Antonio', 'Sánchez', 'antonio.sanchez@yahoo.com', '1993-04-27', '46001', 'Valencia', 'Calle de la Paz 12'),
(13215, 'Karl', 'Wagner', 'karl.wagner@yahoo.com', '1980-07-09', '20095', 'Amburgo', 'Gartenweg 3'),
(13216, 'Mia', 'Incerti', 'mia.incerti@gmail.com', '2001-02-15', '84222', 'Salerno', 'Via Garibaldi 4'),
(13217, 'Annie', 'Charlot', 'annie.charlot@gmail.com', '2002-02-18', '75201', 'Bordeaux', '47 Rue de Avignone');


INSERT INTO Commissario VALUES
(12001, 'Ludwig', 'Beethoven', 'ludwig.beethoven@gmail.com'),
(12002, 'Wolfgang', 'Mozart', 'wolfgang.mozart@gmail.com'),
(12003, 'Johann', 'Bach', 'johann.bach@gmail.com'),
(12004, 'Franz', 'Schubert', 'franz.schubert@gmail.com'),
(12005, 'Giuseppe', 'Verdi', 'giuseppe.verdi@gmail.com');

INSERT INTO PaeseAssegnato VALUES
('ITALIA', 'Europa'),
('SPAGNA', 'Europa'),
('GERMANIA', 'Europa'),
('GIAPPONE', 'Asia'),
('STATI UNITI', 'America'),
('FRANCIA', 'Europa'),
('INDIA', 'Asia');

INSERT INTO Esame VALUES
(11501, '2024-01-10', 'Prassi Esecutive Pianoforte', 'Avanzato', 12003, '2024-01-12'),
(11502, '2024-01-11', 'Musica d\'insieme Violino', 'Intermedio', 12004, '2024-01-13'),
(11503, '2024-01-12', 'Composizione', 'Avanzato', 12005, '2024-01-14'),
(11504, '2024-01-11', 'Prassi Esecutive Arpa', 'Base', 12004, '2024-01-13'),
(11505, '2024-01-10', 'Direzione d\'Orchestra', 'Avanzato', 12003, '2024-01-12'),
(11506, '2024-01-10', 'Armonia', 'Intermedio', 12003, '2024-01-12'),
(11507, '2024-06-15', 'Analisi Musicale', 'Avanzato', 12002, '2024-06-17'),
(11508, '2024-06-16', 'Tecniche di Improvvisazione', 'Intermedio', 12001, '2024-06-18'),
(11509, '2024-06-16', 'Prassi Esecutive Pianoforte', 'Base', 12004, '2024-06-18'),
(11510, '2024-06-17', 'Musicologia', 'Avanzato', 12004, '2024-06-19'),
(11511, '2024-06-17', 'Prassi Esecutive Violoncello', 'Intermedio', 12005, '2025-06-19'),
(11512, '2024-06-17', 'Prassi Esecutive Flauto', 'Base', 12003, '2025-06-19'),
(11513, '2024-09-22', 'Prassi Esecutive Pianoforte', 'Avanzato', 12003, '2024-09-24'),
(11514, '2024-09-23', 'Prassi Esecutive Pianoforte', 'Avanzato', 12004, '2024-09-25'),
(11515, '2024-09-23', 'Prassi Esecutive Pianoforte', 'Avanzato', 12003, '2024-09-25'),
(11516, '2024-09-23', 'Armonia', 'Intermedio', 12003, '2024-09-25'),
(11517, '2024-09-24', 'Prassi Esecutive Chitarra', 'Intermedio', 12002, '2024-09-26'),
(11518, '2024-09-24', 'Intonazione e Ritmica', 'Intermedio', 12004, '2024-09-26'),
(11519, '2024-09-25', 'Intonazione e Ritmica', 'Intermedio', 12004, '2024-09-27'),
(11520, '2024-09-26', 'Intonazione e Ritmica', 'Intermedio', 12004, '2024-09-28'),
(11521, '2024-09-26', 'Analisi Musicale', 'Avanzato', 12005, '2024-09-28');

INSERT INTO Prova VALUES
('2024-01-11', 11501, 13201, 'Non superato'),
('2024-01-11', 11502, 13203, 'Superato'),
('2024-01-12', 11503, 13209, 'Superato'),
('2024-01-11', 11504, 13214, 'Superato'),
('2024-01-11', 11505, 13204, 'Superato'),
('2024-01-10', 11506, 13202, 'Non superato'),
('2024-06-15', 11507, 13207, 'Superato'),
('2024-06-16', 11508, 13211, 'Superato'),
('2024-06-17', 11509, 13206, 'Superato'),
('2024-06-17', 11510, 13205, 'Superato'),
('2024-06-17', 11511, 13210, 'Superato'),
('2024-06-17', 11512, 13208, 'Superato'),
('2024-09-22', 11513, 13201, 'Superato'),
('2024-09-23', 11514, 13213, 'Superato'),
('2024-09-23', 11515, 13214, 'Superato'),
('2024-09-23', 11516, 13202, 'Superato'),
('2024-09-24', 11517, 13212, 'Superato'),
('2024-09-24', 11518, 13215, 'Superato'),
('2024-09-25', 11519, 13216, 'Superato'),
('2024-09-26', 11520, 13217, 'Superato'),
('2024-09-26', 11521, 13201, 'Superato');



INSERT INTO AttestatodiCertificazione VALUES
('2024-02-05', 11502, 'Attestato di superamento dell\'esame "Musica d\'insieme Violino" di livello Intermedio, sostenuto da Carlos Garcia l\'11-01-2024', 87, 'Esecuzione impeccabile e interpretazione emozionante. Ottima padronanza tecnica.'),
('2024-02-05', 11503, 'Attestato di superamento dell\'esame "Composizione" di livello Avanzato, sostenuto da John Smith il 12-01-2024', 97, NULL),
('2024-02-05', 11504, 'Attestato di superamento dell\'esame "Prassi Esecutive Arpa" di livello Base, sostenuto da Antonio Sanchez l\'11-01-2024', 88, 'Esecuzione impeccabile e interpretazione emozionante. Ottima padronanza tecnica.'),
('2024-02-05', 11505, 'Attestato di superamento dell\'esame "Direzione d\'Orchestra" di livello Avanzato, sostenuto da Maria Fernandez l\'11-01-2024', 100, 'Solida conoscenza con una straordinaria comprensione delle dinamiche musicali'),
('2024-07-14', 11507, 'Attestato di superamento dell\'esame "Analisi Musicale" di livello Avanzato, sostenuto da Yuki Tanaka il 15-06-2024', 92, 'Solida conoscenza con una buona comprensione delle dinamiche musicali'),
('2024-07-14', 11508, 'Attestato di superamento dell\'esame "Tecniche di Improvvisazione" di livello Intermedio, sostenuto da Arjun Sharma il 16-06-2024', 65, 'Solida conoscenza con una buona comprensione delle dinamiche musicali'),
('2024-07-14', 11509, 'Attestato di superamento dell\'esame "Prassi Esecutive Pianoforte" di livello Base, sostenuto da Anna Schmidt il 17-06-2024', 99, 'Prestazione straordinaria con una comprensione profonda del repertorio.'),
('2024-07-14', 11510, 'Attestato di superamento dell\'esame "Musicologia" di livello Base, sostenuto da Hans Mueller il 17-06-2024', 76, 'Solida conoscenza con una buona comprensione delle dinamiche musicali.'),
('2024-07-14', 11511, 'Attestato di superamento dell\'esame "Prassi Esecutive Violoncello" di livello Intermedio, sostenuto da Marie Dubois il 17-06-2024', 72, 'Solida prestazione con una buona comprensione delle dinamiche musicali.'),
('2024-07-14', 11512, 'Attestato di superamento dell\'esame "Prassi Esecutive Flauto" di livello Base, sostenuto da Sofia Bianchi il 17-06-2024', 80, 'Buona esecuzione con solo lievi imprecisioni. Ottima interpretazione.'),
('2024-10-24', 11513, 'Attestato di superamento dell\'esame "Prassi Esecutive Pianoforte" di livello Avanzato, sostenuto da Sara Di Tella il 22-10-2024', 98, 'Prestazione straordinaria con una comprensione profonda del repertorio.'),
('2024-10-24', 11514, 'Attestato di superamento dell\'esame "Prassi Esecutive Pianoforte" di livello Avanzato, sostenuto da Laura Lopez il 23-10-2024', 100, 'Prestazione straordinaria con una comprensione profonda del repertorio.'),
('2024-10-24', 11515, 'Attestato di superamento dell\'esame "Prassi Esecutive Pianoforte" di livello Avanzato, sostenuto da Antonio Sanchez il 23-10-2024', 100, 'Prestazione straordinaria con una comprensione profonda del repertorio.'),
('2024-10-24', 11516, 'Attestato di superamento dell\'esame "Armonia" di livello Intermedio, sostenuto da Francesco Palmieri il 23-10-2024', 100, 'Solida conoscenza con una buona comprensione delle dinamiche musicali.'),
('2024-10-24', 11517, 'Attestato di superamento dell\'esame "Prassi Esecutive Chitarra" di livello Intermedio, sostenuto da Peter Becker il 24-10-2024', 99, 'Prestazione straordinaria con una comprensione profonda del repertorio.'),
('2024-10-24', 11518, 'Attestato di superamento dell\'esame "Intonazione e Ritmica" di livello Intermedio, sostenuto da Karl Wagner il 24-10-2024', 56, 'Discreta intonazione delle altezze musicali con necessità di miglioramento in alcune aree tecniche.'),
('2024-10-24', 11519, 'Attestato di superamento dell\'esame "Intonazione e Ritmica" di livello Intermedio, sostenuto da Mia Incerti il 25-10-2024', 66, 'Discreta intonazione delle altezze musicali con necessità di miglioramento in alcune aree tecniche.'),
('2024-10-24', 11520, 'Attestato di superamento dell\'esame "Intonazione e Ritmica" di livello Intermedio, sostenuto da Annie Charlot il 26-10-2024', 70, 'Buona intonazione delle altezze musicali con necessità di miglioramento in alcune aree tecniche.'),
('2024-10-24', 11521, 'Attestato di superamento dell\'esame "Analisi Musicale" di livello Avanzato, sostenuto da Sara Di Tella il 26-09-2024', 88, 'Solida conoscenza con una buona comprensione delle dinamiche musicali');

INSERT INTO EsameTeorico VALUES
(11503, '02:00:00'),
(11505, '00:20:00'),
(11506, '02:00:00'),
(11507, '02:00:00'),
(11508, '00:40:00'),
(11510, '02:00:00'),
(11516, '02:00:00'),
(11518, '00:25:00'),
(11519, '00:25:00'),
(11520, '00:25:00'),
(11521, '02:00:00');

INSERT INTO EsamePratico VALUES
(11501, 'Pianoforte', '00:20:00'),
(11502, 'Violino', '00:15:00'),
(11504, 'Arpa', '00:15:00'),
(11509, 'Pianoforte', '00:15:00'),
(11511, 'Violoncello', '00:20:00'),
(11512, 'Flauto', '00:15:00'),
(11513, 'Pianoforte', '00:40:00'),
(11514, 'Pianoforte', '00:40:00'),
(11515, 'Pianoforte', '00:40:00'),
(11517, 'Chitarra', '00:20:00');

INSERT INTO Assegnazione VALUES
(12001, 'INDIA', '2023-08-24'),
(12002, 'GIAPPONE', '2021-08-22'),
(12002, 'STATI UNITI', '2022-04-23'),
(12003, 'ITALIA', '2022-11-23'),
(12003, 'SPAGNA', '2021-08-22'),
(12004, 'SPAGNA', '2023-11-06'),
(12004, 'GERMANIA', '2020-04-13'),
(12004, 'ITALIA', '2024-09-25'),
(12004, 'FRANCIA', '2024-09-26'),
(12005, 'STATI UNITI', '2022-08-19'),
(12005, 'FRANCIA', '2023-04-07'),
(12005, 'ITALIA', '2023-04-06');