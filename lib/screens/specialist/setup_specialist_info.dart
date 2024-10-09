import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:wetalk_application_2/screens/specialist/admin_dashboard.dart';

void main() {
  runApp(const SetupInformation());
}

class SetupInformation extends StatelessWidget {
  const SetupInformation({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      debugShowCheckedModeBanner: false,
      home: SetupInformationScreen(),
    );
  }
}

class SetupInformationScreen extends StatefulWidget {
  const SetupInformationScreen({super.key});

  @override
  _SetupInformationScreenState createState() => _SetupInformationScreenState();
}

class _SetupInformationScreenState extends State<SetupInformationScreen> {
  // Controllers for input fields
  final _nameController = TextEditingController();
  final _specializationController = TextEditingController();
  final _experienceController = TextEditingController();
  final _descriptionController = TextEditingController();
  final _locationController = TextEditingController();

  // Map to store availability
  final Map<String, TimeOfDayRange> _availability = {
    "Monday": TimeOfDayRange(start: const TimeOfDay(hour: 9, minute: 0), end: const TimeOfDay(hour: 17, minute: 0)),
    "Tuesday": TimeOfDayRange(start: const TimeOfDay(hour: 9, minute: 0), end: const TimeOfDay(hour: 17, minute: 0)),
    "Wednesday": TimeOfDayRange(start: const TimeOfDay(hour: 9, minute: 0), end: const TimeOfDay(hour: 17, minute: 0)),
    "Thursday": TimeOfDayRange(start: const TimeOfDay(hour: 9, minute: 0), end: const TimeOfDay(hour: 17, minute: 0)),
    "Friday": TimeOfDayRange(start: const TimeOfDay(hour: 9, minute: 0), end: const TimeOfDay(hour: 17, minute: 0)),
  };

  bool _isSubmitting = false; // To track submission status

  // Function to handle time selection
  Future<void> _selectTime(BuildContext context, String day) async {
    TimeOfDay? start = await showTimePicker(
      context: context,
      initialTime: _availability[day]?.start ?? TimeOfDay.now(),
    );
    if (start == null) return; // Handle if the user cancels

    TimeOfDay? end = await showTimePicker(
      context: context,
      initialTime: _availability[day]?.end ?? TimeOfDay.now(),
    );
    if (end == null) return; // Handle if the user cancels

    setState(() {
      _availability[day] = TimeOfDayRange(start: start, end: end);
    });
  }

  // Function to validate input fields
  bool _validateInputs() {
    if (_nameController.text.isEmpty ||
        _specializationController.text.isEmpty ||
        _experienceController.text.isEmpty ||
        _descriptionController.text.isEmpty ||
        _locationController.text.isEmpty) {
      return false;
    }
    return true;
  }

  // Function to submit profile information to Firebase
  void _submitProfile() async {
    if (_isSubmitting) return; 
    if (!_validateInputs()) {
      ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text("Please fill in all fields.")));
      return; 
    }

    setState(() {
      _isSubmitting = true; 
    });

    // Convert availability to a map of strings
    Map<String, Map<String, String>> availabilityData = {};
    _availability.forEach((day, timeRange) {
      availabilityData[day] = {
        "start_time": timeRange.start.format(context),
        "end_time": timeRange.end.format(context),
      };
    });

    // Save data to Firestore
    try {
      await FirebaseFirestore.instance.collection('specialists').add({
        'name': _nameController.text,
        'specialization': _specializationController.text,
        'years_of_experience': int.parse(_experienceController.text),
        'description': _descriptionController.text,
        'location': _locationController.text,
        'availability': availabilityData,
      });
      ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text("Profile setup successfully!")));
      Navigator.push(
          context,
          MaterialPageRoute(
              builder: (context) => const AdminDashboard()));
    } catch (error) {
      ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text("Error saving profile: $error")));
    } finally {
      setState(() {
        _isSubmitting = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.blue[600],
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.white),
          onPressed: () {
            Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) => const AdminDashboard()));
          },
        ),
        title: const Text(
          'Setup Information',
          style: TextStyle(color: Colors.white), 
        ),
      ),
      body: Center(
        child: Container(
          width: MediaQuery.of(context).size.width * 0.9,
          padding: const EdgeInsets.all(16.0),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(10.0),
            boxShadow: const [
              BoxShadow(
                color: Colors.black12,
                blurRadius: 10.0,
                spreadRadius: 1.0,
              ),
            ],
          ),
          child: ListView(
            children: [
              const Text(
                'Your Information',
                style: TextStyle(
                  fontSize: 20.0,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 16.0),
              TextField(
                controller: _nameController,
                decoration: const InputDecoration(
                  labelText: 'Full Name',
                  border: OutlineInputBorder(),
                ),
              ),
              const SizedBox(height: 16.0),
              TextField(
                controller: _specializationController,
                decoration: const InputDecoration(
                  labelText: 'Specialization',
                  border: OutlineInputBorder(),
                ),
              ),
              const SizedBox(height: 16.0),
              TextField(
                controller: _experienceController,
                decoration: const InputDecoration(
                  labelText: 'Years of experience',
                  border: OutlineInputBorder(),
                ),
              ),
              const SizedBox(height: 16.0),
              TextField(
                maxLines: 4,
                controller: _descriptionController,
                decoration: const InputDecoration(
                  labelText: 'About You',
                  border: OutlineInputBorder(),
                ),
              ),
              const SizedBox(height: 16.0),
              TextField(
                controller: _locationController,
                decoration: const InputDecoration(
                  labelText: 'Location (Map Link)',
                  border: OutlineInputBorder(),
                ),
              ),
              const SizedBox(height: 16.0),
              const Text('Availability:', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
              ..._availability.keys.map((day) {
                return ListTile(
                  title: Text(day),
                  subtitle: Text('${_availability[day]!.start.format(context)} - ${_availability[day]!.end.format(context)}'),
                  trailing: IconButton(
                    icon: const Icon(Icons.edit),
                    onPressed: () => _selectTime(context, day),
                  ),
                );
              }),
              const SizedBox(height: 24.0),
              ElevatedButton(
                onPressed: _submitProfile,
                child: const Text('Submit Profile'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class TimeOfDayRange {
  final TimeOfDay start;
  final TimeOfDay end;

  TimeOfDayRange({required this.start, required this.end});
}
