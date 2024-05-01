import 'package:flutter/material.dart';
import 'package:parking_project/pages/admin/accounts_request.dart';
import 'package:parking_project/pages/admin/home_admin.dart';
import 'package:parking_project/pages/client/home_client_page.dart';
import 'package:parking_project/pages/profile.dart';

class MenuAdmin extends StatefulWidget {
  const MenuAdmin({super.key});

  @override
  State<MenuAdmin> createState() => _MenuAdminState();
}

class _MenuAdminState extends State<MenuAdmin> {
  int selectedIndex = 0;

  final List<Widget> pages = <Widget>[
    const HomeAdmin(),
    //const TicketsList(),
    const AccountRequestScreen(),
    const Text('Notificaciones de reserva'),
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
                  icon: Icon(Icons.calendar_today_rounded), label: 'Tickets'),
              BottomNavigationBarItem(
                  icon: Icon(Icons.notifications), label: 'Notificaciones'),
              BottomNavigationBarItem(icon: Icon(Icons.person), label: 'Perfil')
            ]),
      );
  }
}
