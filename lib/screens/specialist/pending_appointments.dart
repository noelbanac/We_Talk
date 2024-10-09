import 'package:flutter/material.dart';
import 'package:wetalk_application_2/screens/specialist/view_appointments.dart';

void main() {
  runApp(const PendingAppointments());
}

class PendingAppointments extends StatelessWidget {
  const PendingAppointments({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      debugShowCheckedModeBanner: false,
      home: PendingAppointmentsPage(),
    );
  }
}

class PendingAppointmentsPage extends StatelessWidget {
  const PendingAppointmentsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF5F5FF),
      appBar: AppBar(
        backgroundColor: const Color(0xFF4A90E2),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.white),
          onPressed: () {
            Navigator.push(context,
                MaterialPageRoute(builder: (context) => const ViewAppointments()));
          },
        ),
        title: const Text('Pending Appointments', style: TextStyle(color: Colors.white)),
      ),
      body: Center(
        child: Container(
          width: MediaQuery.of(context).size.width * 0.9,
          padding: const EdgeInsets.all(16.0),
          decoration: BoxDecoration(
            color: const Color(0xFFE0E0E0), // Changed to a greyish color
            borderRadius: BorderRadius.circular(12.0),
            boxShadow: const [
              BoxShadow(
                color: Colors.black12,
                blurRadius: 8.0,
              ),
            ],
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              const Row(
                children: [
                  CircleAvatar(
                    radius: 24.0,
                    backgroundImage: NetworkImage('https://storage.googleapis.com/a1aa/image/bLa9Z9zCdK7wIdG9xY12CHF33f4pjkXCUgSEFyv2zC3ZDLyJA.jpg'),
                  ),
                  SizedBox(width: 16.0),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Hermann Noel Banac',
                        style: TextStyle(
                          fontSize: 18.0,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      Text(
                        'Client',
                        style: TextStyle(
                          color: Colors.grey,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
              const SizedBox(height: 16.0),
              Container(
                padding: const EdgeInsets.all(8.0),
                decoration: BoxDecoration(
                  color: const Color(0xFFE3F2FD),
                  borderRadius: BorderRadius.circular(8.0),
                ),
                child: const Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Row(
                      children: [
                        Icon(Icons.calendar_today, color: Color(0xFF4A90E2)),
                        SizedBox(width: 8.0),
                        Text(
                          'Mon, Sep 23',
                          style: TextStyle(color: Color(0xFF4A90E2)),
                        ),
                      ],
                    ),
                    Row(
                      children: [
                        Icon(Icons.access_time, color: Color(0xFF4A90E2)),
                        SizedBox(width: 8.0),
                        Text(
                          '9:30 - 10:35 AM',
                          style: TextStyle(color: Color(0xFF4A90E2)),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 16.0),
              Row(
                mainAxisAlignment: MainAxisAlignment.center, // Center the buttons
                children: [
                  ElevatedButton(
                    onPressed: () {},
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.red,
                      foregroundColor: Colors.white, // Set text color to white
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8.0),
                      ),
                    ),
                    child: const Text('Reject'),
                  ),
                  const SizedBox(width: 30.0), // Adjust the width as needed
                  ElevatedButton(
                    onPressed: () {},
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.green,
                      foregroundColor: Colors.white, // Set text color to white
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8.0),
                      ),
                    ),
                    child: const Text('Accept'),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}

