package model;

import exceptions.CandidatoNonTrovatoException;
import exceptions.InserimentoCandidatoException;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.SQLException;
import java.sql.ResultSet;

public class Query {

    private static final String INSERT_SQL = "INSERT INTO Candidato (IDCandidato, Nome, Cognome, Email, DataNascita, CAP, Citta, Via) VALUES (?, ?, ?, ?, ?, ?, ?, ?)";
    private static final String UPDATE_EMAIL_SQL = "UPDATE Candidato SET Email = ? WHERE IDCandidato = ?";
    private static final String DELETE_SQL = "DELETE FROM Candidato WHERE IDCandidato = ?";
    private static final String SELECT_PER_CITTA_SQL = "SELECT * FROM Candidato WHERE Citta = ?";

    public static void inserisciCandidato(String idCandidato, String nome, String cognome, String email, String dataNascita, String cap, String citta, String via) throws InserimentoCandidatoException {
        try (Connection connessione = ConnessioneDatabase.getConnection();
             PreparedStatement preparedStatement = connessione.prepareStatement(INSERT_SQL)) {
            preparedStatement.setString(1, idCandidato);
            preparedStatement.setString(2, nome);
            preparedStatement.setString(3, cognome);
            preparedStatement.setString(4, email);
            preparedStatement.setString(5, dataNascita);
            preparedStatement.setString(6, cap);
            preparedStatement.setString(7, citta);
            preparedStatement.setString(8, via);
            preparedStatement.executeUpdate();
        } catch (SQLException e) {
            throw new InserimentoCandidatoException("Errore durante l'inserimento del candidato: " + e.getMessage());
        }
    }

    public static boolean modificaCandidatoEmail(String idCandidato, String email) throws CandidatoNonTrovatoException {
        try (Connection connessione = ConnessioneDatabase.getConnection();
             PreparedStatement preparedStatement = connessione.prepareStatement(UPDATE_EMAIL_SQL)) {
            preparedStatement.setString(1, email);
            preparedStatement.setString(2, idCandidato);
            int rowsAffected = preparedStatement.executeUpdate();
            if (rowsAffected == 0) {
                throw new CandidatoNonTrovatoException("ID non trovato.");
            }
            return true;
        } catch (SQLException e) {
            throw new CandidatoNonTrovatoException("Errore durante la modifica dell'email: " + e.getMessage());
        }
    }

    public static boolean eliminaCandidato(String idCandidato) throws CandidatoNonTrovatoException {
        try (Connection connessione = ConnessioneDatabase.getConnection();
             PreparedStatement preparedStatement = connessione.prepareStatement(DELETE_SQL)) {
            preparedStatement.setString(1, idCandidato);
            int rowsAffected = preparedStatement.executeUpdate();
            if (rowsAffected == 0) {
                throw new CandidatoNonTrovatoException("ID non trovato.");
            }
            return true;
        } catch (SQLException e) {
            throw new CandidatoNonTrovatoException("Errore durante l'eliminazione del candidato: " + e.getMessage());
        }
    }

    public static void visualizzaCandidatiPerCitta(String citta) throws Exception {
        try (Connection con = ConnessioneDatabase.getConnection();
             PreparedStatement preparedStatement = con.prepareStatement(SELECT_PER_CITTA_SQL)) {
            preparedStatement.setString(1, citta);
            try (ResultSet rs = preparedStatement.executeQuery()) {
                if (!rs.isBeforeFirst()) {
                    throw new Exception("Nessun candidato trovato per la città specificata.");
                }
                while (rs.next()) {
                    int id = rs.getInt("IDCandidato");
                    String nome = rs.getString("Nome");
                    String cognome = rs.getString("Cognome");
                    String email = rs.getString("Email");
                    String dataNascita = rs.getString("DataNascita");
                    String cap = rs.getString("CAP");
                    String cittaCandidato = rs.getString("Citta");
                    String via = rs.getString("Via");
                    System.out.println("ID: " + id + ", Nome: " + nome + ", Cognome: " + cognome + ", Email: " + email + ", Data di Nascita: " + dataNascita + ", CAP: " + cap + ", Città: " + cittaCandidato + ", Via: " + via);
                    System.out.println();
                }
                System.out.println("* * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * *");
            }
        } catch (SQLException e) {
            throw new Exception("Errore durante la visualizzazione dei candidati: " + e.getMessage());
        }
    }
}