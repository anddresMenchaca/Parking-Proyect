import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class ReportScreenRankingReserves extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Ranking de clientes con mas reservas'),
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

          
          

          // Cálculo del top cliente con más reservas
          final clientesReservas = Map<String, int>();

          reservas.forEach((reserva) {
            final cliente = reserva['cliente']['nombre'];
            clientesReservas[cliente] =
                (clientesReservas[cliente] ?? 0) + 1;
          });

          final topCliente = clientesReservas.entries.reduce((a, b) {
            return a.value > b.value ? a : b;
          });

          
          return ListView(
            children: [
              
              ListTile(
                title: Text('Top Cliente con más reservas: ${topCliente.key}'),
                subtitle: Text('Cantidad de reservas: ${topCliente.value}'),
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
    home: ReportScreenRankingReserves(),
  ));
}
