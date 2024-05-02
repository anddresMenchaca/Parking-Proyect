import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:parking_project/prueba.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // ignore: unused_local_variable
    int number = 0;
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: const Text('Calificar'),
        ),
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              RatingBar.builder(
                initialRating: 3,
                minRating: 1,
                direction: Axis.horizontal,
                allowHalfRating: true,
                itemCount: 5,
                itemPadding: const EdgeInsets.symmetric(horizontal: 4.0),
                itemBuilder: (context, _) => const Icon(
                  Icons.star,
                  color: Colors.amber,
                ),
                onRatingUpdate: (rating) async {
                  if (kDebugMode) {
                    print(rating);
                    number = rating.toInt();
                  }
                },
              ),
              const SizedBox(
                  height:
                      20), // Añade un espacio entre la barra de calificación y el botón
              ElevatedButton(
                onPressed: () async {
                  // Aquí puedes agregar la lógica para guardar el rating
                  if (kDebugMode) {
                    print('Botón presionado');

                    // Obtener y usar el usuario existente
                    Usuario usuario = await obtenerUsuario('1');

                    // Actualizar el puntaje del usuario
                    await updateItem(number, usuario);
                  }
                },
                child: const Text('Guardar Calificación'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
