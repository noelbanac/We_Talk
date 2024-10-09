import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:wetalk_application_2/screens/client/hometab.dart';
import 'package:wetalk_application_2/screens/client/profiletab.dart';
import 'package:wetalk_application_2/screens/client/scheduletab.dart';
import 'package:wetalk_application_2/screens/client/login_client.dart';
import 'package:wetalk_application_2/styles/colors.dart';

class Home extends StatefulWidget {
  const Home({super.key});
  
  Widget build(BuildContext context){
    return Scaffold(
      body: StreamBuilder<User?>(
        stream: FirebaseAuth.instance.authStateChanges(),
        builder: (context, snapshot){
          if(snapshot.hasData){
            return const Home();
          }else{
            return const LoginPageClient();
          }
        }
      )
    );
  }

  @override
  HomeState createState() => HomeState();
}

List<Map> navigationBarItems = [
  {'icon': Icons.local_hospital, 'index': 0},
  {'icon': Icons.calendar_today, 'index': 1},
  {'icon': Icons.person, 'index': 2},
];

class HomeState extends State<Home> {
  int _selectedIndex = 0;

  void goToSchedule() {
    setState(() {
      _selectedIndex = 1;
    });
  }

  @override
  Widget build(BuildContext context) {
    List<Widget> screens = [
      HomeTab(
        onPressedScheduleCard: goToSchedule,
      ),
      const ScheduleTab(),
      const ProfileTab(),
    ];

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color(MyColors.primary),
        elevation: 0,
        toolbarHeight: 0,
      ),
      body: SafeArea(
        child: screens[_selectedIndex],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          
        },  
        backgroundColor: Color(MyColors.primary),
        child: const Icon(Icons.add),  
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.endFloat, 
      bottomNavigationBar: BottomNavigationBar(
        selectedFontSize: 0,
        selectedItemColor: Color(MyColors.primary),
        showSelectedLabels: false,
        showUnselectedLabels: false,
        items: [
          for (var navigationBarItem in navigationBarItems)
            BottomNavigationBarItem(
              icon: Container(
                height: 55,
                decoration: BoxDecoration(
                  border: Border(
                    top: _selectedIndex == navigationBarItem['index']
                        ? BorderSide(color: Color(MyColors.darkturq), width: 5)
                        : BorderSide.none,
                  ),
                ),
                child: Icon(
                  navigationBarItem['icon'],
                  color: _selectedIndex == navigationBarItem['index']
                      ? Color(MyColors.darkturq)
                      : Color(MyColors.paleturq),
                ),
              ),
              label: '',
            ),
        ],
        currentIndex: _selectedIndex,
        onTap: (value) => setState(() {
          _selectedIndex = value;
        }),
      ),
    );
  }
}
