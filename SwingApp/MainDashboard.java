import javax.swing.*;

public class MainDashboard extends JFrame {

    public MainDashboard() {
        setTitle("BC Wellness Management System");
        setSize(800, 600);
        setDefaultCloseOperation(JFrame.EXIT_ON_CLOSE);
        setLocationRelativeTo(null);

        JTabbedPane tabs = new JTabbedPane();
        tabs.addTab("Appointments", new AppointmentsPanel());
        tabs.addTab("Counselors", new CounselorsPanel());
        tabs.addTab("Feedback", new FeedbackPanel());

        add(tabs);
        setVisible(true);
    }

    public static void main(String[] args) {
        SwingUtilities.invokeLater(() -> new MainDashboard());
    }
}
