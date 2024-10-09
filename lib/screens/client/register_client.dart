import 'package:flutter/material.dart';
import 'package:wetalk_application_2/screens/client/login_client.dart';
import 'package:wetalk_application_2/styles/button.dart'; 
import 'package:wetalk_application_2/utils/config.dart';
import 'package:get/get.dart';
import 'package:firebase_auth/firebase_auth.dart';  // Import Firebase Auth package

class SignUpPage extends StatelessWidget {
  const SignUpPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          buildBackground(context),
          Padding(
            padding: const EdgeInsets.all(20.0),
            child: Center(
              child: SingleChildScrollView(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    SizedBox(
                      width: 350,
                      height: 530,
                      child: Card(
                        elevation: 5.0,
                        color: Colors.white.withOpacity(0.9),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(15.0),
                        ),
                        child: Padding(
                          padding: const EdgeInsets.all(20.0),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              const Text(
                                'Register',
                                style: TextStyle(
                                  fontSize: 24,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              const SizedBox(height: 20),
                              const Expanded(
                                child: RegisterForm(),
                              ),
                              Center(
                                child: TextButton(
                                  onPressed: () {
                                    Get.to(() => const LoginPageClient());
                                  },
                                  child: const Text(
                                    "Already have an account? Log In now",
                                    style: TextStyle(
                                      color: Colors.blue,
                                      decoration: TextDecoration.underline,
                                    ),
                                  ),
                                ),
                              )
                            ],
                          ),
                        ),
                      ),
                    ),
                  ],
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
            Colors.black.withOpacity(1),
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

class RegisterForm extends StatefulWidget {
  const RegisterForm({super.key});

  @override
  State<RegisterForm> createState() => _RegisterFormState();
}

class _RegisterFormState extends State<RegisterForm> {
  final _formKey = GlobalKey<FormState>();
  final _nameController = TextEditingController();
  final _emailController = TextEditingController();
  final _passController = TextEditingController();
  final _confirmPassController = TextEditingController(); 
  bool obsecurePass = true;

  @override
  void dispose() {
    _nameController.dispose();
    _emailController.dispose();
    _passController.dispose();
    _confirmPassController.dispose();
    super.dispose();
  }

  Future<void> signUp() async {
    try {
      // Create a new user using Firebase
      await FirebaseAuth.instance.createUserWithEmailAndPassword(
        email: _emailController.text.trim(),
        password: _passController.text.trim(),
      );

      // If sign-up successful, navigate to login
      Get.snackbar(
        'Sign Up Successful',
        'Your account has been created. Please log in.',
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: Colors.green,
        colorText: Colors.white,
      );
      Get.to(() => const LoginPageClient());

    } on FirebaseAuthException catch (e) {
      // Handle Firebase errors
      if (e.code == 'weak-password') {
        Get.snackbar(
          'Sign Up Failed',
          'The password provided is too weak.',
          snackPosition: SnackPosition.BOTTOM,
          backgroundColor: Colors.red,
          colorText: Colors.white,
        );
      } else if (e.code == 'email-already-in-use') {
        Get.snackbar(
          'Sign Up Failed',
          'An account already exists for that email.',
          snackPosition: SnackPosition.BOTTOM,
          backgroundColor: Colors.red,
          colorText: Colors.white,
        );
      } else {
        Get.snackbar(
          'Sign Up Error',
          'An unexpected error occurred. Please try again.',
          snackPosition: SnackPosition.BOTTOM,
          backgroundColor: Colors.red,
          colorText: Colors.white,
        );
      }
    } catch (e) {
      Get.snackbar(
        'Error',
        'An unexpected error occurred. Please try again later.',
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: Colors.red,
        colorText: Colors.white,
      );
      print('Error: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: <Widget>[
          TextFormField(
            controller: _nameController,
            keyboardType: TextInputType.text,
            cursorColor: Config.primaryColor,
            decoration: const InputDecoration(
              hintText: 'Type your display name here',
              labelText: 'Display Name',
              alignLabelWithHint: true,
              prefixIcon: Icon(Icons.person_outlined),
              prefixIconColor: Colors.grey,
            ),
            validator: (value) {
              if (value == null || value.isEmpty) {
                return 'Please enter your name';
              }
              return null;
            },
          ),
          Config.spaceSmall,
          TextFormField(
            controller: _emailController,
            keyboardType: TextInputType.emailAddress,
            cursorColor: Config.primaryColor,
            decoration: const InputDecoration(
              hintText: 'Enter your email address here',
              labelText: 'Email address',
              alignLabelWithHint: true,
              prefixIcon: Icon(Icons.email_outlined),
              prefixIconColor: Colors.grey,
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
          TextFormField(
            controller: _passController,
            keyboardType: TextInputType.visiblePassword,
            cursorColor: Config.primaryColor,
            obscureText: obsecurePass,
            decoration: InputDecoration(
              hintText: 'Create a strong password',
              labelText: 'Password',
              alignLabelWithHint: true,
              prefixIcon: const Icon(Icons.lock_outline),
              prefixIconColor: Colors.grey,
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
                        color: Colors.grey,
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
          Config.spaceSmall,
          TextFormField(
            controller: _confirmPassController, 
            keyboardType: TextInputType.visiblePassword,
            cursorColor: Config.primaryColor,
            obscureText: obsecurePass,
            decoration: InputDecoration(
              hintText: 'Enter your password again',
              labelText: 'Confirm Password',
              alignLabelWithHint: true,
              prefixIcon: const Icon(Icons.lock_outline),
              prefixIconColor: Colors.grey,
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
                        color: Colors.grey,
                      ),
              ),
            ),
            validator: (value) {
              if (value != _passController.text) {
                return 'Passwords do not match';
              }
              return null;
            },
          ),
          Config.spaceSmall,
          Button(
            width: double.infinity,
            title: 'Sign Up',
            onPressed: () async {
              if (_formKey.currentState!.validate()) {
                await signUp();  // Call signUp method to handle Firebase registration
              }
            },
            disable: false,
          ),
        ],
      ),
    );
  }
}
