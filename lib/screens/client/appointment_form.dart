import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:table_calendar/table_calendar.dart';
import 'package:wetalk_application_2/screens/client/appointment_confirm.dart';
import 'package:wetalk_application_2/utils/config.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class BookingPage extends StatefulWidget {
  final Map<String, dynamic> counselor; // Accept counselor data

  const BookingPage({super.key, required this.counselor}); // Update constructor

  @override
  State<BookingPage> createState() => _BookingPageState();
}

class _BookingPageState extends State<BookingPage> {
  final CalendarFormat _format = CalendarFormat.month;
  DateTime _focusDay = DateTime.now();
  DateTime? _selectedDay;
  final DateTime _currentDay = DateTime.now();
  int? _currentIndex;
  bool _isWeekend = false;
  bool _dateSelected = false;
  bool _timeSelected = false;

  @override
  Widget build(BuildContext context) {
    Config().init(context);
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.black.withOpacity(0.8), // Semi-transparent background
        elevation: 0, // Remove shadow
        title: const Text(
          'Appointment Form',
          style: TextStyle(
            color: Colors.white, // AppBar title color
          ),
        ),
        leading: IconButton(
          icon: const FaIcon(Icons.arrow_back_ios, color: Colors.white),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
      ),
      body: Stack(
        children: [
          // Background Image for the body
          Positioned.fill(
            child: Image.asset(
              'assets/intro_image.jpg', // Path to your background image
              fit: BoxFit.cover,
              color: Colors.black.withOpacity(0.6), // Apply opacity to the background image
              colorBlendMode: BlendMode.darken, // Use blend mode to darken the background
            ),
          ),
          CustomScrollView(
            slivers: <Widget>[
              SliverToBoxAdapter(
                child: Column(
                  children: <Widget>[
                    _counselorInfo(), // Display selected counselor info
                    _tableCalendar(),
                    const SizedBox(height: 25), // Space between calendar and time section
                    _selectTimeSection(), // Time selection section with box
                  ],
                ),
              ),
              SliverToBoxAdapter(
                child: Container(
                  padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 40), // Reduced vertical space
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: _dateSelected && _timeSelected
                          ? Colors.blue // Active button color
                          : Colors.grey, // Disabled button color
                      padding: const EdgeInsets.symmetric(vertical: 15),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                    ),
                    onPressed: (_dateSelected && _timeSelected)
                        ? () async {
                            // Save appointment to Firestore
                            await FirebaseFirestore.instance.collection('appointments').add({
                              'date': _selectedDay,
                              'time': '${_currentIndex! + 9}:00',
                              'counselor_id': widget.counselor['id'], // Save the counselor ID
                            });

                            // Example appointment logic
                            print('Appointment booked on $_selectedDay at ${_currentIndex! + 9}:00');
                            ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                              content: Text(
                                  'Appointment booked on $_selectedDay at ${_currentIndex! + 9}:00'),
                              action: SnackBarAction( // Add the SnackBarAction
                                label: 'View',
                                onPressed: () {
                                  // Navigate to AppointmentConfirmation page
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(builder: (context) => const AppointmentConfirmation()),
                                  );
                                },
                              ),
                            ));
                          }
                        : null, // Disable button if conditions are not met
                    child: const Text(
                      'Book Appointment',
                      style: TextStyle(
                        color: Colors.white, // Button text color
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _counselorInfo() {
    return Container(
      padding: const EdgeInsets.all(16),
      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 20),
      decoration: BoxDecoration(
        color: Colors.white.withOpacity(0.8),
        borderRadius: BorderRadius.circular(10),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Booking for: ${widget.counselor['name']}', // Display the counselor's name
            style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
          ),
          // You can add more counselor details here if needed
        ],
      ),
    );
  }

  Widget _tableCalendar() {
    return Column(
      children: [
        const Padding(
          padding: EdgeInsets.only(top: 20.0, bottom: 8.0), // Space between text and calendar
          child: Text(
            'PREFERRED DATE',
            style: TextStyle(
              fontWeight: FontWeight.w900,
              fontSize: 18,
              color: Colors.white, // Main text color
              shadows: [
                Shadow(offset: Offset(-1.5, -1.5), color: Colors.black),
                Shadow(offset: Offset(1.5, -1.5), color: Colors.black),
                Shadow(offset: Offset(1.5, 1.5), color: Colors.black),
                Shadow(offset: Offset(-1.5, 1.5), color: Colors.black),
              ],
            ),
          ),
        ),
        Container(
          padding: const EdgeInsets.all(10.0), // Optional: Add some padding inside the container
          margin: const EdgeInsets.symmetric(horizontal: 16.0), // Adjust this for space outside the box
          decoration: BoxDecoration(
            color: Colors.white.withOpacity(0.8), // Add white color with opacity to the calendar box
            border: Border.all(color: Colors.black), // Optional: Add border to the calendar box
            borderRadius: BorderRadius.circular(10), // Optional: Rounded corners for the box
          ),
          child: TableCalendar(
            focusedDay: _focusDay,
            firstDay: DateTime.now(),
            lastDay: DateTime.now().add(const Duration(days: 365)), // Last day one year from now
            calendarFormat: _format,
            currentDay: _currentDay,
            selectedDayPredicate: (day) {
              return isSameDay(_selectedDay, day);
            },
            onDaySelected: (selectedDay, focusedDay) {
              setState(() {
                _selectedDay = selectedDay;
                _focusDay = focusedDay;
                _isWeekend = selectedDay.weekday == DateTime.saturday || selectedDay.weekday == DateTime.sunday;
                if (_isWeekend) {
                  // Show a SnackBar if the selected day is a weekend
                  ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                    content: Text('Weekend is not available, please select another date'),
                  ));
                  _dateSelected = false; // Reset date selection if a weekend is chosen
                } else {
                  _dateSelected = true; // Set date selected only if it's not a weekend
                }
              });
            },
            rowHeight: 48,
            calendarStyle: const CalendarStyle(
              todayDecoration: BoxDecoration(
                color: Colors.blue, // Color for today's highlight
                shape: BoxShape.rectangle,
              ),
              selectedDecoration: BoxDecoration(
                color: Colors.green, // Color for selected date
                shape: BoxShape.rectangle,
              ),
              weekendTextStyle: TextStyle(color: Colors.red), // Style for weekend text
            ),
          ),
        ),
      ],
    );
  }
 Widget _selectTimeSection() {
  return Column(
    children: [
      const Padding(
        padding: EdgeInsets.only(top: 20.0, bottom: 8.0),
        child: Text(
          'PREFERRED TIME',
          style: TextStyle(
            fontWeight: FontWeight.w900,
            fontSize: 18,
            color: Colors.white,
            shadows: [
              Shadow(offset: Offset(-1.5, -1.5), color: Colors.black),
              Shadow(offset: Offset(1.5, -1.5), color: Colors.black),
              Shadow(offset: Offset(1.5, 1.5), color: Colors.black),
              Shadow(offset: Offset(-1.5, 1.5), color: Colors.black),
            ],
          ),
        ),
      ),
      Container(
        width: MediaQuery.of(context).size.width * 0.9, // Set width to 90% of screen width
        padding: const EdgeInsets.all(10.0),
        margin: const EdgeInsets.symmetric(horizontal: 16.0),
        decoration: BoxDecoration(
          color: Colors.white.withOpacity(0.8),
          border: Border.all(color: Colors.black),
          borderRadius: BorderRadius.circular(10),
        ),
        child: GridView.builder(
          shrinkWrap: true, // Allows the GridView to take only the required space
          physics: const NeverScrollableScrollPhysics(), // Disable scrolling
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 4, // Number of columns
            childAspectRatio: 1, // Adjust aspect ratio to make boxes square
            crossAxisSpacing: 10.0, // Space between columns
            mainAxisSpacing: 10.0, // Space between rows
          ),
          itemCount: 8, // Total number of time slots
          itemBuilder: (context, index) {
            int hour = index + 9; // Calculate hour (9:00 to 16:00)
            String timeString = (hour > 12)
                ? '${hour - 12}:00 PM'
                : (hour == 12 ? '12:00 PM' : '$hour:00 AM'); // Format to AM/PM

            return GestureDetector(
              onTap: () {
                setState(() {
                  _currentIndex = index;
                  _timeSelected = true; // Mark time as selected
                });
              },
              child: Container(
                decoration: BoxDecoration(
                  color: _currentIndex == index ? Colors.green : Colors.transparent, // Highlight selected time
                  borderRadius: BorderRadius.circular(8),
                  border: Border.all(color: Colors.black),
                ),
                child: Center(
                  child: Text(
                    timeString, // Display time in AM/PM format
                    textAlign: TextAlign.center, // Center align text
                    style: TextStyle(
                      color: _currentIndex == index ? Colors.white : Colors.black, // Text color changes based on selection
                    ),
                  ),
                ),
              ),
            );
          },
        ),
      ),
    ],
  );
}
}
