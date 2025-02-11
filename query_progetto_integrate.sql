-- Una selezione ordinata su un attributo di una tabella con condizioni AND e OR;
#1. Elencare i candidati che vivono a Salerno con CAP 84126 (IDCandidato, Nome, Cognome, Citta)
SELECT IDCandidato, Nome, Cognome, Citta
FROM Candidato
WHERE Citta = 'Salerno' AND CAP = 84126
ORDER BY Cognome ASC;

#2. Elencare i candidati che vivono a Salerno con CAP specifici (IDCandidato, Nome, Cognome, CAP, Citta):
SELECT IDCandidato, Nome, Cognome, CAP, Citta 
FROM Candidato
WHERE Citta = 'Salerno' AND (CAP = '84126' OR CAP = '84125')
ORDER BY Cognome ASC;

#3. Elencare gli esami di livello Avanzato o Intermedio, ordinati per data di esame (IDEsame, NomeEsame, Livello, DataEsame):
SELECT IDEsame, NomeEsame, Livello, DataEsame 
FROM Esame
WHERE Livello = 'Avanzato' OR Livello = 'Intermedio'
ORDER BY DataEsame ASC;

#4. Elencare i commissari con nome 'Ludwig' o 'Wolfgang', ordinati per cognome (IDCommissario, Nome, Cognome):
SELECT IDCommissario, Nome, Cognome 
FROM Commissario
WHERE Nome = 'Ludwig' OR Nome = 'Wolfgang'
ORDER BY Cognome ASC;

#5. Elencare le prove con risultato 'Superato' o 'Non superato', ordinate per data di prova (DataProva, IDEsame, IDCandidato, Risultato):
SELECT DataProva, IDEsame, IDCandidato, Risultato 
FROM Prova
WHERE Risultato = 'Superato' OR Risultato = 'Non superato'
ORDER BY DataProva ASC;

#6. Elencare i candidati con email che contengono 'gmail.com' e città 'Salerno', ordinati per nome (IDCandidato, Nome, Cognome, Email, Citta):
SELECT IDCandidato, Nome, Cognome, Email, Citta 
FROM Candidato
WHERE Email LIKE '%gmail.com%' AND Citta = 'Salerno'
ORDER BY Nome ASC;

#7. Elencare gli esami con data di valutazione specifica e livello Avanzato, ordinati per nome dell'esame (IDEsame, NomeEsame, Livello, DataValutazione):
SELECT IDEsame, NomeEsame, Livello, DataValutazione 
FROM Esame
WHERE DataValutazione = '2024-01-12' AND Livello = 'Avanzato'
ORDER BY NomeEsame ASC;

#8. Elencare i candidati nati prima del 1990 e che vivono a Milano, ordinati per data di nascita (IDCandidato, Nome, Cognome, DataNascita, Citta):
SELECT IDCandidato, Nome, Cognome, DataNascita, Citta 
FROM Candidato
WHERE DataNascita < '1990-01-01' AND Citta = 'Milano'
ORDER BY DataNascita ASC;





-- -----------------------------------------------------------------------------
-- Una selezione su due o più tabelle con condizioni;
#1. Elencare i candidati che hanno ottenuto un punteggio superiore a 90 in un esame pratico con il Pianoforte (Nome Candidato, Cognome Candidato, Strumento, Punteggio) 
SELECT C.Nome, C.Cognome, EP.Strumento, A.Punteggio
FROM Candidato C
JOIN Prova P ON C.IDCandidato = P.IDCandidato 
JOIN AttestatodiCertificazione A ON P.IDEsame = A.IDEsame
JOIN EsamePratico EP ON P.IDEsame = EP.IDEsame
WHERE A.Punteggio > 90 AND EP.Strumento = 'Pianoforte'; 

#2.Elencare i commissari assegnati all'Italia assieme alla data di assegnazione (Nome Commissario, Cognome Commissario, Nome Paese, Data Assegnazione)
SELECT CO.Nome, CO.Cognome, A.NomePaese, A.DataAssegnazione
FROM Commissario CO
JOIN Assegnazione A ON CO.IDCommissario = A.IDCommissario
WHERE A.NomePaese = 'Italia';

