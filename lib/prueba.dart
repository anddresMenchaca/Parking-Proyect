import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:parking_project/firebase_options.dart';

FirebaseFirestore db = FirebaseFirestore.instance;

Future<List> getPeople() async {
  List people = [];
  CollectionReference collectionReference = db.collection('usuario');

  QuerySnapshot quertPeople = await collectionReference.get();

  quertPeople.docs.forEach((element) {
    var data = element.data();
    if ((data as Map<String, dynamic>)['estado'] == 'habilitado') {
      people.add(data);
    }
  });


  return people;
}

class Usuario {
  String apellido;
  int cantidadResenias;
  String correo;
  String estado;
  String nombre;
  int puntaje;
  int sumaPuntos;
  int telefono;
  String tipo;

  Usuario({
    required this.apellido,
    required this.cantidadResenias,
    required this.correo,
    required this.estado,
    required this.nombre,
    required this.puntaje,
    required this.sumaPuntos,
    required this.telefono,
    required this.tipo,
  });
}

Future<Usuario> obtenerUsuario(String id) async {
  try {
    await Firebase.initializeApp(
      options: DefaultFirebaseOptions.currentPlatform,
    );

    // Obtener el documento con el ID especificado
    DocumentSnapshot documentSnapshot =
        await FirebaseFirestore.instance.collection("usuario").doc(id).get();

    // Verificar si el documento existe
    if (documentSnapshot.exists) {
      // Obtener todos los datos del documento
      Map<String, dynamic>? userData =
          documentSnapshot.data() as Map<String, dynamic>?;

      if (userData != null) {
        // Crear un objeto Usuario con los datos recuperados
        Usuario usuario = Usuario(
          apellido: userData['apellido'] ?? '',
          cantidadResenias: userData['cantidadResenias'] ?? 0,
          correo: userData['correo'] ?? '',
          estado: userData['estado'] ?? '',
          nombre: userData['nombre'] ?? '',
          puntaje: userData['puntaje'] ?? 0,
          sumaPuntos: userData['sumaPuntos'] ?? 0,
          telefono: userData['telefono'] ?? 0,
          tipo: userData['tipo'] ?? '',
        );
        print(usuario.puntaje);
        return usuario;
      } else {
        throw Exception('Los datos del usuario son nulos.');
      }
    } else {
      throw Exception('No se encontró ningún registro con el ID especificado.');
    }
  } catch (error) {
    if (error is FirebaseException) {
      print('Error de Firebase al obtener el usuario: $error');
    } else {
      print('Error desconocido al obtener el usuario: $error');
    }
    throw Exception('Error al obtener el usuario: $error');
  }
}

Future<void> updateItem(int puntaje, Usuario usuario) async {
  try {
    // Obtener los datos del usuario
    Usuario usuarioExistente = await obtenerUsuario('1');

    // Actualizar el puntaje del usuario

    usuarioExistente.sumaPuntos += puntaje;
    usuarioExistente.cantidadResenias++;
    usuarioExistente.puntaje =
        usuarioExistente.sumaPuntos ~/ usuarioExistente.cantidadResenias;
    // Realizar la actualización con el objeto modificado
    await db.collection("usuario").doc('1').set({
      'apellido': usuarioExistente.apellido,
      'cantidadResenias': usuarioExistente.cantidadResenias,
      'correo': usuarioExistente.correo,
      'nombre': usuarioExistente.nombre,
      'puntaje': usuarioExistente.puntaje,
      'sumaPuntos': usuarioExistente.sumaPuntos,
      'telefono': usuarioExistente.telefono,
      'tipo': usuarioExistente.tipo,
    });
    print('Puntaje actualizado correctamente.');
  } catch (error) {
    print('Error al actualizar el puntaje: $error');
  }
}
