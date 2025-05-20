class Movie {
  final String id;
  final String title;
  final String year;
  final String director;
  final String genre;
  final String synopsis;
  final String imageUrl;

  Movie({
    required this.id,
    required this.title,
    required this.year,
    required this.director,
    required this.genre,
    required this.synopsis,
    required this.imageUrl,
  });

  // Método para crear una instancia desde un documento de Firestore
  factory Movie.fromMap(String id, Map<String, dynamic> data) {
    return Movie(
      id: id,
      title: data['title'] ?? '',
      year: data['year'] ?? '',
      director: data['director'] ?? '',
      genre: data['genre'] ?? '',
      synopsis: data['synopsis'] ?? '',
      imageUrl: data['imageUrl'] ?? '',
    );
  }

  // Método para convertir una instancia en un mapa para Firestore
  Map<String, dynamic> toMap() {
    return {
      'title': title,
      'year': year,
      'director': director,
      'genre': genre,
      'synopsis': synopsis,
      'imageUrl': imageUrl,
    };
  }
}
