import 'package:flutter/material.dart';
import 'package:parking_project/pages/owner/home_owner_screen.dart';
import 'package:parking_project/pages/profile.dart';

class MenuOwner extends StatefulWidget {
  const MenuOwner({super.key});

  @override
  State<MenuOwner> createState() => _MenuOwnerState();
}

class _MenuOwnerState extends State<MenuOwner> {
  int selectedIndex = 0;

  final List<Widget> pages = <Widget>[
    const HomeOwner(),
    const Text('Reportes'),
    const Text('Notificaciones'),
    const ProfilePage(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: pages[selectedIndex],
      bottomNavigationBar: BottomNavigationBar(
          selectedItemColor: Colors.blue,
          unselectedItemColor: Colors.black,
          onTap: (index) => setState(() => selectedIndex = index),
          currentIndex: selectedIndex,
          items: const [
            BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Inicio'),
            BottomNavigationBarItem(icon: Icon(Icons.report), label: 'Reortes'),
            BottomNavigationBarItem(
                icon: Icon(Icons.notifications), label: 'Notificaciones'),
            BottomNavigationBarItem(icon: Icon(Icons.person), label: 'Perfil')
          ]),
    );
  }
}
