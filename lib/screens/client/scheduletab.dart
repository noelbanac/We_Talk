import 'package:flutter/material.dart';
import 'package:wetalk_application_2/styles/colors.dart';
import 'package:wetalk_application_2/styles/styles.dart';


class ScheduleTab extends StatefulWidget {
  const ScheduleTab({super.key});

  @override
  State<ScheduleTab> createState() => _ScheduleTabState();
}

enum FilterStatus { upcoming, complete, cancel }

List<Map> schedules = [
  {
    'img': 'assets/person_1.jpg',
    'counselorName': 'Jose "Pepe" Alonzo',
    'title': 'Family Therapist',
    'dateSet': 'Monday, July 29',
    'timeSet': '11:00 - 12:10',
    'appointmentStatus': FilterStatus.upcoming
  },
  {
    'img': 'assets/person_4.jpg',
    'counselorName': 'Maria Clara Santos',
    'title': 'Licensed Psychologist',
    'dateSet': 'Sunday, Sep 29',
    'timeSet': '11:00 - 12:10',
    'appointmentStatus': FilterStatus.upcoming
  },
  {
    'img': 'assets/person_3.jpg',
    'counselorName': 'Josefina "Josie" de la Cruz',
    'title': 'Mental Health Counselor',
    'dateSet': 'Monday, Oct 20',
    'timeSet': '10:00 - 11:00',
    'appointmentStatus': FilterStatus.upcoming
  },
  {
    'img': 'assets/person_2.jpg',
    'counselorName': 'Ramonito "Ramon" Reyes',
    'title': 'Clinical Psychologist',
    'dateSet': 'Monday, June 15',
    'timeSet': '09:00 - 11:00',
    'appointmentStatus': FilterStatus.complete
  },
  {
    'img': 'assets/person_5.jpg',
    'counselorName': 'Lourdes "Ludy" Villanueva',
    'title': 'Psychotherapist',
    'dateSet': 'Monday, Jul 29',
    'timeSet': '11:00 - 12:00',
    'appointmentStatus': FilterStatus.cancel
  },
  {
    'img': 'assets/person_4.jpg',
    'counselorName': 'Maria Clara Santos',
    'title': 'Licensed Psychologist',
    'dateSet': 'Monday, Jun 15',
    'timeSet': '11:00 - 12:00',
    'appointmentStatus': FilterStatus.cancel
  },
];

class _ScheduleTabState extends State<ScheduleTab> {
  FilterStatus appointmentStatus = FilterStatus.upcoming;
  Alignment _alignment = Alignment.centerLeft;

  @override
  Widget build(BuildContext context) {
    List<Map> filteredSchedules = schedules.where((var schedule) {
      return schedule['appointmentStatus'] == appointmentStatus;
    }).toList();

    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.only(left: 30, top: 30, right: 30),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Text(
              'Schedule',
              textAlign: TextAlign.center,
              style: kTitleStyle,
            ),
            const SizedBox(
              height: 20,
            ),
            Stack(
              children: [
                Container(
                  width: double.infinity,
                  height: 40,
                  decoration: BoxDecoration(
                    color: Color(MyColors.bg),
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      for (FilterStatus filterStatus in FilterStatus.values)
                        Expanded(
                          child: GestureDetector(
                            onTap: () {
                              setState(() {
                                if (filterStatus == FilterStatus.upcoming) {
                                  appointmentStatus = FilterStatus.upcoming;
                                  _alignment = Alignment.centerLeft;
                                } else if (filterStatus ==
                                    FilterStatus.complete) {
                                  appointmentStatus = FilterStatus.complete;
                                  _alignment = Alignment.center;
                                } else if (filterStatus ==
                                    FilterStatus.cancel) {
                                  appointmentStatus = FilterStatus.cancel;
                                  _alignment = Alignment.centerRight;
                                }
                              });
                            },
                            child: Center(
                              child: Text(
                                filterStatus.name,
                                style: kFilterStyle,
                              ),
                            ),
                          ),
                        ),
                    ],
                  ),
                ),
                AnimatedAlign(
                  duration: const Duration(milliseconds: 200),
                  alignment: _alignment,
                  child: Container(
                    width: 100,
                    height: 40,
                    decoration: BoxDecoration(
                      color: Color(MyColors.primary),
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child: Center(
                      child: Text(
                        appointmentStatus.name,
                        style: const TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ),
                )
              ],
            ),
            const SizedBox(
              height: 20,
            ),
            Expanded(
              child: ListView.builder(
                itemCount: filteredSchedules.length,
                itemBuilder: (context, index) {
                  var schedule = filteredSchedules[index];
                  bool isLastElement = filteredSchedules.length + 1 == index;
                  return Card(
                    margin: !isLastElement
                        ? const EdgeInsets.only(bottom: 20)
                        : EdgeInsets.zero,
                    child: Padding(
                      padding: const EdgeInsets.all(15),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                        children: [
                          Row(
                            children: [
                              CircleAvatar(
                                backgroundImage: AssetImage(schedule['img']),
                              ),
                              const SizedBox(
                                width: 10,
                              ),
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    schedule['counselorName'],
                                    style: TextStyle(
                                      color: Color(MyColors.header01),
                                      fontWeight: FontWeight.w700,
                                    ),
                                  ),
                                  const SizedBox(
                                    height: 5,
                                  ),
                                  Text(
                                    schedule['title'],
                                    style: TextStyle(
                                      color: Color(MyColors.grey02),
                                      fontSize: 12,
                                      fontWeight: FontWeight.w600,
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                          const SizedBox(
                            height: 15,
                          ),
                          const DateTimeCard(),
                          const SizedBox(
                            height: 15,
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Expanded(
                                child: OutlinedButton(
                                  child: const Text('Cancel'),
                                  onPressed: () {},
                                ),
                              ),
                              const SizedBox(
                                width: 20,
                              ),
                              Expanded(
                                child: ElevatedButton(
                                  child: const Text('Reschedule'),
                                  onPressed: () => {},
                                ),
                              )
                            ],
                          )
                        ],
                      ),
                    ),
                  );
                },
              ),
            )
          ],
        ),
      ),
    );
  }
}

class DateTimeCard extends StatelessWidget {
  const DateTimeCard({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Color(MyColors.bg03),
        borderRadius: BorderRadius.circular(10),
      ),
      width: double.infinity,
      padding: const EdgeInsets.all(20),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
            children: [
              Icon(
                Icons.calendar_today,
                color: Color(MyColors.primary),
                size: 15,
              ),
              const SizedBox(
                width: 5,
              ),
              Text(
                'Mon, July 29',
                style: TextStyle(
                  fontSize: 12,
                  color: Color(MyColors.primary),
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
          Row(
            children: [
              Icon(
                Icons.access_alarm,
                color: Color(MyColors.primary),
                size: 17,
              ),
              const SizedBox(
                width: 5,
              ),
              Text(
                '11:00 ~ 12:10',
                style: TextStyle(
                  color: Color(MyColors.primary),
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          )
        ],
      ),
    );
  }
}