#3.Elencare i dettagli degli esami, inclusi i candidati e i risultati, per il livello Avanzato (Nome Esame, Livello, Nome Candidato, Cognome Candidato, Risultato)
SELECT E.NomeEsame, E.Livello, C.Nome, C.Cognome, P.Risultato
FROM Esame E
JOIN Prova P ON E.IDEsame = P.IDEsame
JOIN Candidato C ON P.IDCandidato = C.IDCandidato
WHERE E.Livello = 'Avanzato';





-- -----------------------------------------------------------------------------
-- Una selezione aggregata su tutti i valori (es. somma di tutti gli stipendi)
#1. Selezionare la media di tutti i punteggi degli attestati di certificazione
SELECT AVG(Punteggio) AS MediaPunteggi
FROM AttestatodiCertificazione;

#2. Calcolare il punteggio massimo e minimo delle certificazioni:
SELECT MAX(Punteggio) AS PunteggioMassimo, MIN(Punteggio) AS PunteggioMinimo
FROM AttestatodiCertificazione;

#3. Contare il numero totale di esami per ciascun commissario (IDCommissario, Numero Esami)
SELECT IDCommissario, COUNT(*) AS NumeroEsami
FROM Esame
GROUP BY IDCommissario;





-- -----------------------------------------------------------------------------
-- Una selezione aggregata su raggruppamenti (es. somma stipendi per dipartimenti)
#1. Selezionare per ogni livello la media dei punteggi degli esami (Nome esame, Livello, Punteggio)
SELECT E.NomeEsame, E.Livello, AVG(A.Punteggio) AS MediaPunteggio 
FROM Esame E 
JOIN AttestatodiCertificazione A ON E.IDEsame = A.IDEsame
GROUP BY E.NomeEsame, E.Livello
ORDER BY E.Livello, MediaPunteggio;





-- -----------------------------------------------------------------------------
-- Una selezione aggregata su raggruppamenti con condizioni (es. dipartimenti la cui somma degli stipendi dei dipendenti è > 100k)
#1. Selezionare i commissario con più di 2 esami assegnati (IDCommissario, Numero Esami)
SELECT E.IDCommissario, COUNT(*) AS NumeroEsami
FROM Esame E
GROUP BY E.IDCommissario
HAVING COUNT(*) > 2;

#2. Selezionare i paesi che hanno più di 1 assegnazioni (Nome Paese, Numero Assegnazioni)
SELECT A.NomePaese, COUNT(*) AS NumeroAssegnazioni
FROM Assegnazione A
GROUP BY A.NomePaese
HAVING COUNT(*) > 1; 





-- -----------------------------------------------------------------------------
-- Una selezione con operazioni insiemistiche
#1. Selezionare gli esami che si tengono a giugno ma non nel 2024 (IDEsame, NomeEsame, DataEsame)
SELECT E.IDEsame, E.NomeEsame, E.DataEsame
FROM Esame E
WHERE MONTH(E.DataEsame) = 6
EXCEPT
SELECT E1.IDEsame, E1.NomeEsame, E1.DataEsame
FROM Esame E1
WHERE YEAR(E1.DataEsame) = 2023;

SELECT E.IDEsame, E.NomeEsame, E.DataEsame
FROM Esame E
WHERE MONTH(E.DataEsame) = 6
AND E.IDEsame NOT IN (
    SELECT E.IDEsame
    FROM Esame E
    WHERE YEAR(E.DataEsame) = 2023
);

#2. Selezionare i candidati che hanno ottenuto un punteggio superiore a 80, ma non nel 2023 (Nome, Cognome, Punteggio, Risultato)
SELECT C.Nome, C.Cognome, A.Punteggio, P.Risultato
FROM Candidato C JOIN Prova P ON C.IDCandidato = P.IDCandidato
JOIN AttestatodiCertificazione A ON P.IDEsame = A.IDEsame
WHERE C.IDCandidato IN ( 
	SELECT P.IDCandidato
    FROM Prova P JOIN AttestatodiCertificazione A ON P.IDEsame = A.IDEsame 
    WHERE A.Punteggio > 80
    )
AND C.IDCandidato NOT IN (
	SELECT P.IDCandidato 
    FROM Prova P JOIN AttestatodiCertificazione A ON P.IDEsame = A.IDEsame
    WHERE A.Punteggio > 80 AND YEAR(A.DataRilascio) = 2023
    );
    
