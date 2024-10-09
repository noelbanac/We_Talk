import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:wetalk_application_2/screens/choose_login.dart'; 
import 'package:wetalk_application_2/utils/config.dart';
import 'package:wetalk_application_2/utils/layout.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized(); 
  await Firebase.initializeApp(); 
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'WeTalk Appointment Booking App',
      transitionDuration: const Duration(milliseconds: 500),
      defaultTransition: Transition.fade,
      theme: ThemeData(
        inputDecorationTheme: const InputDecorationTheme(
          focusColor: Config.primaryColor,
          border: Config.outlinedBorder,
          focusedBorder: Config.focusBorder,
          errorBorder: Config.errorBorder,
          enabledBorder: Config.outlinedBorder,
          floatingLabelStyle: TextStyle(color: Config.primaryColor),
          prefixIconColor: Colors.black38,
        ),
        scaffoldBackgroundColor: Colors.white,
        bottomNavigationBarTheme: BottomNavigationBarThemeData(
          backgroundColor: Config.primaryColor,
          selectedItemColor: Colors.white,
          showSelectedLabels: true,
          showUnselectedLabels: false,
          unselectedItemColor: Colors.grey.shade700,
          elevation: 10,
          type: BottomNavigationBarType.fixed,
        ),
      ),


      initialRoute: '/login',
      routes: {
        // '/': (context) => const AuthSelector(),
        '/login': (context) => const AdminOrClient(),
        'main': (context) => const MainLayout(),
        // 'booking_page': (context) => BookingPage(),
        // 'success_booking': (context) => const AppointmentBooked(),
      },
    );
  }
}
