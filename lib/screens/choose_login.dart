import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:wetalk_application_2/screens/client/login_client.dart';
import 'package:wetalk_application_2/screens/specialist/login_specialist.dart';
import 'package:wetalk_application_2/styles/colors.dart';

void main() {
  runApp(const AdminOrClient());
}

class AdminOrClient extends StatelessWidget {
  const AdminOrClient({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      debugShowCheckedModeBanner: false,
      home: HomePage(),
    );
  }
}

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        fit: StackFit.expand,
        children: [
          Image.asset(
            'assets/intro_image.jpg',
            fit: BoxFit.cover,
          ),
          Container(
            color: Colors.black.withOpacity(0.6),
          ),
          Center(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 40),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Text( 
                    'WeTalk',
                    style: TextStyle(
                      fontSize: 60,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                      fontFamily: 'Poppins',
                    ),
                  ),
                  const SizedBox(height: 10),
                  const Text(
                    'Get the guidance you need, conveniently.',
                    style: TextStyle(
                      fontSize: 14,
                      color: Colors.white,
                      fontFamily: 'Poppins',
                      fontWeight: FontWeight.bold,
                    ),
                    textAlign: TextAlign.center,
                  ),
                  const SizedBox(height: 20),
                  const Text(
                    'Hey there! Feeling lost or just need some guidance? WeTalk makes it easier than ever to connect with your counselor. Schedule appointment online in just a few class, on your time!',
                    style: TextStyle(
                      fontSize: 12,
                      color: Colors.white,
                      fontFamily: 'Poppins',
                      fontWeight: FontWeight.w400,
                    ),
                    textAlign: TextAlign.center,
                  ),
                  const SizedBox(height: 170),
                  ElevatedButton(
                    onPressed: () async {
                                Get.to(() => const LoginPageSpecialist());
                              },
                    style: ElevatedButton.styleFrom(
                      foregroundColor: Colors.white,
                      backgroundColor: Color(MyColors.primary),
                      padding: const EdgeInsets.symmetric(horizontal: 40, vertical: 20),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(25),
                      ),
                    ),
                    child: const Text(
                      'SPECIALIST',
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                        fontFamily: 'Poppins',
                      ),
                    ),
                  ),
                  const SizedBox(height: 30),
                  ElevatedButton(
                    onPressed: () async {
                                Get.to(() => const LoginPageClient());
                              },
                    style: ElevatedButton.styleFrom(
                      foregroundColor: Colors.white,
                      backgroundColor: Color(MyColors.primary),
                      padding: const EdgeInsets.symmetric(horizontal: 40, vertical: 20),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(25),
                      ),
                    ),
                    child: const Text(
                      'CLIENT',
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                        fontFamily: 'Poppins',
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}