import 'package:flutter/material.dart';
import 'package:wetalk_application_2/screens/specialist/view_appointments.dart';

void main() {
  runApp(const ConfirmedAppointments());
}

class ConfirmedAppointments extends StatelessWidget {
  const ConfirmedAppointments({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: ConfirmedAppointmentsPage(),
    );
  }
}

class ConfirmedAppointmentsPage extends StatelessWidget {
  final List<Map<String, String>> appointments = [
    {
      'name': 'Hermann Noel Banac',
      'role': 'Client',
      'date': 'Mon, Sep 23',
      'time': '9:30 - 10:35 AM',
      'imageUrl':
          'https://storage.googleapis.com/a1aa/image/IhQ8TOiTBvaeYq0dG8MkNnyFM9o0k6inrgozfM0fvaWGYvInA.jpg',
    },
    {
      'name': 'Jane Doe',
      'role': 'Client',
      'date': 'Tue, Sep 24',
      'time': '10:00 - 11:00 AM',
      'imageUrl':
          'https://example.com/image.jpg', // Replace with an actual URL
    },
    {
      'name': 'John Smith',
      'role': 'Client',
      'date': 'Wed, Sep 25',
      'time': '11:30 - 12:30 PM',
      'imageUrl':
          'https://example.com/image.jpg', // Replace with an actual URL
    },
  ];

  ConfirmedAppointmentsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF3E8FF),
      appBar: AppBar(
        backgroundColor: const Color(0xFF4A90E2),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.white),
          onPressed: () {
            Navigator.push(context,
                MaterialPageRoute(builder: (context) => const ViewAppointments()));
          },
        ),
        title: const Text(
          'Confirmed Appointments',
          style: TextStyle(color: Colors.white),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: ListView.builder(
          itemCount: appointments.length,
          itemBuilder: (context, index) {
            return Column(
              children: [
                AppointmentCard(appointments[index]),
                const SizedBox(height: 16),
              ],
            );
          },
        ),
      ),
    );
  }
}

class AppointmentCard extends StatelessWidget {
  final Map<String, String> appointment;

  const AppointmentCard(this.appointment, {super.key});

  @override
  Widget build(BuildContext context) {
    return Card(
      color: const Color(0xFFE0E0E0),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16),
      ),
      elevation: 4,
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                CircleAvatar(
                  radius: 28,
                  backgroundImage: NetworkImage(appointment['imageUrl']!),
                ),
                const SizedBox(width: 16),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        appointment['name']!,
                        style: const TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                        ),
                        overflow: TextOverflow.ellipsis,
                        maxLines: 1,
                      ),
                      Text(
                        appointment['role']!,
                        style: const TextStyle(
                          color: Colors.grey,
                        ),
                        overflow: TextOverflow.ellipsis,
                        maxLines: 1,
                      ),
                      const SizedBox(height: 8),
                      // Enhanced and centered date and time section
                      Center(
                        child: Container(
                          padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 16),
                          decoration: BoxDecoration(
                            color: const Color(0xFFE6F0FF),
                            borderRadius: BorderRadius.circular(12),
                            boxShadow: [
                              BoxShadow(
                                color: Colors.grey.withOpacity(0.5),
                                spreadRadius: 1,
                                blurRadius: 5,
                                offset: const Offset(0, 3),
                              ),
                            ],
                          ),
                          child: Row(
                            mainAxisSize: MainAxisSize.min,
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              const Icon(
                                Icons.calendar_today,
                                color: Color(0xFF4A90E2),
                                size: 20,
                              ),
                              const SizedBox(width: 8),
                              Flexible(
                                child: Text(
                                  appointment['date']!,
                                  style: const TextStyle(
                                    color: Color(0xFF4A90E2),
                                    fontWeight: FontWeight.w500,
                                  ),
                                  overflow: TextOverflow.visible, // Allow full visibility
                                ),
                              ),
                              const SizedBox(width: 16),
                              const Icon(
                                Icons.access_time,
                                color: Color(0xFF4A90E2),
                                size: 20,
                              ),
                              const SizedBox(width: 8),
                              Flexible(
                                child: Text(
                                  appointment['time']!,
                                  style: const TextStyle(
                                    color: Color(0xFF4A90E2),
                                    fontWeight: FontWeight.w500,
                                  ),
                                  overflow: TextOverflow.visible, // Allow full visibility
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
            const SizedBox(height: 16),
            Center(
              child: ElevatedButton(
                onPressed: () {},
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xFF4A90E2),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8),
                  ),
                  elevation: 4,
                ),
                child: const Text('Complete'),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
