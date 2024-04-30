import 'dart:developer';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:parking_project/helpers/extensions.dart';
import 'package:parking_project/models/to_use/parking.dart';
import 'package:parking_project/routes/routes.dart';

class OwnerParkingsScreen extends StatelessWidget {
  static const routeName = '/enable-parking';
  const OwnerParkingsScreen({super.key});
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
            title: const Text('Mis parqueos'),
            backgroundColor: const Color.fromARGB(255, 5, 126, 225)),
        body: const PlazaListScreen(),
      ),
    );
  }
}

class PlazaListScreen extends StatefulWidget {
  const PlazaListScreen({super.key});

  @override
  PlazaListScreenState createState() => PlazaListScreenState();
}

class PlazaListScreenState extends State<PlazaListScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: StreamBuilder(
        stream: getParking(),
        builder: (context, AsyncSnapshot<QuerySnapshot> snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }

          if (snapshot.hasError) {
            return Text('Error: ${snapshot.error}');
          }

          // Obtén la lista de plazas
          List<Parqueo> parqueos =
              snapshot.data!.docs.map((DocumentSnapshot document) {
            Map<String, dynamic> data = document.data() as Map<String, dynamic>;
            return Parqueo(
                idParqueo: document.reference,
                nombre: data['nombre'],
                direccion: data['direccion'],
                ubicacion: data['ubicacion'],
                descripcion: data['descripcion'],
                vehiculosPermitidos: data['vehiculosPermitidos'],
                tarifaAutomovil: data['tarifaAutomovil'],
                tarifaMoto: data['tarifaMoto'],
                tarifaOtro: data['tarifaOtro'],
                horaApertura: data['horaApertura'],
                horaCierre: data['horaCierre'],
                idDuenio: data['idDuenio'],
                puntaje: data['puntaje'],
                diasApertura: data['diasApertura'],);
          }).toList();
          return ListView.builder(
            itemCount: parqueos.length,
            itemBuilder: (context, index) {
              final parqueo = parqueos[index];
              return InkWell(
                onTap: () {

                  context.pushNamedAndRemoveUntil(
                    Routes.registerPlaceScreen,
                    predicate: (route) => false,
                    arguments: [parqueo.idParqueo],
                  );
                  // Implementa aquí la lógica que se realizará al hacer clic en el elemento.
                  // Por ejemplo, puedes abrir una pantalla de detalles de la plaza.
                },
                child: Card(
                  elevation: 3.0,
                  margin: const EdgeInsets.symmetric(
                      vertical: 8.0, horizontal: 16.0),
                  child: ListTile(
                    title: Text(
                      parqueo.nombre,
                      style: const TextStyle(
                          fontSize: 18.0, fontWeight: FontWeight.bold),
                    ),
                    // subtitle: Text(
                    //   parqueo.bool
                    //       ? 'Con Cobertura'
                    //       : 'Sin Cobertura',
                    //   style: const TextStyle(fontSize: 16.0),
                    // ),
                    trailing: IconButton(
                      icon: const Icon(Icons.car_repair, color: Colors.blue),
                      onPressed: () {
                        //VEMTANA DE EDITAR PARQUEO
                        // DataReservationSearch dataSearch = DataReservationSearch(idParqueo: parqueo.idParqueo);
                        // // Implementa aquí la lógica para abrir la pantalla de edición.
                        // Navigator.push(
                        //   context,
                        //   MaterialPageRoute(
                        //     builder: (context) => MostrarDatosParqueoScreen(dataSearch: dataSearch)
                        //   ),
                        // );
                      },
                    ),
                  ),
                ),
              );
            },
          );
        },
      ),
        floatingActionButton: FloatingActionButton(
        onPressed: () {
          context.pushNamedAndRemoveUntil(
            Routes.registerParking,
            predicate: (route) => false,
          );
        },
        backgroundColor: Colors.blue,
        child: const Icon(Icons.add),
      )
    );
  }

Stream<QuerySnapshot> getParking() {
  try {
    final User? user = FirebaseAuth.instance.currentUser;

    if (user != null) {
      CollectionReference parkingCollection = FirebaseFirestore.instance.collection('parqueo');
      return parkingCollection.where('idDuenio', isEqualTo: user.uid).snapshots();
      // Filtra los documentos donde el campo 'IdDuenio' sea igual al user.uid
    } else {
      // Si el usuario no ha iniciado sesión, aún puedes devolver un Stream vacío o manejarlo de otra manera.
      return const Stream<QuerySnapshot>.empty();
    }
  } catch (e) {
    log('Error al obtener el Stream de parqueos: $e');
    rethrow;
  }
}

}