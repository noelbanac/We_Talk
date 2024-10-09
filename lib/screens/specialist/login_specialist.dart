import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:wetalk_application_2/screens/client/register_client.dart';
import 'package:wetalk_application_2/screens/specialist/admin_dashboard.dart';
import 'package:wetalk_application_2/styles/button.dart';
import 'package:wetalk_application_2/styles/colors.dart';
import 'package:wetalk_application_2/utils/config.dart';
import 'package:get/get.dart';

class LoginPageSpecialist extends StatefulWidget {
  const LoginPageSpecialist({super.key});

  @override
  State<LoginPageSpecialist> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPageSpecialist> {
  final _formKey = GlobalKey<FormState>();
  final _emailController = TextEditingController();
  final _passController = TextEditingController();
  bool obsecurePass = true;

  Future<void> signIn() async {
    try {
      // Sign in with Firebase Authentication
      UserCredential userCredential = await FirebaseAuth.instance.signInWithEmailAndPassword(
        email: _emailController.text.trim(),
        password: _passController.text.trim(),
      );

      // Get the signed-in user's email
      String email = userCredential.user?.email ?? '';

      // Logic to check if the user is a specialist
      if (email.endsWith('@wetalk.com')) {
        // If the email matches the specialist pattern, navigate to the AdminDashboard
        Get.to(() => const AdminDashboard());
      } else {
        // If not, show an error message and sign out
        await FirebaseAuth.instance.signOut();
        Get.snackbar(
          'Access Denied',
          'Only specialists with @wetalk.com email can log in.',
          snackPosition: SnackPosition.BOTTOM,
          backgroundColor: Colors.red,
          colorText: Colors.white,
        );
      }
    } on FirebaseAuthException catch (e) {
      if (e.code == 'user-not-found') {
        Get.snackbar(
          'Login Failed',
          'No user found for this email.',
          snackPosition: SnackPosition.BOTTOM,
          backgroundColor: Colors.red,
          colorText: Colors.white,
        );
      } else if (e.code == 'wrong-password') {
        Get.snackbar(
          'Login Failed',
          'Incorrect password provided.',
          snackPosition: SnackPosition.BOTTOM,
          backgroundColor: Colors.red,
          colorText: Colors.white,
        );
      } else {
        Get.snackbar(
          'Login Error',
          'Email or password is incorrect. Try again.',
          snackPosition: SnackPosition.BOTTOM,
          backgroundColor: Colors.red,
          colorText: Colors.white,
        );
      }
    } catch (e) {
      Get.snackbar(
        'Error',
        'An unexpected error occurred. Please try again.',
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: Colors.red,
        colorText: Colors.white,
      );
      print("Error: $e");
    }
  }

  @override
  void dispose() {
    _emailController.dispose();
    _passController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          buildBackground(context),
          Center(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20.0),
              child: ConstrainedBox(
                constraints: const BoxConstraints(
                  maxWidth: 400,
                  maxHeight: 450,
                ),
                child: Card(
                  color: Colors.white.withOpacity(0.8),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(15.0),
                  ),
                  elevation: 5,
                  child: Padding(
                    padding: const EdgeInsets.all(20.0),
                    child: Form(
                      key: _formKey,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[
                          Text(
                            "SIGN IN",
                            style: TextStyle(
                              color: Color(MyColors.primary),
                              fontSize: 36,
                              fontWeight: FontWeight.w700,
                            ),
                          ),
                          const SizedBox(height: 60),
                          // User email input
                          TextFormField(
                            controller: _emailController,
                            keyboardType: TextInputType.emailAddress,
                            cursorColor: Config.primaryColor,
                            decoration: const InputDecoration(
                              hintText: 'Type your email address here',
                              labelText: 'Email address',
                              alignLabelWithHint: true,
                              prefixIcon: Icon(Icons.email_outlined),
                            ),
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return 'Please enter your email';
                              } else if (!RegExp(r'^[^@]+@[^@]+\.[^@]+').hasMatch(value)) {
                                return 'Please enter a valid email address';
                              }
                              return null;
                            },
                          ),
                          Config.spaceSmall,
                          // Password input
                          TextFormField(
                            controller: _passController,
                            keyboardType: TextInputType.visiblePassword,
                            cursorColor: Config.primaryColor,
                            obscureText: obsecurePass,
                            decoration: InputDecoration(
                              hintText: 'Type your password here',
                              labelText: 'Password',
                              alignLabelWithHint: true,
                              prefixIcon: const Icon(Icons.lock_outline),
                              suffixIcon: IconButton(
                                onPressed: () {
                                  setState(() {
                                    obsecurePass = !obsecurePass;
                                  });
                                },
                                icon: obsecurePass
                                    ? const Icon(
                                        Icons.visibility_off_outlined,
                                        color: Colors.black38,
                                      )
                                    : const Icon(
                                        Icons.visibility_outlined,
                                        color: Config.primaryColor,
                                      ),
                              ),
                            ),
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return 'Please enter your password';
                              } else if (value.length < 6) {
                                return 'Password must be at least 6 characters long';
                              }
                              return null;
                            },
                          ),
                          Config.spaceVerySmall,
                          // Sign in button
                          Button(
                            width: double.infinity,
                            title: 'Sign In',
                            onPressed: () async {
                              if (_formKey.currentState!.validate()) {
                                await signIn(); // Attempt sign-in and handle errors
                              }
                            },
                            disable: false,
                          ),
                          const SizedBox(height: 7),
                          // Register redirect button
                          TextButton(
                            onPressed: () {
                              Get.to(() => const SignUpPage());
                            },
                            child: const Text(
                              "Don't have an account? Register here.",
                              style: TextStyle(
                                color: Colors.blue,
                                fontSize: 12,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget buildBackground(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        image: DecorationImage(
          image: const AssetImage("assets/intro_image.jpg"),
          fit: BoxFit.cover,
          colorFilter: ColorFilter.mode(
            Colors.black.withOpacity(1), // Change opacity to 0.6
            BlendMode.dstATop,
          ),
        ),
      ),
      child: const Scaffold(
        backgroundColor: Colors.black45,
      ),
    );
  }
}