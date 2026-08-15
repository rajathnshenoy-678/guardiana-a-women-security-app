import 'package:flutter/material.dart';
import 'package:guardiana/user/bottom_page/add_contacts.dart';
import 'package:guardiana/user/bottom_page/chats_page.dart';
import 'package:guardiana/user/bottom_page/contacts_page.dart';
import 'package:guardiana/user/bottom_page/home_screen.dart';
import 'package:guardiana/user/bottom_page/profile_page.dart';

class BottomPage extends StatefulWidget {
  const BottomPage({super.key});

  @override
  State<BottomPage> createState() => _BottomPageState();
}

class _BottomPageState extends State<BottomPage> {
  int CurrentIndex = 0;
  List<Widget> pages = [
    HomeScreen(),
    ChatPage(),
    AddContactsPage(),
    ProfilePage(),
  ];
  onTapped(int index) {
    setState(() {
      CurrentIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: pages[CurrentIndex],
      bottomNavigationBar:
          BottomNavigationBar(currentIndex: CurrentIndex,
          onTap: onTapped,
          type: BottomNavigationBarType.fixed,
          items: [
        BottomNavigationBarItem(label: 'Home', icon: Icon(Icons.home)),
        BottomNavigationBarItem(label: 'Messages', icon: Icon(Icons.message)),
        BottomNavigationBarItem(label: 'Contacts', icon: Icon(Icons.contacts)),
        BottomNavigationBarItem(label: 'Profile', icon: Icon(Icons.person)),
      ]),
    );
  }
}