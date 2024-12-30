import 'package:appstore/Screens/Cart.dart';
import 'package:appstore/Screens/Home_Page/HomePage.dart';
import 'package:appstore/Screens/SettingPage/SettingPage.dart';
import 'package:appstore/helper/DeviceDimenssions.dart';
import 'package:flutter/material.dart';

class BottomNavBarWithCenterButton extends StatefulWidget {
  @override
  _BottomNavBarWithCenterButtonState createState() =>
      _BottomNavBarWithCenterButtonState();
}

class _BottomNavBarWithCenterButtonState
    extends State<BottomNavBarWithCenterButton> {
  int _selectedIndex = 0;

  final List<Widget> _pages = [
    Homepage(), // index 0
    CartPage(), // index 1
    Center(child: Text("Profile Page")), // index 2
    SettingsPage(), // index 3
    Center(child: Text("Other Page")), // index 4 (أو أي صفحة ترغب في إضافتها)
  ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    DeviceDimensions.init(context: context);

    return Scaffold(
      body: _pages[_selectedIndex],

      bottomNavigationBar: BottomAppBar(
        color: Colors.white,
        shape: CircularNotchedRectangle(),
        notchMargin: 8.0,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Row(
              children: [
                IconButton(
                  icon: Icon(Icons.home),
                  color: _selectedIndex == 0 ? Colors.green : Colors.grey,
                  onPressed: () => _onItemTapped(0),
                  iconSize: 30,
                ),
                SizedBox(width: 24),
                IconButton(
                  icon: Icon(Icons.shopping_cart),
                  color: _selectedIndex == 1 ? Colors.green : Colors.grey,
                  onPressed: () => _onItemTapped(1),
                  iconSize: 30,
                ),
              ],
            ),
            Row(
              children: [
                IconButton(
                  icon: Icon(Icons.person),
                  color: _selectedIndex == 2 ? Colors.green : Colors.grey,
                  onPressed: () => _onItemTapped(2),
                  iconSize: 30,
                ),
                SizedBox(width: 24),
                IconButton(
                  icon: Icon(Icons.settings),
                  color: _selectedIndex == 3 ? Colors.green : Colors.grey,
                  onPressed: () => _onItemTapped(3),
                  iconSize: 30,
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
