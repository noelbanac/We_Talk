import 'package:flutter/material.dart';
import 'package:wetalk_application_2/screens/choose_login.dart';
import 'package:wetalk_application_2/screens/specialist/setup_specialist_info.dart';
import 'package:wetalk_application_2/screens/specialist/view_appointments.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

void main() {
  runApp(const AdminDashboard());
}

class AdminDashboard extends StatelessWidget {
  const AdminDashboard({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      debugShowCheckedModeBanner: false,
      home: DashboardScreen(),
    );
  }
}

class DashboardScreen extends StatelessWidget {
  const DashboardScreen({super.key});

  @override
  Widget build(BuildContext context) {
    // Get the current user's UID
    String? userId = FirebaseAuth.instance.currentUser?.uid;

    return Scaffold(
      backgroundColor: Colors.grey[100],
      appBar: AppBar(
        backgroundColor: Colors.blue[600],
        title: const Text('Dashboard'),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            const SizedBox(height: 20),
            // Welcome Container
            StreamBuilder<DocumentSnapshot>(
              stream: FirebaseFirestore.instance.collection('users').doc(userId).snapshots(),
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return const CircularProgressIndicator();
                }

                if (snapshot.hasError) {
                  return const Text('Error fetching user data');
                }

                if (!snapshot.hasData || !snapshot.data!.exists) {
                  return const Text('User does not exist');
                }

                // Fetch user data
                final userData = snapshot.data!.data() as Map<String, dynamic>;
                final userName = userData['name'] ?? 'User';
                final userEmail = userData['email'] ?? 'No email available';

                return Container(
                  padding: const EdgeInsets.all(16),
                  margin: const EdgeInsets.symmetric(horizontal: 16),
                  decoration: BoxDecoration(
                    color: Colors.grey[200],
                    borderRadius: BorderRadius.circular(10),
                    boxShadow: const [
                      BoxShadow(
                        color: Colors.black12,
                        blurRadius: 6,
                        offset: Offset(0, 2),
                      ),
                    ],
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Text('Welcome', style: TextStyle(fontSize: 14)),
                          Text(
                            userName,
                            style: const TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          Text(
                            userEmail,
                            style: const TextStyle(
                              fontSize: 14,
                              color: Colors.grey,
                            ),
                          ),
                        ],
                      ),
                      const CircleAvatar(
                        radius: 24,
                        backgroundImage: NetworkImage(
                            'https://storage.googleapis.com/a1aa/image/X35Iy37IararPZPG9b0DmvK9Lw4N2tDdWVJByHZRUhqiMC5E.jpg'),
                      ),
                    ],
                  ),
                );
              },
            ),
            const SizedBox(height: 20),
            // One box per line
            InkWell(
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const ViewAppointmentsPage()),
                );
              },
              child: const DashboardButton(
                icon: Icons.calendar_today,
                label: 'View Appointments',
                color: Color.fromRGBO(128, 203, 196, 1),
              ),
            ),
            const SizedBox(height: 16),
            InkWell(
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const SetupInformation()),
                );
              },
              child: const DashboardButton(
                icon: Icons.info,
                label: 'Setup Information',
                color: Color.fromRGBO(128, 203, 196, 1),
              ),
            ),
            const SizedBox(height: 16),
            InkWell(
              onTap: () {
                // Handle View Ratings navigation
              },
              child: const DashboardButton(
                icon: Icons.star,
                label: 'View Ratings',
                color: Color.fromRGBO(128, 203, 196, 1),
              ),
            ),
            const SizedBox(height: 16),
            InkWell(
              onTap: () {
                // Handle Settings navigation
              },
              child: const DashboardButton(
                icon: Icons.settings,
                label: 'Settings',
                color: Color.fromRGBO(128, 203, 196, 1),
              ),
            ),
            const SizedBox(height: 20),
            // Centered Log Out Button
            InkWell(
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const AdminOrClient()),
                );
              },
              child: DashboardButton(
                icon: Icons.logout,
                label: 'Log Out',
                color: Colors.blue[400]!, // Use the same color or a new one
              ),
            ),
            const SizedBox(height: 20),
          ],
        ),
      ),
    );
  }
}

class DashboardButton extends StatelessWidget {
  final IconData icon;
  final String label;
  final Color color;

  const DashboardButton({
    super.key,
    required this.icon,
    required this.label,
    required this.color,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width * 0.85, // Adjusted width
      height: 100, // Rectangular height
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: color,
        borderRadius: BorderRadius.circular(10),
        boxShadow: const [
          BoxShadow(
            color: Colors.black12,
            blurRadius: 6,
            offset: Offset(0, 2),
          ),
        ],
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(icon, size: 30),
          const SizedBox(height: 8),
          Text(
            label,
            textAlign: TextAlign.center,
            style: const TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.bold,
            ),
          ),
        ],
      ),
    );
  }
}
