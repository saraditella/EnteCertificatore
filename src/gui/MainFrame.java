package gui;

import javax.swing.*;
import java.awt.*;
import java.awt.event.ActionEvent;
import java.awt.event.ActionListener;

public class MainFrame extends JFrame {
    public MainFrame() {
        setTitle("Gestione candidati");
        setSize(400, 400);

        setDefaultCloseOperation(JFrame.EXIT_ON_CLOSE);
        setLocationRelativeTo(null);
        setLayout(new GridLayout(5,1));

        JButton inserisciButton = new JButton("Inserisci Candidato");
        inserisciButton.addActionListener(new ActionListener() {
            @Override
            public void actionPerformed(ActionEvent e) {
                JFrame frameInserisciCandidato = new FrameInserisciCandidato();
                frameInserisciCandidato.setTitle("Inserisci Candidato");
                frameInserisciCandidato.setLocation(500, 200);
                frameInserisciCandidato.setSize(300, 250);
                frameInserisciCandidato.setVisible(true);
            }
        });
        add(inserisciButton);

        JButton modificaEmailButton = new JButton("Modifica Email");
        modificaEmailButton.addActionListener(new ActionListener() {
            @Override
            public void actionPerformed(ActionEvent e)  {
                JFrame frameModificaEmail = new FrameModificaEmail();
                frameModificaEmail.setTitle("Modifica Email");
                frameModificaEmail.setLocation(500, 200);
                frameModificaEmail.setSize(300, 250);
                frameModificaEmail.setVisible(true);
            }
        });
        add(modificaEmailButton);

        JButton eliminaButton = new JButton("Elimina Candidato");
        eliminaButton.addActionListener(new ActionListener() {
            @Override
            public void actionPerformed(ActionEvent e) {
                JFrame frameEliminaCandidato = new FrameEliminaCandidato();
                frameEliminaCandidato.setTitle("Elimina Candidato");
                frameEliminaCandidato.setLocation(500, 200);
                frameEliminaCandidato.setSize(300, 250);
                frameEliminaCandidato.setVisible(true);
            }
        });
        add(eliminaButton);

        JButton visualizzaPerCittaButton = new JButton("Visualizza Per Città");

        visualizzaPerCittaButton.addActionListener(new ActionListener() {
            @Override
            public void actionPerformed(ActionEvent e) {
                JFrame frameVisualizzaCandidatiPerCitta = new FrameVisualizzaCandidatiPerCitta();
                frameVisualizzaCandidatiPerCitta.setTitle("Visualizza Per Città");
                frameVisualizzaCandidatiPerCitta.setLocation(500, 200);
                frameVisualizzaCandidatiPerCitta.setSize(300, 250);
                frameVisualizzaCandidatiPerCitta.setVisible(true);
            }
        });
        add(visualizzaPerCittaButton);
    }

    public static void main(String[] args) {
        new MainFrame().setVisible(true);
    }
}