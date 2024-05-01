import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:parking_project/models/coleccion/vehiclecollection.dart';
import 'package:parking_project/models/to_use/vehicle.dart';

Future<UserCredential?> auntenticator(var user, var password) async {
  try {
    final credential = await FirebaseAuth.instance
        .signInWithEmailAndPassword(email: user, password: password);
    return credential;
  } on FirebaseAuthException catch (e) {
    if (e.code == 'user-not-found') {
    } else if (e.code == 'wrong-password') {}
    return null; // Devuelve null en caso de error.
  }
}

Stream<QuerySnapshot> getParkingsByOwner(String ownerId) {
  return FirebaseFirestore.instance
      .collection('parqueo')
      .where('idDuenio', isEqualTo: ownerId)
      .snapshots();
}


Stream<QuerySnapshot> getAllParkings() {
  return FirebaseFirestore.instance.collection('parqueo').snapshots();
}



//-------------------------------------------------------------------------------------------


FirebaseFirestore db =FirebaseFirestore.instance;

Stream<QuerySnapshot> getVehicleData() {
  String idUser = FirebaseAuth.instance.currentUser?.uid ?? ""; // Obtener el ID del usuario autenticado
  print('UID del usuario autenticado: $idUser');

  CollectionReference collectionReference = db.collection('vehiculo');

  // Realizar la consulta filtrando por el campo 'IdCliente'
  Stream<QuerySnapshot> snapshots = collectionReference.where('idDuenio', isEqualTo: idUser).snapshots();

  // Agrega un listener para imprimir los resultados del QuerySnapshot
  snapshots.listen((QuerySnapshot querySnapshot) {
    querySnapshot.docs.forEach((DocumentSnapshot doc) {
      print('ID del documento: ${doc.id}');
      Map<String, dynamic> data = doc.data() as Map<String, dynamic>;
      // Agrega el ID del documento a los datos recuperados
      data['id'] = doc.id;
      print('Datos del documento: $data');
    });
  });
  return snapshots;
}









Future<void> registerVehicle(VehicleData vehicleData, BuildContext context) async {
  String idUser = "";
  User? user = FirebaseAuth.instance.currentUser;
  if (user != null) {   
     idUser = user.uid;   
    print('UID del usuario autenticado: $idUser'); 
    } else {   
      print('No hay usuario autenticado'); }
  

  try {
      await FirebaseFirestore.instance
          .collection('vehiculo')
          .doc()
          .set({ 
        VehicleCollection.idCliente: idUser, 
        VehicleCollection.color: vehicleData.color,
        VehicleCollection.marca: vehicleData.marca,
        VehicleCollection.placa:vehicleData.placa,
        VehicleCollection.tipo:vehicleData.tipo,

         VehicleCollection.alto:vehicleData.alto,
         VehicleCollection.ancho:vehicleData.ancho,
         VehicleCollection.largo:vehicleData.largo,
        
        // Agrega otros campos de datos aquí
      });

  } catch (error) {
      print(error);
  }

}



//falta llenar el ccombobox
Future<VehicleData?> getVehicleDataById(String vehicleId) async {
  try {
    DocumentSnapshot vehicleSnapshot = await FirebaseFirestore.instance
        .collection('vehiculo')
        .doc(vehicleId)
        .get();

    if (vehicleSnapshot.exists) {
      Map<String, dynamic> vehicleData =
          vehicleSnapshot.data() as Map<String, dynamic>;
         String documentId = vehicleSnapshot.id;//para poder recuperar el ID
      return VehicleData(
        color: vehicleData[VehicleCollection.color],
        marca: vehicleData[VehicleCollection.marca],
        placa: vehicleData[VehicleCollection.placa],
        tipo: vehicleData[VehicleCollection.tipo],



        alto: (vehicleData[VehicleCollection.alto] as num).toDouble(),
        ancho: (vehicleData[VehicleCollection.ancho] as num).toDouble(),
        largo: (vehicleData[VehicleCollection.largo] as num).toDouble(),
        

        idCliente: vehicleData[VehicleCollection.idCliente],
        //Id para el documneto
        id: documentId,
      );
    } else {
      return null;
    }
  } catch (error) {
    
    print(error);
    return null;
  }
}



//  Completo
Future<void> updateVehicle(VehicleData vehicleData, String uid) async{
  await db.collection("vehiculo")
          .doc(uid)
          .set({
            VehicleCollection.color: vehicleData.color,
            VehicleCollection.marca: vehicleData.marca,
            VehicleCollection.placa:vehicleData.placa,
            VehicleCollection.tipo:vehicleData.tipo,

            VehicleCollection.alto:vehicleData.alto,
            VehicleCollection.ancho:vehicleData.ancho,
            VehicleCollection.largo:vehicleData.largo,

            VehicleCollection.idCliente: vehicleData.idCliente,
          });
}


Future<void> deleteVehicle(String vehicleId) async {
  try {
    await db.collection('vehiculo').doc(vehicleId).delete();
    print('Vehículo eliminado correctamente');
  } catch (e) {
    print('Error al eliminar el vehículo: $e');
  }
}



