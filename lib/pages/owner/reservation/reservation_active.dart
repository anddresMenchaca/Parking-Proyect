import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:parking_project/models/to_use/reservation_request.dart';



class ReservasActivas extends StatelessWidget {
  const ReservasActivas({super.key});

  Stream<QuerySnapshot> getReservasStream() {
    return FirebaseFirestore.instance
        .collection('reserva')
        .where('estado', isEqualTo: 'activo')
        .snapshots();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Reservas Activas'),
      ),
      body: StreamBuilder<QuerySnapshot>(
        stream: getReservasStream(),
        builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }

          if (snapshot.hasError) {
            return Text('Error: ${snapshot.error}');
          }

          // Obtén la lista de plazas
          List<Reserva> reservas =
              snapshot.data!.docs.map((DocumentSnapshot document) {
            Map<String, dynamic> data = document.data() as Map<String, dynamic>;

            // DocumentSnapshot documentSnapshot = await FirebaseFirestore.instance.doc(data['idVehiculo']).get();
            // Map<String, dynamic> vehiculoData = documentSnapshot.data() as Map<String, dynamic>;

            // Aquí puedes realizar las operaciones necesarias con los datos del vehículo

            return Reserva(
              date: data['fecha'].toDate(),
              dateArrive: data['fechaLlegada'].toDate(),
              dateOut: data['fechaSalida'].toDate(),
              model: '',
              plate: '',
              status: data['estado'],
              total: data['total'],
              typeVehicle: '',
              id: document.id,
            );
          }).toList();

          return ListView.builder(
            itemCount: reservas.length,
            itemBuilder: (context, index) {
              final reservaRequest = reservas[index];
              return InkWell(
                onTap: () {
                  // Implementa aquí la lógica que se realizará al hacer clic en el elemento.
                  // Por ejemplo, puedes abrir una pantalla de detalles de la plaza.
                },
                child: Card(
                  elevation: 3.0,
                  margin: const EdgeInsets.symmetric(
                      vertical: 8.0, horizontal: 16.0),
                  child: ListTile(
                    title: Text(
                      reservaRequest.date.toString(),
                      style: const TextStyle(
                          fontSize: 18.0, fontWeight: FontWeight.bold),
                    ),
                    subtitle: Text(
                      reservaRequest.total.toString(),
                      style: const TextStyle(fontSize: 16.0),
                    ),
                    trailing: IconButton(
                      icon: const Icon(Icons.edit, color: Colors.blue),
                      onPressed: () {
                        // Implementa aquí la lógica para abrir la pantalla de edición.
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) =>
                                ReservaActivaScreen(reserva: reservaRequest),
                          ),
                        );
                      },
                    ),
                  ),
                ),
              );
            },
          );
        },
      ),
    );
  }
}










class ReservaActivaScreen extends StatefulWidget {
  final Reserva reserva;

  const ReservaActivaScreen({super.key, required this.reserva});

  @override
  State<ReservaActivaScreen> createState() => _ReservaActivaScreenState();
}

class _ReservaActivaScreenState extends State<ReservaActivaScreen> {


  TextEditingController nombreParqueo = TextEditingController();
  TextEditingController pisoController = TextEditingController();
  TextEditingController filaController = TextEditingController();
  TextEditingController plazaController = TextEditingController();
  TextEditingController placaController = TextEditingController();
  TextEditingController marcaController = TextEditingController();
  TextEditingController colorController = TextEditingController();
  TextEditingController modeloController = TextEditingController();
  TextEditingController estadoController = TextEditingController();
  TextEditingController fechaInicioController = TextEditingController();
  TextEditingController fechaFinController = TextEditingController();

  DateTime? reservationDateIn, reservationDateOut;
  bool radioValue = false;
  List<bool> checkboxValues = [false, false, false];
  String typeVehicle = "";
  String urlImage = "";



  @override
  void initState() {
    super.initState();
    getFullData();
  }

