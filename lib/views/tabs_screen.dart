import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:qurani_22/views/tabs_screen/screens/foryou_page_screen.dart';
import 'package:qurani_22/views/tabs_screen/screens/home_page.dart';
import 'package:qurani_22/views/tabs_screen/screens/quran_page.dart';


class TabsScreen extends StatefulWidget {
  const TabsScreen({super.key});

  @override
  State<TabsScreen> createState() => _TabsScreenState();
}

class _TabsScreenState extends State<TabsScreen> {
  int _selectedIndex = 0;

  final List<Widget> _pages = const [
    HomePage(),
    QuranPage(),
    ForyouPageScreen(),
  ];
  void _onTabTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: _pages[_selectedIndex],
        bottomNavigationBar: BottomNavigationBar(
          backgroundColor: Colors.white,
          currentIndex: _selectedIndex,
          onTap: _onTabTapped,
          selectedItemColor: Colors.blue,
          unselectedItemColor: Colors.grey,
          showSelectedLabels: false,
          showUnselectedLabels: false,
          items: [
            BottomNavigationBarItem(
              icon: SvgPicture.asset('assets/images/home.svg'),
              label: 'الرئيسية',
              activeIcon: SvgPicture.asset('assets/images/homeActive.svg'),
            ),
            BottomNavigationBarItem(
              icon: SvgPicture.asset('assets/images/mushaf.svg'),
              label: 'القرآن',
              activeIcon: SvgPicture.asset('assets/images/mushaf.svg'), // Add this
            ),
            BottomNavigationBarItem(
              icon: SvgPicture.asset('assets/images/light.svg'),
              label: 'الإعدادات',
              activeIcon: SvgPicture.asset('assets/images/lightActive.svg'),
            ),
          ],
        ),
      ),
    );
  }
}
