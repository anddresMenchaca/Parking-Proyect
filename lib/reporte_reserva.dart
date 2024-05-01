import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class ReportScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Reporte'),
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

          final reservas = snapshot.data!.docs;

          // Cálculo de la duración promedio de reserva
          final duraciones = reservas.map((reserva) {
            final fechaLlegada = reserva['fechaLlegada']?.toDate();
            final fechaSalida = reserva['fechaSalida']?.toDate();
            if (fechaLlegada != null && fechaSalida != null) {
              return fechaSalida.difference(fechaLlegada).inHours;
            } else {
              return 0;
            }
          }).toList();

          final duracionPromedio = duraciones.isEmpty
              ? 0
              : duraciones.reduce((a, b) => a + b) / duraciones.length;

          // Cálculo del total gastado por cliente
          final totalPorCliente = Map<String, double>();

          reservas.forEach((reserva) {
            final cliente = reserva['cliente']['nombre'];
            final totalReserva = reserva['total'] ?? 0;
            totalPorCliente[cliente] = (totalPorCliente[cliente] ?? 0) + totalReserva;
          });

          // Cálculo del promedio de precios
          final precios = totalPorCliente.values.toList();

          final precioPromedio = precios.isEmpty
              ? 0
              : precios.reduce((a, b) => a + b) / precios.length;

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
                title: Text('Duración promedio de reserva: $duracionPromedio horas'),
              ),
              ListTile(
                title: Text('Promedio de precios: $precioPromedio'),
              ),
              ListTile(
                title: Text('Top Cliente con más reservas: ${topCliente.key}'),
                subtitle: Text('Cantidad de reservas: ${topCliente.value}'),
              ),
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
    home: ReportScreen(),
  ));
}
