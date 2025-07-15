import javax.swing.*;
import java.awt.event.*;

public class FeedbackPanel extends JPanel {
    public FeedbackPanel() {
        setLayout(new BoxLayout(this, BoxLayout.Y_AXIS));

        add(new JLabel("Feedback Module"));

        JButton submitButton = new JButton("Submit Feedback");
        JButton viewButton = new JButton("View Feedback");
        JButton editButton = new JButton("Edit Feedback");
        JButton deleteButton = new JButton("Delete Feedback");

        add(submitButton);
        add(viewButton);
        add(editButton);
        add(deleteButton);

        submitButton.addActionListener(e -> {
            String ratingStr = JOptionPane.showInputDialog(this, "Enter rating (1–5):");
            try {
                int rating = Integer.parseInt(ratingStr);
                if (rating < 1 || rating > 5) {
                    throw new NumberFormatException();
                }
                JOptionPane.showMessageDialog(this, "Feedback submitted with rating: " + rating);
            } catch (Exception ex) {
                JOptionPane.showMessageDialog(this, "Invalid rating. Must be 1 to 5.", "Error", JOptionPane.ERROR_MESSAGE);
            }
        });
    }
}
