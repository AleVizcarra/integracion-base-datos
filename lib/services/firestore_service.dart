import 'package:cloud_firestore/cloud_firestore.dart';
import '../models/movie.dart';

class FirestoreService {
  final CollectionReference _moviesCollection = FirebaseFirestore.instance
      .collection('peliculas');

  // Obtener todas las películas como stream
  Stream<List<Movie>> getMovies() {
    return _moviesCollection.snapshots().map((snapshot) {
      return snapshot.docs.map((doc) {
        return Movie.fromMap(doc.id, doc.data() as Map<String, dynamic>);
      }).toList();
    });
  }

  // Agregar una película nueva
  Future<void> addMovie(Movie movie) async {
    await _moviesCollection.add(movie.toMap());
  }

  // Eliminar una película por su ID
  Future<void> deleteMovie(String id) async {
    await _moviesCollection.doc(id).delete();
  }

  // Actualizar una película por su ID
  Future<void> updateMovie(String id, Movie movie) async {
    await _moviesCollection.doc(id).update(movie.toMap());
  }

  // Obtener una película específica por ID
  Future<Movie?> getMovieById(String id) async {
    final doc = await _moviesCollection.doc(id).get();
    if (doc.exists) {
      return Movie.fromMap(doc.id, doc.data() as Map<String, dynamic>);
    } else {
      return null;
    }
  }
}
