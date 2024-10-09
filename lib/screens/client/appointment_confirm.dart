import 'package:flutter/material.dart';

void main() {
  runApp(const AppointmentConfirmation());
}

class AppointmentConfirmation extends StatelessWidget { 
  const AppointmentConfirmation({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      debugShowCheckedModeBanner: false,
      home: AppointmentConfirmationPage(),
    );
  }
}

class AppointmentConfirmationPage extends StatelessWidget {
  const AppointmentConfirmationPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack( // Use Stack to overlay widgets
        children: [
          // Background Image
          Image.asset(
            'assets/intro_image.jpg', // Replace with your actual asset path
            fit: BoxFit.cover,
            height: double.infinity,
            width: double.infinity,
          ),
          // Overlay with Opacity
          Opacity(
            opacity: 0.8, // Adjust opacity as needed
            child: Container(
              color: Colors.black, // Darken background for better contrast
              child: Center(
                child: Container(
                  padding: const EdgeInsets.all(24.0), // Increased padding for comfort
                  decoration: BoxDecoration(
                    color: Colors.white, // Make the container white
                    borderRadius: BorderRadius.circular(10.0),
                  ),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      const SizedBox(height: 20),
                      Image.network(
                        'https://storage.googleapis.com/a1aa/image/5xI0ltsETVrRDl3GGuuxdD1kjT1zjVZXODo19lVJVBOSZ04E.jpg',
                        height: 150, // Reduced image size for better layout
                        width: 150,
                      ),
                      const SizedBox(height: 20),
                      const Text(
                        'Appointment Confirmed!', // Corrected typo
                        style: TextStyle(
                          fontSize: 20, // Slightly reduced font size
                          fontWeight: FontWeight.bold,
                          color: Colors.black, // Changed to black for contrast
                        ),
                      ),
                      const SizedBox(height: 10),
                      const Text(
                        'Your appointment with Mr. Jose Alonzo on July 9, 2024 at 4:00 - 4:30 PM is confirmed.',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          fontSize: 14, // Reduced font size for better fit
                          color: Colors.black, // Changed to black for contrast
                        ),
                      ),
                      const SizedBox(height: 20),
                      const Text(
                        'Time left before appointment',
                        style: TextStyle(
                          fontSize: 12, // Reduced font size
                          color: Colors.black, // Changed to black for contrast
                        ),
                      ),
                      const SizedBox(height: 10),
                      const Text(
                        '2 days 15 hours',
                        style: TextStyle(
                          fontSize: 24, // Increased font size for emphasis
                          fontWeight: FontWeight.bold,
                          color: Colors.black, // Changed to black for contrast
                        ),
                      ),
                      const SizedBox(height: 20),
                      ElevatedButton(
                        onPressed: () {},
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.blue,
                          padding: const EdgeInsets.symmetric(horizontal: 40, vertical: 10),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(30.0),
                          ),
                        ),
                        child: const Text(
                          'NEXT',
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                            color: Colors.white,
                          ),
                        ),
                      ),
                      const SizedBox(height: 20),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}