  Future<void> getFullData() async {
    //try {
    //   DocumentSnapshot documentSnapshot = await FirebaseFirestore.instance.doc(widget.reserva.id).get();
    //   Map<String, dynamic> vehiculoData = documentSnapshot.data() as Map<String, dynamic>;
    //   DocumentSnapshot plazaDoc = await widget.dataSearch.idPlaza!.get();

    //   Map<String, dynamic> dataPlace = plazaDoc.data() as Map<String, dynamic>;

    //   DocumentSnapshot filaDoc =
    //       await widget.dataSearch.idPlaza!.parent.parent!.get();

    //   Map<String, dynamic> dataFila = filaDoc.data() as Map<String, dynamic>;

    //   DocumentSnapshot pisoDoc =
    //       await widget.dataSearch.idPlaza!.parent.parent!.parent.parent!.get();

    //   Map<String, dynamic> dataPiso = pisoDoc.data() as Map<String, dynamic>;

    //   DocumentSnapshot parkingDoc = await widget.dataSearch.idParqueo.get();

    //   Map<String, dynamic> dataParking =
    //       parkingDoc.data() as Map<String, dynamic>;

    //   nombreParqueo.text = dataParking['nombre'];

    //   pisoController.text = dataPiso['nombre'];
    //   filaController.text = dataFila['nombre'];
    //   plazaController.text = widget.dataSearch.plaza!;
    //   typeVehicle = widget.dataSearch.tipoVehiculo!;
    //   if (widget.dataSearch.tipoVehiculo == "Moto") {
    //     checkboxValues[0] = true;
    //   } else if (widget.dataSearch.tipoVehiculo == "Automóvil") {
    //     checkboxValues[1] = true;
    //   } else if (widget.dataSearch.tipoVehiculo == "Otro") {
    //     checkboxValues[2] = true;
    //   }
    //   estadoController.text = dataPlace['estado'];
    //   urlImage = dataParking['url'];
    //   // placaController.text = dataReserve['vehiculo']['placa'];
    //   // marcaController.text = dataReserve['vehiculo']['marca'];
    //   // colorController.text = dataReserve['vehiculo']['color'];
    //   // modeloController.text = dataReserve['vehiculo']['modelo'];
    //   // radioValue = widget.dataSearch.tieneCobertura!;
    //   Timestamp timestampDateOut = widget.dataSearch.fechaFin!;
    //   reservationDateOut = timestampDateOut.toDate();
    //   Timestamp timestampDateIn = widget.dataSearch.fechaInicio!;
    //   reservationDateIn = timestampDateIn.toDate();
    //   // setState(() {
    //   fechaInicioController.text =
    //       DateFormat('dd/MM/yyyy HH:mm a').format(reservationDateIn!);
    //   fechaFinController.text =
    //       DateFormat('dd/MM/yyyy HH:mm a').format(reservationDateOut!);
    //   // });
    // } catch (e) {
    //   log(e.toString());
    // }
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Reservas Activas'),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Fecha: ${widget.reserva.date}',
                style: const TextStyle(fontSize: 18.0, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 8.0),
              Text(
                'Fecha de llegada: ${widget.reserva.dateArrive}',
                style: const TextStyle(fontSize: 16.0),
              ),
              const SizedBox(height: 8.0),
              Text(
                'Fecha de salida: ${widget.reserva.dateOut}',
                style: const TextStyle(fontSize: 16.0),
              ),
              const SizedBox(height: 8.0),
              Text(
                'Modelo: ${widget.reserva.model}',
                style: const TextStyle(fontSize: 16.0),
              ),
              const SizedBox(height: 8.0),
              Text(
                'Placa: ${widget.reserva.plate}',
                style: const TextStyle(fontSize: 16.0),
              ),
              const SizedBox(height: 8.0),
              Text(
                'Estado: ${widget.reserva.status}',
                style: const TextStyle(fontSize: 16.0),
              ),
              const SizedBox(height: 8.0),
              Text(
                'Total: ${widget.reserva.total}',
                style: const TextStyle(fontSize: 16.0),
              ),
              const SizedBox(height: 8.0),
              Text(
                'Tipo de vehículo: ${widget.reserva.typeVehicle}',
                style: const TextStyle(fontSize: 16.0),
              ),
              const SizedBox(height: 16.0),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  ElevatedButton(
                    onPressed: () {
                      String id = widget.reserva.id;
                      //obtener el documento de la coleccion reserva
                      DocumentReference reservaRef = FirebaseFirestore.instance.collection('reserva').doc(id);
                      //actualizar el estado de la reserva
                      reservaRef.update({'estado': 'finalizado'});

                      Navigator.pop(context);
                      
                    },
                    child: const Text('Finalizar'),
                  ),
                  ElevatedButton(
                    onPressed: () {
                      String id = widget.reserva.id;
                      //obtener el documento de la coleccion reserva
                      DocumentReference reservaRef = FirebaseFirestore.instance.collection('reserva').doc(id);
                      //actualizar el estado de la reserva
                      reservaRef.update({'estado': 'rechazado'});
                      Navigator.pop(context);

                    },
                    child: const Text('Caducar'),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}


  