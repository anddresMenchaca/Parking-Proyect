import 'package:flutter/material.dart';
import 'package:parking_project/main.dart';
import 'package:parking_project/pages/client/Vehicle/home_page.dart';
import 'package:parking_project/pages/client/home_client_page.dart';
import 'package:parking_project/pages/profile.dart';

void main() => runApp(const MenuClient());

class MenuClient extends StatefulWidget {
  const MenuClient({super.key});

  @override
  State<MenuClient> createState() => _MenuClientState();
}

class _MenuClientState extends State<MenuClient> {
  int selectedIndex = 0;

  final List<Widget> pages = <Widget>[
    const HomeClient(),
    //const TicketsList(),
    const Text('ssssssssss'),
    const VehicleScreen(),
    //const ProfilePage(),
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
              BottomNavigationBarItem(
                  icon: Icon(Icons.calendar_today_rounded), label: 'Reservas Activas'),
              BottomNavigationBarItem(
                  icon: Icon(Icons.notifications), label: 'Vehiculos'),
              BottomNavigationBarItem(icon: Icon(Icons.person), label: 'Perfil')
            ]),
      );
  }
}
