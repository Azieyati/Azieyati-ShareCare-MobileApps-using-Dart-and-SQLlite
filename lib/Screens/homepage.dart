import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:sharecareproject2/Screens/profile.dart';
import 'donationformpage.dart';
import 'home_user.dart';


class HomePage extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return Scaffold(

      // backgroundColor: Colors.black,
      extendBodyBehindAppBar: false,

      body: MyHomePage(),
      // debugShowCheckedModeBanner: true,
    );
  }
}

class MyHomePage extends StatefulWidget {
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int _selectedIndex = 0;

  final List<Widget> _widgetOptions = <Widget>[

    // Call 3 class from different file
    HomeUser(),
    DonationFormWidget(),
    Profile(),
    //DetailsDonation(),

  ];

  void _onItemTapped(int index) {

    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(

      body: _widgetOptions.elementAt(_selectedIndex),

      bottomNavigationBar: BottomNavigationBar(

        items: const
        <BottomNavigationBarItem>[

          BottomNavigationBarItem(
            icon: Icon(
                Icons.home),
            label: 'Dashboard',
          ),

          BottomNavigationBarItem(

            icon: Icon(
                Icons.monetization_on_outlined),
            label: 'Donation',
          ),

          BottomNavigationBarItem(
            icon:
            Icon(Icons.person),
            label: 'Profile',

          ),
        ],

        currentIndex: _selectedIndex,
        selectedItemColor: Colors.blue,
        onTap: _onItemTapped,
      ),
    );
  }
}

