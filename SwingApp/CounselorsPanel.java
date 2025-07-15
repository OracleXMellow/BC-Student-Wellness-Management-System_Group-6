import javax.swing.*;
import java.awt.event.*;

public class CounselorsPanel extends JPanel {
    public CounselorsPanel() {
        setLayout(new BoxLayout(this, BoxLayout.Y_AXIS));

        add(new JLabel("Counselors Module"));

        JButton addButton = new JButton("Add Counselor");
        JButton viewButton = new JButton("View Counselors");
        JButton updateButton = new JButton("Edit Counselor Info");
        JButton deleteButton = new JButton("Delete Counselor");

        add(addButton);
        add(viewButton);
        add(updateButton);
        add(deleteButton);

        deleteButton.addActionListener(e -> {
            int result = JOptionPane.showConfirmDialog(this, "Are you sure you want to delete this counselor?", "Confirm Delete", JOptionPane.YES_NO_OPTION);
            if (result == JOptionPane.YES_OPTION) {
                JOptionPane.showMessageDialog(this, "Counselor deleted.");
            }
        });
    }
}
