import 'package: get/get.dart';

class HomeController extends GetxController{
     var isloading = false.obs;

     Future<QuerySnapshot<Map<String,dynamic>>> getDoctorList() async{
       
      var doctors = await FirebaseFirestore.instance.collection('doctors').get();
      return doctors
     }
  }