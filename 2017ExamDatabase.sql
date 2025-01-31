CREATE DATABASE CarPooling;

USE CarPooling;

-- Tabella Utente
CREATE TABLE Utente (
  ID_Utente INT AUTO_INCREMENT PRIMARY KEY,
  CF VARCHAR(16) NOT NULL,
  Nome VARCHAR(50) NOT NULL,
  Cognome VARCHAR(50) NOT NULL,
  Data_Nascita DATE NOT NULL,
  Numero_Telefono VARCHAR(15),
  Email VARCHAR(100)
);

-- Tabella Autista
CREATE TABLE Autista (
  Scadenza_Patente DATE NOT NULL,
  Targa VARCHAR(10) NOT NULL,
  Marca VARCHAR(50) NOT NULL,
  Modello VARCHAR(50) NOT NULL,
  Numero_Posti INT NOT NULL,
  Colore VARCHAR(30),
  ID_Utente INT AUTO_INCREMENT PRIMARY KEY,
  FOREIGN KEY (ID_Utente) REFERENCES Utente(ID_Utente) ON DELETE CASCADE
);

-- Tabella Passeggero
CREATE TABLE Passeggero (
  Documento_Identità VARCHAR(50) NOT NULL,
  ID_Utente INT AUTO_INCREMENT PRIMARY KEY,
  FOREIGN KEY (ID_Utente) REFERENCES Utente(ID_Utente) ON DELETE CASCADE
);

-- Tabella Viaggio
CREATE TABLE Viaggio (
  ID_Viaggio INT AUTO_INCREMENT PRIMARY KEY,
  Citta_Partenza VARCHAR(50) NOT NULL,
  Citta_Destinazione VARCHAR(50) NOT NULL,
  Data_Partenza DATE NOT NULL,
  Ora_Partenza TIME NOT NULL,
  Contributo_Economico DECIMAL(10, 2) NOT NULL,
  Tempi_Percorrenza TIME NOT NULL,
  Eventuali_Soste TEXT,
  Possibilita_Bagagli_Animali BOOLEAN,
  ID_Utente INT NOT NULL,
  FOREIGN KEY (ID_Utente) REFERENCES Utente(ID_Utente) ON DELETE CASCADE
);

-- Tabella Prenotazione
CREATE TABLE Prenotazione (
  ID_Prenotazione INT AUTO_INCREMENT PRIMARY KEY,
  Posti_Disponibili INT NOT NULL,
  Posti_Prenotati INT NOT NULL,
  ID_Passeggero INT NOT NULL,
  ID_Viaggio INT NOT NULL,
  FOREIGN KEY (ID_Passeggero) REFERENCES Passeggero(ID_Utente) ON DELETE CASCADE,
  FOREIGN KEY (ID_Viaggio) REFERENCES Viaggio(ID_Viaggio) ON DELETE CASCADE
);

-- Tabella Feedback
CREATE TABLE Feedback (
  ID_Feedback INT AUTO_INCREMENT PRIMARY KEY,
  Voto_Numerico INT NOT NULL CHECK (Voto_Numerico BETWEEN 1 AND 5),
  Media_Voti DECIMAL(3, 2),
  Giudizio_Discorsivo TEXT,
  ID_Utente INT NOT NULL,
  ID_Viaggio INT NOT NULL,
  FOREIGN KEY (ID_Utente) REFERENCES Utente(ID_Utente) ON DELETE CASCADE,
  FOREIGN KEY (ID_Viaggio) REFERENCES Viaggio(ID_Viaggio) ON DELETE CASCADE
);
