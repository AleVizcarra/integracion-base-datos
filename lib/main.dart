import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Películas Firebase',
      theme: ThemeData.dark(),
      home: const MovieApp(),
    );
  }
}

class MovieApp extends StatefulWidget {
  const MovieApp({super.key});

  @override
  State<MovieApp> createState() => _MovieAppState();
}

class _MovieAppState extends State<MovieApp> {
  final _nombreController = TextEditingController();
  final _sinopsisController = TextEditingController();
  final _anioController = TextEditingController();

  final _formKey = GlobalKey<FormState>();

  Future<void> _agregarPelicula() async {
    if (_formKey.currentState!.validate()) {
      await FirebaseFirestore.instance.collection('peliculas').add({
        'nombre': _nombreController.text,
        'sinopsis': _sinopsisController.text,
        'anio': _anioController.text,
        'fecha': FieldValue.serverTimestamp(),
      });

      _nombreController.clear();
      _sinopsisController.clear();
      _anioController.clear();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Catálogo de Películas')),
      body: Padding(
        padding: const EdgeInsets.all(12),
        child: Column(
          children: [
            Form(
              key: _formKey,
              child: Column(
                children: [
                  TextFormField(
                    controller: _nombreController,
                    decoration: const InputDecoration(labelText: 'Nombre'),
                    validator:
                        (value) => value!.isEmpty ? 'Ingrese un nombre' : null,
                  ),
                  TextFormField(
                    controller: _sinopsisController,
                    decoration: const InputDecoration(labelText: 'Sinopsis'),
                    validator:
                        (value) =>
                            value!.isEmpty ? 'Ingrese una sinopsis' : null,
                  ),
                  TextFormField(
                    controller: _anioController,
                    decoration: const InputDecoration(
                      labelText: 'Año de estreno',
                    ),
                    keyboardType: TextInputType.number,
                    validator:
                        (value) => value!.isEmpty ? 'Ingrese un año' : null,
                  ),
                  const SizedBox(height: 10),
                  ElevatedButton(
                    onPressed: _agregarPelicula,
                    child: const Text('Agregar película'),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 20),
            const Text('Películas guardadas:', style: TextStyle(fontSize: 18)),
            const SizedBox(height: 10),
            Expanded(
              child: StreamBuilder<QuerySnapshot>(
                stream:
                    FirebaseFirestore.instance
                        .collection('peliculas')
                        .orderBy('fecha', descending: true)
                        .snapshots(),
                builder: (context, snapshot) {
                  if (!snapshot.hasData)
                    return const CircularProgressIndicator();

                  final docs = snapshot.data!.docs;
                  return ListView.builder(
                    itemCount: docs.length,
                    itemBuilder: (context, index) {
                      final data = docs[index];
                      return ListTile(
                        title: Text(data['nombre']),
                        subtitle: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              '${data['anio']}',
                              style: const TextStyle(
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                            const SizedBox(height: 4),
                            Text(data['sinopsis']),
                          ],
                        ),
                      );
                    },
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
