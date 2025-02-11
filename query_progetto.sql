-- Una selezione ordinata su un attributo di una tabella con condizioni AND e OR;

SELECT IDCandidato, Nome, Cognome, CAP, Citta 
FROM Candidato
WHERE Citta = 'Salerno' AND (CAP = '84126' OR CAP = '84125')
ORDER BY Cognome DESC;


-- -----------------------------------------------------------------------------
-- Una selezione su due o più tabelle con condizioni;

SELECT C.Nome, C.Cognome, EP.Strumento, A.Punteggio
FROM Candidato C
JOIN Prova P ON C.IDCandidato = P.IDCandidato 
JOIN AttestatodiCertificazione A ON P.IDEsame = A.IDEsame
JOIN EsamePratico EP ON P.IDEsame = EP.IDEsame
WHERE A.Punteggio > 90 AND EP.Strumento = 'Pianoforte'; 
-- -----------------------------------------------------------------------------
-- Una selezione aggregata su tutti i valori (es. somma di tutti gli stipendi)

SELECT AVG(Punteggio) AS MediaPunteggi, MAX(Punteggio) AS PunteggioMassimo, MIN(Punteggio) AS PunteggioMinimo
FROM AttestatodiCertificazione;

-- -----------------------------------------------------------------------------
-- Una selezione aggregata su raggruppamenti (es. somma stipendi per dipartimenti)

SELECT E.Livello, AVG(A.Punteggio) AS MediaPunteggi
FROM AttestatodiCertificazione A
JOIN Esame E ON A.IDEsame = E.IDEsame
GROUP BY E.Livello
ORDER BY MediaPunteggi;


-- -----------------------------------------------------------------------------
-- Una selezione aggregata su raggruppamenti con condizioni (es. dipartimenti la cui somma degli stipendi dei dipendenti è > 100k)

SELECT E.IDCommissario, COUNT(*) AS NumeroEsami
FROM Esame E
GROUP BY E.IDCommissario
HAVING COUNT(*) > 2
ORDER BY NumeroEsami DESC;





-- -----------------------------------------------------------------------------
-- Una selezione con operazioni insiemistiche

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






SELECT P.IDCandidato
FROM Prova P
JOIN EsameTeorico ET ON P.IDEsame = ET.IDEsame
WHERE P.Risultato = 'Superato'
INTERSECT
SELECT P.IDCandidato
FROM Prova P
JOIN EsamePratico EP ON P.IDEsame = EP.IDEsame
WHERE P.Risultato = 'Superato';


SELECT C.IDCandidato, C.Nome, C.Cognome
FROM Candidato C
WHERE C.IDCandidato IN (
    SELECT P.IDCandidato
    FROM Prova P
    JOIN EsameTeorico ET ON P.IDEsame = ET.IDEsame
    WHERE P.Risultato = 'Superato'
)
AND C.IDCandidato IN (
    SELECT P.IDCandidato
    FROM Prova P
    JOIN EsamePratico EP ON P.IDEsame = EP.IDEsame
    WHERE P.Risultato = 'Superato'
);
    
-- -----------------------------------------------------------------------------
-- Una selezione aggregata su raggruppamenti con condizioni che includano un’altra funzione di raggruppamento (es. dipartimenti la cui somma degli stipendi è la più alta)

SELECT * 
FROM ConteggioEsamiPerCommissario 
WHERE NumeroEsami = (
	SELECT MAX(NumeroEsami)
    FROM ConteggioEsamiPerCommissario
);

-- -----------------------------------------------------------------------------
-- Una selezione con l’uso appropriato della divisione.

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
    