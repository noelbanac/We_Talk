import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_state_manager/src/simple/get_controllers.dart';
import 'package:wetalk_application_2/screens/client/home.dart';

class AuthController extends GetxController {

  var fullnameController = TextEditingController();
  var emailController = TextEditingController();
  var passwordController = TextEditingController();

  //doctor editing controllers
  var aboutController = TextEditingController();
  var addressController = TextEditingController();
  var servicesController = TextEditingController();
  var timingController = TextEditingController();
  var phoneController = TextEditingController(); 
  var categoryController = TextEditingController();

  UserCredential? userCredential;

  isUserAlreadyLoggedIn() async {
    FirebaseAuth.instance.authStateChanges().listen((User? user) async{
      if(user!=null){
        var data = await FirebaseFirestore.instance.collection('doctors').doc(user.uid).get();
        var isDoc = data.data()?.containsKey('docName') ?? false;

        if(isDoc) {
          Get.offAll(()=> const AppointmentView());
        }else {
          Get.offAll(()=> const Home());
        }
      } else {
        Get.offAll(()=> const LoginView());
      }
    });
  }

  loginUser() async {
    userCredential = await FirebaseAuth.instance.
      signInWithEmailAndPassword(email: emailController.text, password: passwordController.text);
  }

  signUpUser() async {
    userCredential = await FirebaseAuth.instance
        .createUserWithEmailAndPassword(email: emailController.text, password: passwordController.text);
      await storeUserData(userCredential!.user!.uid, fullnameController.text, emailController.text);
    }

    storeUserData(String uid, String fullname, String email, bool isDoctor) async {
      var store = FirebaseFirestore.instance.collection(isDoctor ? 'doctors' : 'users').doc(uid);
      if (isDoctor) {
        await store.set({
          'docAbout': aboutController.text,
          'docAddress': addressController.text,
          'docCategory' : categoryController.text,
          'docName' : fullName,
          'docPhone' : phoneController.text,
          'docService' : servicesController.text,
          'docTiming' : timingController.text,
          'docId' : FirebaseAuth.instance.currentUser.uid,
          'docRating' : 1,
          'docEmail' : email,
        });
      }
      await store.set({
      'fullname': fullname,
      'email': email,
    });

    signout() async {
      await FirebaseAuth.instance.signOut();
    }
  }
}