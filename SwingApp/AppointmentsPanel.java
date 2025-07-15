import javax.swing.*;
import java.awt.event.*;

public class AppointmentsPanel extends JPanel {
    public AppointmentsPanel() {
        setLayout(new BoxLayout(this, BoxLayout.Y_AXIS));

        add(new JLabel("Appointments Module"));

        JButton bookButton = new JButton("Book Appointment");
        JButton viewButton = new JButton("View Appointments");
        JButton editButton = new JButton("Edit/Reschedule Appointment");
        JButton cancelButton = new JButton("Cancel Appointment");

        add(bookButton);
        add(viewButton);
        add(editButton);
        add(cancelButton);

        bookButton.addActionListener(e -> {
            String input = JOptionPane.showInputDialog(this, "Enter student name:");
            if (input == null || input.trim().isEmpty()) {
                JOptionPane.showMessageDialog(this, "Student name is required.", "Error", JOptionPane.ERROR_MESSAGE);
            } else {
                JOptionPane.showMessageDialog(this, "Appointment booked for " + input);
            }
        });
    }
}
