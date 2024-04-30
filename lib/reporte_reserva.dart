import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:intl/intl.dart';

class ReservaReport extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Reporte de Reserva'),
      ),
      body: StreamBuilder(
        stream: FirebaseFirestore.instance.collection('reserva').snapshots(),
        builder: (context, AsyncSnapshot<QuerySnapshot> snapshot) {
          if (!snapshot.hasData) {
            return Center(
              child: CircularProgressIndicator(),
            );
          }

          List<DocumentSnapshot> reservas = snapshot.data!.docs;

          return ListView.builder(
            itemCount: reservas.length,
            itemBuilder: (context, index) {
              DocumentSnapshot reserva = reservas[index];
              
              Timestamp fechaLlegada = reserva['fechaLlegada'];
              Timestamp fechaSalida = reserva['fechaSalida'];
              String idCliente = reserva['cliente'];
              Map<String, dynamic> parqueo = reserva['parqueo'];
              String idPlaza = parqueo['idPlaza'];
              String idParqueo = parqueo['idparqueo'];
              int total = reserva['total'];
              String idVehiculo = reserva['vehiculo'];

              String formattedHoraLlegada = DateFormat('hh:mm a').format(fechaLlegada.toDate());
              String formattedHoraSalida = DateFormat('hh:mm a').format(fechaSalida.toDate());
              String formattedFechaLlegada = DateFormat('dd/MM/yyyy').format(fechaLlegada.toDate());
              String formattedFechaSalida = DateFormat('dd/MM/yyyy').format(fechaSalida.toDate());


              return ListTile(
                title: Text('Cliente: $idCliente'),
                subtitle: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text('Horario: desde $formattedHoraLlegada hasta $formattedHoraSalida, el día $formattedFechaLlegada hasta el día $formattedFechaSalida'),
                    Text('ID Plaza: $idPlaza'),
                    Text('ID Parqueo: $idParqueo'),
                    Text('Total: $total'),
                    Text('ID Vehiculo: $idVehiculo'),
                  ],
                ),
              );
            },
          );
        },
      ),
    );
  }
}

void main() {
  runApp(MaterialApp(
    home: ReservaReport(),
  ));
}
