package gui;

import model.Query;
import exceptions.InserimentoCandidatoException;

import javax.swing.*;
import java.awt.*;
import java.awt.event.ActionEvent;
import java.awt.event.ActionListener;

public class FrameInserisciCandidato extends JFrame {
    private JTextField idField;
    private JTextField nomeField;
    private JTextField cognomeField;
    private JTextField emailField;
    private JTextField dataNascitaField;
    private JTextField capField;
    private JTextField cittaField;
    private JTextField viaField;

    public FrameInserisciCandidato() {
        setLayout(new GridLayout(9,2));

        add(new JLabel("ID:"));
        idField = new JTextField();
        add(idField);

        add(new JLabel("Nome:"));
        nomeField = new JTextField();
        add(nomeField);

        add(new JLabel("Cognome:"));
        cognomeField = new JTextField();
        add(cognomeField);

        add(new JLabel("Email:"));
        emailField = new JTextField();
        add(emailField);

        add(new JLabel("Data nascita:"));
        dataNascitaField = new JTextField();
        add(dataNascitaField);

        add(new JLabel("Cap:"));
        capField = new JTextField();
        add(capField);

        add(new JLabel("Citta:"));
        cittaField = new JTextField();
        add(cittaField);

        add(new JLabel("Via:"));
        viaField = new JTextField();
        add(viaField);

        JButton inserisciButton = new JButton("Inserisci");
        inserisciButton.addActionListener(new ActionListener() {
            @Override
            public void actionPerformed(ActionEvent e) {
                String id = idField.getText();
                String nome = nomeField.getText();
                String cognome = cognomeField.getText();
                String email = emailField.getText();
                String dataNascita = dataNascitaField.getText();
                String cap = capField.getText();
                String citta = cittaField.getText();
                String via = viaField.getText();

                try {
                    Query.inserisciCandidato(id, nome, cognome, email, dataNascita, cap, citta, via);
                    JOptionPane.showMessageDialog(null, "Candidato inserito correttamente.");
                } catch (InserimentoCandidatoException ex) {
                    JOptionPane.showMessageDialog(null, ex.getMessage(), "Errore", JOptionPane.ERROR_MESSAGE);
                }
            }
        });
        add(inserisciButton);
    }
}