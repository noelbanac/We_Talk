import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:wetalk_application_2/screens/client/appointment_form.dart';


class CounselorDetails extends StatelessWidget {
  final Map<String, dynamic> counselor; // Assume counselor data is passed as a map

  const CounselorDetails({super.key, required this.counselor});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.black.withOpacity(0.8),
        elevation: 0,
        title: const Text(
          'Counselor Details',
          style: TextStyle(color: Colors.white),
        ),
        leading: IconButton(
          icon: const FaIcon(Icons.arrow_back_ios, color: Colors.white),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
      ),
      body: Stack(
        children: [
          // Background Image for the body
          Positioned.fill(
            child: Image.asset(
              'assets/intro_image.jpg', // Path to your background image
              fit: BoxFit.cover,
              color: Colors.black.withOpacity(0.6),
              colorBlendMode: BlendMode.darken,
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Counselor Name
                Text(
                  counselor['name'], // Adjust based on your counselor data structure
                  style: const TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),
                const SizedBox(height: 8),
                // Counselor Description
                Text(
                  counselor['description'], // Adjust based on your counselor data structure
                  style: const TextStyle(
                    fontSize: 16,
                    color: Colors.white,
                  ),
                ),
                const Spacer(), // Pushes the button to the bottom
                // Book Appointment Button
                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.blue,
                    padding: const EdgeInsets.symmetric(vertical: 15),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => BookingPage(counselor: counselor), // Pass counselor data
                      ),
                    );
                  },
                  child: const Text(
                    'Book Appointment',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
