import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class ReportScreenTotal extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Calculo De total gastado por cliente'),
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

          final reservas = snapshot.data!.docs
              .where((reserva) => reserva['estado'] == 'terminado')
              .toList();

          // Cálculo del total gastado por cliente
          final totalPorCliente = Map<String, double>();

          reservas.forEach((reserva) {
            final cliente = reserva['cliente']['nombre'];
            final totalReserva = reserva['total'] ?? 0;
            totalPorCliente[cliente] =
                (totalPorCliente[cliente] ?? 0) + totalReserva;
          });

          // Cálculo del promedio de precios
          final precios = totalPorCliente.values.toList();

          final precioPromedio = precios.isEmpty
              ? 0
              : precios.reduce((a, b) => a + b) / precios.length;

          return ListView(
            children: [
              ListTile(
                title: Text('Promedio de precios: $precioPromedio'),
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
    home: ReportScreenTotal(),
  ));
}
