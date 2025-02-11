package gui;

import model.Query;
import exceptions.CandidatoNonTrovatoException;

import javax.swing.*;
import java.awt.*;
import java.awt.event.ActionEvent;
import java.awt.event.ActionListener;

public class FrameModificaEmail extends JFrame {
    private JTextField idField;
    private JTextField emailField;

    public FrameModificaEmail() {
        setLayout(new GridLayout(3,2));

        add(new JLabel("ID:"));
        idField = new JTextField();
        add(idField);

        add(new JLabel("Email:"));
        emailField = new JTextField();
        add(emailField);

        JButton modificaButton = new JButton("Modifica Email");
        modificaButton.addActionListener(new ActionListener() {
            @Override
            public void actionPerformed(ActionEvent e) {
                String id = idField.getText();
                String email = emailField.getText();

                try {
                    boolean success = Query.modificaCandidatoEmail(id, email);
                    if (success) {
                        JOptionPane.showMessageDialog(null, "Email modificata correttamente.");
                    }
                } catch (CandidatoNonTrovatoException ex) {
                    JOptionPane.showMessageDialog(null, ex.getMessage(), "Errore", JOptionPane.ERROR_MESSAGE);
                }
            }
        });
        add(modificaButton);
    }
}