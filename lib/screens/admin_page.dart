import 'package:flutter/material.dart';
import '../services/firestore_service.dart';
import '../models/movie.dart';

class AdminPage extends StatefulWidget {
  const AdminPage({super.key});

  @override
  State<AdminPage> createState() => _AdminPageState();
}

class _AdminPageState extends State<AdminPage> {
  final _formKey = GlobalKey<FormState>();

  final _titleController = TextEditingController();
  final _yearController = TextEditingController();
  final _directorController = TextEditingController();
  final _genreController = TextEditingController();
  final _synopsisController = TextEditingController();
  final _imageUrlController = TextEditingController();

  void _addMovie() async {
    if (_formKey.currentState!.validate()) {
      final movie = Movie(
        id: '',
        title: _titleController.text.trim(),
        year: _yearController.text.trim(),
        director: _directorController.text.trim(),
        genre: _genreController.text.trim(),
        synopsis: _synopsisController.text.trim(),
        imageUrl: _imageUrlController.text.trim(),
      );

      await FirestoreService().addMovie(movie);

      _titleController.clear();
      _yearController.clear();
      _directorController.clear();
      _genreController.clear();
      _synopsisController.clear();
      _imageUrlController.clear();
    }
  }

  void _deleteMovie(String id) async {
    await FirestoreService().deleteMovie(id);
  }

  @override
  void dispose() {
    _titleController.dispose();
    _yearController.dispose();
    _directorController.dispose();
    _genreController.dispose();
    _synopsisController.dispose();
    _imageUrlController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    const amarillo = Color(0xFFfef197);

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.black,
        iconTheme: const IconThemeData(color: Colors.white),
        title: const Text(
          'Administrar Películas',
          style: TextStyle(color: amarillo),
        ),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            Form(
              key: _formKey,
              child: Column(
                children: [
                  TextFormField(
                    controller: _titleController,
                    decoration: const InputDecoration(labelText: 'Título'),
                    validator:
                        (value) => value!.isEmpty ? 'Campo requerido' : null,
                  ),
                  TextFormField(
                    controller: _yearController,
                    decoration: const InputDecoration(labelText: 'Año'),
                    keyboardType: TextInputType.number,
                    validator:
                        (value) => value!.isEmpty ? 'Campo requerido' : null,
                  ),
                  TextFormField(
                    controller: _directorController,
                    decoration: const InputDecoration(labelText: 'Director'),
                    validator:
                        (value) => value!.isEmpty ? 'Campo requerido' : null,
                  ),
                  TextFormField(
                    controller: _genreController,
                    decoration: const InputDecoration(labelText: 'Género'),
                    validator:
                        (value) => value!.isEmpty ? 'Campo requerido' : null,
                  ),
                  TextFormField(
                    controller: _synopsisController,
                    decoration: const InputDecoration(labelText: 'Sinopsis'),
                    maxLines: 3,
                    validator:
                        (value) => value!.isEmpty ? 'Campo requerido' : null,
                  ),
                  TextFormField(
                    controller: _imageUrlController,
                    decoration: const InputDecoration(
                      labelText: 'URL de la imagen',
                    ),
                    validator:
                        (value) => value!.isEmpty ? 'Campo requerido' : null,
                  ),
                  const SizedBox(height: 16),
                  ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: amarillo,
                      foregroundColor: Colors.black,
                    ),
                    onPressed: _addMovie,
                    child: const Text('Agregar película'),
                  ),
                  const SizedBox(height: 20),
                  const Divider(),
                ],
              ),
            ),
            const SizedBox(height: 10),
            const Text(
              'Películas registradas',
              style: TextStyle(fontSize: 18, color: amarillo),
            ),
            const SizedBox(height: 10),
            StreamBuilder(
              stream: FirestoreService().getMovies(),
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return const CircularProgressIndicator();
                }

                if (!snapshot.hasData || snapshot.data!.isEmpty) {
                  return const Text('No hay películas registradas');
                }

                final movies = snapshot.data!;
                return ListView.builder(
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  itemCount: movies.length,
                  itemBuilder: (context, index) {
                    final movie = movies[index];
                    return Card(
                      margin: const EdgeInsets.symmetric(vertical: 6),
                      child: ListTile(
                        leading:
                            movie.imageUrl.isNotEmpty
                                ? Image.network(
                                  movie.imageUrl,
                                  width: 50,
                                  fit: BoxFit.cover,
                                )
                                : const Icon(Icons.movie),
                        title: Text(movie.title),
                        subtitle: Text('${movie.year} - ${movie.director}'),
                        trailing: IconButton(
                          icon: const Icon(Icons.delete, color: Colors.red),
                          onPressed: () => _deleteMovie(movie.id),
                        ),
                      ),
                    );
                  },
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}
