--Query a)  
SELECT 
    Utente.Nome, Utente.Cognome, Autista.Targa, Autista.Marca, Autista.Modello,
    Autista.Numero_Posti, Autista.Colore, Viaggio.Contributo_Economico, Viaggio.Ora_Partenza
FROM 
    Viaggio
JOIN Autista ON Viaggio.ID_Utente = Autista.ID_Utente
JOIN Utente ON Autista.ID_Utente = Utente.ID_Utente
LEFT JOIN Prenotazione ON Viaggio.ID_Viaggio = Prenotazione.ID_Viaggio
WHERE 
    Viaggio.Citta_Partenza = 'CittàPartenza'
    AND Viaggio.Citta_Destinazione = 'CittàDestinazione'
    AND Viaggio.Data_Partenza = '2025-01-31' 
    AND (Prenotazione.Posti_Prenotati < Prenotazione.Posti_Disponibili OR Prenotazione.ID_Viaggio IS NULL)
ORDER BY 
    Viaggio.Ora_Partenza ASC;

--Query b)  
SELECT 
    Passeggero.Documento_Identità, Utente.Nome, Utente.Cognome, Utente.Email,
    Viaggio.Citta_Partenza, Viaggio.Citta_Destinazione, Viaggio.Data_Partenza, Viaggio.Ora_Partenza
FROM 
    Prenotazione
JOIN Passeggero ON Prenotazione.ID_Passeggero = Passeggero.ID_Utente
JOIN Utente ON Passeggero.ID_Utente = Utente.ID_Utente
JOIN Viaggio ON Prenotazione.ID_Viaggio = Viaggio.ID_Viaggio
WHERE 
    Prenotazione.ID_Prenotazione = 'CodicePrenotazioneAccettata';

--Query c)  
SELECT 
    Passeggero.ID_Utente AS ID_Passeggero, Utente.Nome, Utente.Cognome, 
    AVG(Feedback.Voto_Numerico) AS Voto_Medio
FROM 
    Prenotazione
JOIN Passeggero ON Prenotazione.ID_Passeggero = Passeggero.ID_Utente
JOIN Utente ON Passeggero.ID_Utente = Utente.ID_Utente
LEFT JOIN Feedback ON Passeggero.ID_Utente = Feedback.ID_Utente
WHERE 
    Prenotazione.ID_Viaggio = 'CodiceViaggio'
GROUP BY 
    Passeggero.ID_Utente, Utente.Nome, Utente.Cognome
HAVING 
    AVG(Feedback.Voto_Numerico) > 'ValoreMinimo';
