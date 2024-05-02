import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class ReportScreenParkingReserves extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Ranking de parqueos con mas reservaciones'),
      ),
      body: FutureBuilder(
        future: FirebaseFirestore.instance.collection('reserva').get(),
        builder: (context, AsyncSnapshot<QuerySnapshot> snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(
              child: CircularProgressIndicator(),
            );
          }

          if (snapshot.hasError) {
            return Center(
              child: Text('Error al cargar los datos'),
            );
          }

          final reservas = snapshot.data!.docs.where((reserva) => reserva['estado'] == 'terminado').toList();

          
          
          // Cálculo del top parqueos con más reservas
          final parqueosReservas = Map<String, int>();

          reservas.forEach((reserva) {
            final parqueo = reserva['parqueo']['nombre'];
            parqueosReservas[parqueo] =
                (parqueosReservas[parqueo] ?? 0) + 1;
          });

          final topParqueos = parqueosReservas.entries.toList()
            ..sort((a, b) => b.value.compareTo(a.value));

          return ListView(
            children: [
              
              ListTile(
                title: Text('Top Parqueos con más reservas:'),
                subtitle: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: topParqueos.map((entry) {
                    return Text('${entry.key}: ${entry.value} reservas');
                  }).toList(),
                ),
              ),
            ],
          );
        },
      ),
    );
  }
}

void main() {
  runApp(MaterialApp(
    home: ReportScreenParkingReserves(),
  ));
}
