import 'package:flutter/material.dart';
import 'package:parking_project/helpers/extensions.dart';
import 'package:parking_project/pages/map/map_owner.dart';
import 'package:parking_project/pages/owner/parqueo/owner_parkings.dart';
import 'package:parking_project/pages/owner/reservation/reservation_active.dart';
import 'package:parking_project/routes/routes.dart';

class HomeOwner extends StatefulWidget {
  const HomeOwner({super.key});

  @override
  State<HomeOwner> createState() => _HomeOwnerState();
}

class _HomeOwnerState extends State<HomeOwner> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Stack(
          children: <Widget>[
            Container(
              height: 1250,
            ),
            ClipRRect(
              borderRadius: const BorderRadius.only(
                  bottomRight: Radius.circular(30),
                  bottomLeft: Radius.circular(30)),
              child: Container(
                color: const Color(0xff2e61e6),
                height: 250,
                child: Center(
                    child: Column(
                  children: [
                    const SizedBox(height: 10),
                    const Text(
                      'Bienvenido User',
                      style: TextStyle(
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
                    ),
                    Image.asset(
                      'assets/logo.png',
                      width: 150,
                      height: 100,
                    ),
                    const Text(
                      'PROJECT PARK',
                      style: TextStyle(fontSize: 18, color: Colors.white),
                    ),
                  ],
                )),
              ),
            ),
            Positioned(
              top: 190,
              left: 0,
              right: 0,
              child: Card(
                elevation: 4,
                borderOnForeground: true,
                margin: const EdgeInsets.symmetric(horizontal: 40),
                child: Container(
                  height: 135,
                  padding: const EdgeInsets.all(16),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      Column(
                        children: [
                          IconButton(
                            icon: const Icon(Icons.directions_car),
                            onPressed: () {
                              //OwnerParkingsScreen
                            if (!context.mounted) return;

                            Navigator.push(
                              context,
                              MaterialPageRoute(builder: (_) => const ParkingListScreen()),
                            );


                            },
                            iconSize: 50,
                            color: const Color(0xff2e61e6),
                          ),
                          const Text(
                            'Parqueos',
                            style: TextStyle(
                              fontSize: 16,
                            ),
                          )
                        ],
                      ),
                      Column(children: [
                        IconButton(
                          icon: const Icon(Icons.confirmation_number),
                          onPressed: () {
                            // Agrega la lógica para el botón 'Reservas solicitadas' aquí


                            Navigator.push(context,
                                MaterialPageRoute(builder: (context) => const ReservasActivas()));
                          },
                          iconSize: 50,
                          color: const Color(0xff2e61e6),
                        ),
                        const Text(
                          'Reservas',
                          style: TextStyle(
                            fontSize: 16,
                          ),
                        )
                      ]),
                    ],
                  ),
                ),
              ),
            ),
            Positioned(
              top: 340,
              left: 0,
              right: 0,
              child: Card(
                elevation: 4,
                margin: const EdgeInsets.symmetric(horizontal: 40),
                child: Container(
                  height: 125,
                  padding: const EdgeInsets.all(16),
                  child: const Column(
                    children: [
                      Text(
                        'Recaudaciones:',
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      SizedBox(height: 8),
                      Row(
                        children: [
                          Text('Parqueo :',
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                              )),
                          SizedBox(width: 8),
                          Text(
                            'Magallanez: 0 Bs',
                            style: TextStyle(
                              fontSize: 16,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            ),
            Positioned(
              top: 480,
              left: 0,
              right: 0,
              child: Card(
                elevation: 4,
                margin: const EdgeInsets.symmetric(horizontal: 40),
                child: Container(
                  height: 125,
                  padding: const EdgeInsets.all(16),
                  child: const Column(
                    children: [
                      Text(
                        'Calificaciones',
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      SizedBox(height: 8),
                      Row(
                        children: [
                          Text('Parqueo :',
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                              )),
                          SizedBox(width: 8),
                          Text(
                            'Magallanez: 4.4 ★',
                            style: TextStyle(
                              fontSize: 16,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            ),
            Positioned(
              top: 640,
              left: 0,
              right: 0,
              child: GestureDetector(
                onTap: () {
                  if (!context.mounted) return;
                  Navigator.push(context, MaterialPageRoute(builder: (_) => const MapOwner()));
                },
                child: Card(
                  elevation: 4,
                  margin: const EdgeInsets.symmetric(horizontal: 40),
                  child: Container(
                    height: 120,
                    padding: const EdgeInsets.all(16),
                    child: const Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(
                          Icons.map_outlined,
                          size: 40,
                          color: Colors.green,
                        ),
                      Text(
                            "Ubicacion Mis Parqueos",
                            style: TextStyle(fontWeight: FontWeight.bold),
                          ),
                        SizedBox(height: 10),
                        //SizedBox(child: MapOwner()),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
