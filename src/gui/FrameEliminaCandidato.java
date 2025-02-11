package gui;

import model.Query;
import exceptions.CandidatoNonTrovatoException;

import javax.swing.*;
import java.awt.*;
import java.awt.event.ActionEvent;
import java.awt.event.ActionListener;

public class FrameEliminaCandidato extends JFrame {
    private JTextField idField;

    public FrameEliminaCandidato() {
        setLayout(new GridLayout(2, 2));

        add(new JLabel("ID:"));
        idField = new JTextField();
        add(idField);

        JButton eliminaButton = new JButton("Elimina");
        eliminaButton.addActionListener(new ActionListener() {
            @Override
            public void actionPerformed(ActionEvent e) {
                String id = idField.getText();
                try {
                    boolean success = Query.eliminaCandidato(id);
                    if (success) {
                        JOptionPane.showMessageDialog(null, "Candidato eliminato correttamente.");
                    }
                } catch (CandidatoNonTrovatoException ex) {
                    JOptionPane.showMessageDialog(null, ex.getMessage(), "Errore", JOptionPane.ERROR_MESSAGE);
                }
            }
        });
        add(eliminaButton);
    }
}