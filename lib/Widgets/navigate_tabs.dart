import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'package:turf_trek/Screens/home_screen.dart';
import 'package:turf_trek/Screens/profile_screen.dart';
import 'package:turf_trek/Screens/booking_list_screen.dart';

class NavigateTabs extends StatefulWidget {
  final String customerId;
  final String customerName;
  final String mobileNum;

  const NavigateTabs({
    super.key,
    required this.customerId,
    required this.customerName,
    required this.mobileNum,
  });

  @override
  State<NavigateTabs> createState() => _NavigateTabsState();
}

class _NavigateTabsState extends State<NavigateTabs> {
  int _selectedIndex = 1;

  final List<Widget> _pages = [];

  @override
  void initState() {
    super.initState();

    _pages.add(BookingListScreen(
      customerId: widget.customerId,
      customerName: widget.customerName,
      mobileNum: widget.mobileNum,
    ));
    _pages.add(HomeScreen(
      customerId: widget.customerId,
      customerName: widget.customerName,
      mobileNum: widget.mobileNum,
    ));
    _pages.add(UserProfile(
      customerId: widget.customerId,
      customerName: widget.customerName,
      mobileNum: widget.mobileNum,
    ));
  }

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
      print('Customer ID: ${widget.customerId}');
      // print('Customer Name: $_customerName');
      // print('Mobile Number: $_mobileNum');
    });
  }

  Widget _buildBottomNavigationBarItem(IconData icon, bool isSelected) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        if (isSelected)
          Container(
            height: 4,
            width: 40,
            decoration: BoxDecoration(
                color: Colors.green.shade900,
                borderRadius: BorderRadius.circular(5)),
          ),
        Icon(
          icon,
          color: isSelected ? Colors.green.shade900 : Colors.grey,
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _pages[_selectedIndex],
      bottomNavigationBar: BottomNavigationBar(
        elevation: 0.0,
        backgroundColor: Colors.green.withOpacity(0.1),
        currentIndex: _selectedIndex,
        onTap: _onItemTapped,
        items: [
          BottomNavigationBarItem(
            icon: _buildBottomNavigationBarItem(
              Icons.calendar_month,
              _selectedIndex == 0,
            ),
            label: 'Bookings',
          ),
          BottomNavigationBarItem(
            icon: _buildBottomNavigationBarItem(
              Icons.sports_volleyball_sharp,
              _selectedIndex == 1,
            ),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: _buildBottomNavigationBarItem(
              Icons.person,
              _selectedIndex == 2,
            ),
            label: 'Profile',
          ),
        ],
      ),
    );
  }
}
