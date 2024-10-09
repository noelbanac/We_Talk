import '';

class AppointmentController extends GetController {
  var isLoading = false.obs;

  var appointmentDayController = TextEditingController();
  var appTimeController = TextEditingController();
  var appMobileController = TextEditingController();
  var appNameController = TextEditingController();
  var appMessageController = TextEditingController();

  bookAppointment(String docId, context) async {
    isLoading(true);

    var store = FirebaseFirestore.instance.collection('appointment').doc();
    await store.set({

      'appBy': FirebaseAuth.instance.currentUser?.uid,
      'appDay': appDayController.text,
      'appTime': appTimeController.text,
      'appMobile': appMobileController.text,
      'appName': appNameController.text,
      'appMsg': appMessageController.text,
      'appWith': docId,
    });
    isLoading(false);
    VxToast.show(context, msg: "Appointment is booked successfully!");
    Get.back();
  }

}
