import 'package:flutter/material.dart'; 
import 'package:firebase_core/firebase_core.dart';
import 'package:parking_project/prueba.dart';
import 'firebase_options.dart';
import 'package:parking_project/reporte_reserva.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter De prueba',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: const MyHomePage(title: 'Flutter Prueba'),
    );
  }
}

class MyHomePage extends StatelessWidget {
  const MyHomePage({Key? key, required this.title}) : super(key: key);

  final String title;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: Text(title),
      ),
      body: FutureBuilder(
        future: getPeople(),
        builder: ((context, snapshot){
          return ListView.builder(
            itemCount: snapshot.data?.length,
            itemBuilder: (context, index){
              return Text(snapshot.data?[index]['nombre']);
            },
          );
        }),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => _navigateToReservaReport(context),
        tooltip: 'Ver Reporte de Reserva',
        child: const Icon(Icons.assignment),
      ),
    );
  }

  void _navigateToReservaReport(BuildContext context) {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => ReservaReport()),
    );
  }
}
