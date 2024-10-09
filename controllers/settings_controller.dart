import 'package:get/get.dart';
import 'package:firebase_auth/firebase_auth.dart';


class SettingsController extends GetxController {
  var isLoading = false.obs;
  var currentUser = FirebaseAuth.instance.currentUser;
  var username = ''.obs;
  var email = ''.obs; 

   getUserData() async{
    DocumentSnapshot<Map<String,dynamic>> user =
      await FirebaseFirestore.intance.collection('users').doc(currentUser?.uid).get();
    var userData = user.data()
    username = userData['fullname'];
   }
}