SELECT C.Nome, C.Cognome, A.Punteggio, P.Risultato
FROM Candidato C
JOIN Prova P ON C.IDCandidato = P.IDCandidato
JOIN AttestatodiCertificazione A ON P.IDEsame = A.IDEsame
WHERE A.Punteggio > 80
AND C.IDCandidato NOT IN (
    SELECT P.IDCandidato
    FROM Prova p
    JOIN AttestatodiCertificazione A ON P.IDEsame = A.IDEsame
    WHERE A.Punteggio > 80 AND YEAR(A.DataRilascio) = 2023
);

#3. Selezionare  i commissari che hanno valutato esami teorici e pratici in un determinato anno
SELECT E.IDCommissario 
FROM Esame E JOIN EsameTeorico ET ON E.IDEsame = ET.IDEsame
WHERE YEAR(E.DataEsame) = 2024 
INTERSECT 
SELECT E.IDCommissario 
FROM Esame E JOIN EsamePratico EP ON E.IDEsame = ET.IDEsame
WHERE YEAR(E.DataEsame) = 2024;

SELECT C.IDCommissario, C.Nome, C.Cognome
FROM Commissario C 
WHERE C.IDCommissario IN (
	SELECT E.IDCommissario 
    FROM Esame E 
    JOIN EsameTeorico ET ON E.IDEsame = ET.IDEsame
    WHERE YEAR(E.DataEsame) = 2024
    )
    AND C.IDCommissario IN (
		SELECT E.IDCommissario
        FROM Esame E
        JOIN EsamePratico EP ON E.IDEsame = EP.IDEsame
        WHERE YEAR(E.DataEsame) = 2024
    );
    
    
    
    
    
-- -----------------------------------------------------------------------------
-- Una selezione aggregata su raggruppamenti con condizioni che includano un’altra funzione di raggruppamento (es. dipartimenti la cui somma degli stipendi è la più alta)
#1. Selezionare i commissari che hanno valutato il maggior numero di esami

SELECT * 
FROM ConteggioEsamiPerCommissario 
WHERE NumeroEsami = (
	SELECT MAX(NumeroEsami)
    FROM ConteggioEsamiPerCommissario
);

#2. Conteggio degli esami per livello 
SELECT * 
FROM ConteggioEsamiPerLivello 
WHERE NumeroEsami = ( 
	SELECT MAX(NumeroEsami) 
    FROM ConteggioEsamiPerLivello
    );
		
        
        
        
-- -----------------------------------------------------------------------------
-- Una selezione con l’uso appropriato della divisione.
#1. Selezionare i commissari che sono stati assegnati a tutti i paesi europei (IDCommissario, Nome, Cognome)
SELECT C.IDCommissario, C.Nome, C.Cognome
FROM Commissario C
WHERE NOT EXISTS ( 
	SELECT *
    FROM PaeseAssegnato P
    WHERE P.Continente = 'Europa'
    AND NOT EXISTS ( 
		SELECT * 
        FROM Assegnazione A
        WHERE A.NomePaese = P.NomePaese
        AND A.IDCommissario = C.IDCommissario
        )
	);
    
#2. Selezionare i candidati che hanno partecipato a tutte le prove di un esame teorico (IDCandidato, Cognome)
SELECT C.IDCandidato, C.Cognome 
FROM Candidato C
WHERE NOT EXISTS(
	SELECT * 
    FROM EsameTeorico ET
    WHERE NOT EXISTS (
		SELECT *
        FROM Prova P
        WHERE P.IDEsame = ET.IDEsame
        AND P.IDCandidato = C.IDCandidato
        )
	);
    
#3. Selezionare i commissari che hanno valutato esami in tutte le date del 2024 (Nome, Cognome)
SELECT C.Nome, C.Cognome 
FROM Commissario C
WHERE NOT EXISTS (
	SELECT DISTINCT E.DataEsame 
    FROM Esame E 
    WHERE YEAR(DataEsame) = 2024
    AND NOT EXISTS (
		SELECT * 
        FROM Esame E1
        WHERE E1.IDCommissario = C.IDCommissario 
        AND E1.DataEsame = E.DataEsame
        )
	);
    



