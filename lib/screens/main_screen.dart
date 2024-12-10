import 'package:ecl_punchin/screens/punch_in_screen.dart';
import 'package:ecl_punchin/screens/punch_out_screen.dart';
import 'package:ecl_punchin/screens/settings_screen.dart';
import 'package:ecl_punchin/screens/time_card_screen.dart';
import 'package:ecl_punchin/utils/colors.dart';
import 'package:flutter/material.dart';

class MainScreen extends StatefulWidget {
  const MainScreen({super.key});

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  int currentPageIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: NavigationBar(
        backgroundColor: Colors.white,
        indicatorColor: kprimarycolor,
        onDestinationSelected: (int index) {
          setState(() {
            currentPageIndex = index;
          });
        },
        selectedIndex: currentPageIndex,
        destinations: const <Widget>[
          NavigationDestination(
            icon: Icon(Icons.punch_clock_outlined),
            selectedIcon: Icon(Icons.punch_clock),
            // icon: Image.asset("assets/images/clock.png"),
            label: 'Punch',
          ),
          NavigationDestination(
            icon: Icon(Icons.calendar_today_outlined),
            selectedIcon: Icon(Icons.calendar_today),
            // icon: Image.asset("assets/images/time_card.png"),
            label: 'Time Card',
          ),
          NavigationDestination(
            icon: Icon(Icons.settings_outlined),
            selectedIcon: Icon(Icons.settings),
            // icon: Image.asset("assets/images/gear.png"),
            label: 'Settings',
          ),
        ],
      ),
      body: <Widget>[
        const PunchIn(),
        const TimeCard(),
        const Settings(),
      ][currentPageIndex],
    );
  }
}
