import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:parking_project/firebase_options.dart';
import 'package:parking_project/services/temporal.dart';


class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: const MyHomePage(title: 'Flutter Demo Home Page'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});
  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  bool _ordenAscendente = true;
  bool _mostrarClientes = true;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: const Text("Ranking"),
      ),
      body: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text("Dueños"),
              Switch(
                value: _mostrarClientes,
                onChanged: (value) {
                  setState(() {
                    _mostrarClientes = value;
                  });
                },
              ),
              Text("Clientes"),
              SizedBox(width: 20),
              Text("Mayor a menor"),
              Switch(
                value: _ordenAscendente,
                onChanged: (value) {
                  setState(() {
                    _ordenAscendente = value;
                  });
                },
              ),
              Text("Menor a mayor"),
            ],
          ),
          FutureBuilder(
            future: getPeople(),
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return Center(child: CircularProgressIndicator());
              } else if (snapshot.hasError) {
                return Center(child: Text('Error: ${snapshot.error}'));
              } else if (snapshot.hasData) {
                final List<dynamic> people = snapshot.data as List<dynamic>;
                List<dynamic> filteredPeople = List.from(people);
                if (!_mostrarClientes) {
                  filteredPeople = filteredPeople
                      .where((person) => person['tipo'] == 'Dueño')
                      .toList();
                }

                if (_ordenAscendente) {
                  filteredPeople.sort((a, b) =>
                      (a['puntaje'] ?? 0).compareTo(b['puntaje'] ?? 0));
                } else {
                  filteredPeople.sort((a, b) =>
                      (b['puntaje'] ?? 0).compareTo(a['puntaje'] ?? 0));
                }

                return Center(
                  child: Container(
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(15.0),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.grey.withOpacity(0.5),
                          spreadRadius: 5,
                          blurRadius: 7,
                          offset: Offset(0, 3),
                        ),
                      ],
                    ),
                    padding: EdgeInsets.all(20.0),
                    child: SingleChildScrollView(
                      scrollDirection: Axis.horizontal,
                      child: DataTable(
                        headingTextStyle:
                            TextStyle(fontWeight: FontWeight.bold),
                        dataRowColor:
                            MaterialStateProperty.all(Colors.transparent),
                        columns: [
                          DataColumn(
                              label: Text('Nombre',
                                  style: TextStyle(color: Colors.black))),
                          DataColumn(
                              label: Text('Puntaje',
                                  style: TextStyle(color: Colors.black))),
                        ],
                        rows: filteredPeople.map<DataRow>((person) {
                          return DataRow(cells: [
                            DataCell(Text(person['nombre'] ?? 'Desconocido')),
                            DataCell(Text((person['puntaje'] ?? 0).toString())),
                          ]);
                        }).toList(),
                      ),
                    ),
                  ),
                );
              } else {
                return Center(child: Text('No hay datos'));
              }
            },
          ),
        ],
      ),
    );
  }
}
