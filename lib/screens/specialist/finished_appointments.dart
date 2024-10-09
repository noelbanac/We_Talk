import 'package:flutter/material.dart';
import 'package:wetalk_application_2/screens/specialist/view_appointments.dart';

void main() {
  runApp(const FinishedAppointments());
}

class FinishedAppointments extends StatelessWidget {
  const FinishedAppointments({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      debugShowCheckedModeBanner: false,
      home: FinishedAppointmentsPage(),
    );
  }
}

class FinishedAppointmentsPage extends StatelessWidget {
  const FinishedAppointmentsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[100],
      appBar: AppBar(
        backgroundColor: Colors.blue[600],
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.white),
          onPressed: () {
            Navigator.push(context,
                MaterialPageRoute(builder: (context) => const ViewAppointments()));
          },
        ),
        title: const Text('Finished Appointments', style: TextStyle(color: Colors.white)),
      ),
      body: const Padding(
        padding: EdgeInsets.all(16.0),
        child: Column(
          children: [
            AppointmentCard(),
            SizedBox(height: 16),
            AppointmentCard(),
          ],
        ),
      ),
    );
  }
}

class AppointmentCard extends StatelessWidget {
  const AppointmentCard({super.key});

  @override
  Widget build(BuildContext context) {
    return Card(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      color: Colors.grey[200], // Changed the background color to a greyish tone
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            Row(
              children: [
                const CircleAvatar(
                  backgroundImage: NetworkImage('https://storage.googleapis.com/a1aa/image/q3lrxdtM6KKBHZG5FUGzr3kY5TbrcaK4YayKBIyefYa9QYkTA.jpg'),
                  radius: 24,
                ),
                const SizedBox(width: 16),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text('Hermann Noel Banac', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
                    Text('Client', style: TextStyle(color: Colors.grey[600])),
                  ],
                ),
              ],
            ),
            const SizedBox(height: 16),
            Container(
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: Colors.blue[50],
                borderRadius: BorderRadius.circular(8),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    children: [
                      Icon(Icons.calendar_today, color: Colors.blue[600]),
                      const SizedBox(width: 8),
                      Text('Mon, Sep 23', style: TextStyle(color: Colors.blue[600])),
                    ],
                  ),
                  Row(
                    children: [
                      Icon(Icons.access_time, color: Colors.blue[600]),
                      const SizedBox(width: 8),
                      Text('9:30 - 10:35 AM', style: TextStyle(color: Colors.blue[600])),
                    ],
                  ),
                ],
              ),
            ),
            const SizedBox(height: 16),
            ElevatedButton(
              onPressed: () {},
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.red[600],
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(24)),
                padding: const EdgeInsets.symmetric(horizontal: 32, vertical: 12),
                elevation: 4,
              ),
              child: const Text('Delete from records', style: TextStyle(color: Colors.white)),
            ),
          ],
        ),
      ),
    );
  }
}
