package gui;

import model.Query;

import javax.swing.*;
import java.awt.*;
import java.awt.event.ActionEvent;
import java.awt.event.ActionListener;

public class FrameVisualizzaCandidatiPerCitta extends JFrame {
    private JTextField cittaField;

    public FrameVisualizzaCandidatiPerCitta() {
        setLayout(new GridLayout(2, 2));

        add(new JLabel("Città:"));
        cittaField = new JTextField();
        add(cittaField);

        JButton visualizzaPerCittaButton = new JButton("Visualizza per Città");
        visualizzaPerCittaButton.addActionListener(new ActionListener() {
            @Override
            public void actionPerformed(ActionEvent e) {
                String citta = cittaField.getText();
                try {
                    Query.visualizzaCandidatiPerCitta(citta);
                    JOptionPane.showMessageDialog(null, "Stai visualizzando i Candidati della città di " + citta + ".");
                } catch (Exception ex) {
                    JOptionPane.showMessageDialog(null, ex.getMessage(), "Errore", JOptionPane.ERROR_MESSAGE);
                }
            }
        });
        add(visualizzaPerCittaButton);
    }
}