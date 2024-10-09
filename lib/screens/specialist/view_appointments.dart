import 'package:flutter/material.dart';
import 'package:wetalk_application_2/screens/specialist/admin_dashboard.dart';
import 'package:wetalk_application_2/screens/specialist/confirmed_appointments.dart';
import 'package:wetalk_application_2/screens/specialist/finished_appointments.dart';
import 'package:wetalk_application_2/screens/specialist/pending_appointments.dart';

void main() {
  runApp(const ViewAppointments());
}

class ViewAppointments extends StatelessWidget {
  const ViewAppointments({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      debugShowCheckedModeBanner: false,
      home: ViewAppointmentsPage(),
    );
  }
}

class ViewAppointmentsPage extends StatelessWidget {
  const ViewAppointmentsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.blue,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.white),
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => const AdminDashboard()),
            );
          },
        ),
        title: const Text('View Appointments', style: TextStyle(color: Colors.white)),
      ),
      body: Container(
        color: Colors.grey[100],
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            InkWell(
              onTap: () {
                // Navigate to PendingAppointments screen
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const PendingAppointments()),
                );
              },
              child: const AppointmentSection(title: 'Pending Appointments'),
            ),
            InkWell(
              onTap: () {
                // Navigate to ConfirmedAppointments screen
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const ConfirmedAppointments()),
                );
              },
              child: const AppointmentSection(title: 'Confirmed Appointments'),
            ),
            InkWell(
              onTap: () {
                // Navigate to CompletedAppointments screen
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const FinishedAppointments()),
                );
              },
              child: const AppointmentSection(title: 'Finished Appointments'),
            ),
          ],
        ),
      ),
    );
  }
}

class AppointmentSection extends StatelessWidget {
  final String title;

  const AppointmentSection({super.key, required this.title});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 24.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style: const TextStyle(
              fontWeight: FontWeight.bold,
              color: Colors.black,
              fontSize: 18.0,
            ),
          ),
          Divider(color: Colors.grey[300]),
        ],
      ),
    );
  }
}


