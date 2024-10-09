import 'package:flutter/material.dart';
import 'package:wetalk_application_2/screens/client/counsel_details.dart';
import 'package:wetalk_application_2/screens/client/profiletab.dart';
import 'package:wetalk_application_2/screens/client/scheduletab.dart';
import 'package:wetalk_application_2/styles/colors.dart';
import 'package:wetalk_application_2/styles/styles.dart';
import 'package:get/get.dart';

List<Map<String, String>> doctors = [
  {
    'img': 'assets/person_4.jpg',
    'counselorName': 'Maria Clara Santos',
    'title': 'Licensed Psychologist',
  },
  {
    'img': 'assets/person_3.jpg',
    'counselorName': 'Josefina "Josie" de la Cruz',
    'title': 'Mental Health Counselor',
  },
  {
    'img': 'assets/person_2.jpg',
    'counselorName': 'Ramonito "Ramon" Reyes',
    'title': 'Clinical Psychologist',
  },
  {
    'img': 'assets/person_5.jpg',
    'counselorName': 'Lourdes "Ludy" Villanueva',
    'title': 'Psychotherapist',
  },
];

class HomeTab extends StatelessWidget {
  final void Function() onPressedScheduleCard;

  const HomeTab({
    super.key,
    required this.onPressedScheduleCard,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: GestureDetector(
        onTap: () => FocusScope.of(context).unfocus(),
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 30),
          child: ListView(
            children: [
              const SizedBox(height: 20),
              const UserIntro(),
              const SizedBox(height: 10),
              const SearchInput(),
              const SizedBox(height: 20),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text('Your next appointment', style: kTitleStyle),
                  TextButton(
                    child: Text(
                      'See All',
                      style: TextStyle(
                        color: Color(MyColors.goldrod),
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    onPressed: () {
                      Get.to(() => const ScheduleTab());
                    },
                  ),
                ],
              ),
              const SizedBox(height: 20),
              AppointmentCard(onTap: onPressedScheduleCard),
              const SizedBox(height: 20),
              Text(
                'Persons who can help you',
                style: TextStyle(
                  color: Color(MyColors.header01),
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 20),
              ...doctors.map((doctor) => TopDoctorCard(
                    img: doctor['img']!,
                    counselorName: doctor['counselorName']!,
                    title: doctor['title']!,
                  )),
            ],
          ),
        ),
      ),
    );
  }
}

class TopDoctorCard extends StatelessWidget {
  final String img;
  final String counselorName;
  final String title;

  const TopDoctorCard({
    super.key,
    required this.img,
    required this.counselorName,
    required this.title,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.only(bottom: 20),
      child: InkWell(
        onTap: () async {
          Get.to(() => CounselorDetails(
                counselor: {
                  'img': img,
                  'name': counselorName,
                  'description': title,
                },
              ));
        },
        child: Row(
          children: [
            Container(
              width: 100,
              height: 100,
              color: Color(MyColors.grey01),
              child: ClipOval(
                child: Image.asset(
                  img,
                  width: 100,
                  height: 100,
                  fit: BoxFit.cover,
                ),
              ),
            ),
            const SizedBox(width: 10),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    counselorName,
                    style: TextStyle(
                      color: Color(MyColors.header01),
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                  const SizedBox(height: 5),
                  Text(
                    title,
                    style: TextStyle(
                      color: Color(MyColors.grey02),
                      fontSize: 12,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  const SizedBox(height: 5),
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Icon(
                        Icons.star,
                        color: Color(MyColors.yellow02),
                        size: 18,
                      ),
                      const SizedBox(width: 5),
                      Text(
                        '4.0 - 50 Reviews',
                        style: TextStyle(color: Color(MyColors.grey02)),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class AppointmentCard extends StatelessWidget {
  final void Function() onTap;

  const AppointmentCard({
    super.key,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          width: double.infinity,
          decoration: BoxDecoration(
            color: Color(MyColors.primary),
            borderRadius: BorderRadius.circular(10),
          ),
          child: Material(
            color: Colors.transparent,
            child: InkWell(
              onTap: onTap,
              child: Padding(
                padding: const EdgeInsets.all(20),
                child: Column(
                  children: [
                    Row(
                      children: [
                        const CircleAvatar(
                          backgroundImage: AssetImage('assets/person_1.jpg'),
                        ),
                        const SizedBox(width: 10),
                        Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const Text('Jose "Pepe" Alonzo',
                                style: TextStyle(color: Colors.white)),
                            const SizedBox(height: 2),
                            Text(
                              'Family Therapist',
                              style: TextStyle(color: Color(MyColors.bg)),
                            ),
                          ],
                        ),
                      ],
                    ),
                    const SizedBox(height: 20),
                    const ScheduleCard(),
                  ],
                ),
              ),
            ),
          ),
        ),
        Container(
          margin: const EdgeInsets.symmetric(horizontal: 20),
          width: double.infinity,
          height: 10,
          decoration: BoxDecoration(
            color: Color(MyColors.paleturq),
            borderRadius: const BorderRadius.only(
              bottomRight: Radius.circular(10),
              bottomLeft: Radius.circular(10),
            ),
          ),
        ),
        Container(
          margin: const EdgeInsets.symmetric(horizontal: 40),
          width: double.infinity,
          height: 10,
          decoration: BoxDecoration(
            color: Color(MyColors.bg03),
            borderRadius: const BorderRadius.only(
              bottomRight: Radius.circular(10),
              bottomLeft: Radius.circular(10),
            ),
          ),
        ),
      ],
    );
  }
}

class ScheduleCard extends StatelessWidget {
  const ScheduleCard({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Color(MyColors.bg),
        borderRadius: BorderRadius.circular(10),
      ),
      width: double.infinity,
      padding: const EdgeInsets.all(20),
      child: const Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Icon(
            Icons.calendar_today,
            color: Colors.black,
            size: 15,
          ),
          SizedBox(width: 5),
          Text(
            'Mon, July 29',
            style: TextStyle(color: Colors.black),
          ),
          SizedBox(width: 20),
          Icon(
            Icons.access_alarm,
            color: Colors.black,
            size: 17,
          ),
          SizedBox(width: 5),
          Flexible(
            child: Text(
              '11:00 ~ 12:10',
              style: TextStyle(color: Colors.black),
            ),
          ),
        ],
      ),
    );
  }
}

class UserIntro extends StatelessWidget {
  const UserIntro({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        const Text(
          'Hello, Noel!',
          style: TextStyle(
            fontSize: 24,
            fontWeight: FontWeight.bold,
          ),
        ),
        IconButton(
          icon: const CircleAvatar(
            backgroundImage: AssetImage('assets/profile_pic.jpg'),
          ),
          onPressed: () {
            Get.to(() => const ProfileTab());
          },
        )
      ],
    );
  }
}

class SearchInput extends StatelessWidget {
  const SearchInput({super.key});

  @override
  Widget build(BuildContext context) {
    return TextField(
      decoration: InputDecoration(
        hintText: 'Search...',
        prefixIcon: const Icon(Icons.search),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
          borderSide: const BorderSide(color: Colors.grey),
        ),
      ),
    );
  }
}
