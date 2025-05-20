import 'package:flutter/material.dart';
import '../models/movie.dart';

class MovieDetailPage extends StatelessWidget {
  const MovieDetailPage({super.key});

  @override
  Widget build(BuildContext context) {
    final Movie movie = ModalRoute.of(context)!.settings.arguments as Movie;
    const amarillo = Color(0xFFfef197);

    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        backgroundColor: Colors.black,
        title: Text(movie.title, style: const TextStyle(color: amarillo)),
        iconTheme: const IconThemeData(color: Colors.white),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Center(
              child:
                  movie.imageUrl.isNotEmpty
                      ? ClipRRect(
                        borderRadius: BorderRadius.circular(8),
                        child: Image.network(
                          movie.imageUrl,
                          height: 300,
                          fit: BoxFit.cover,
                        ),
                      )
                      : Container(
                        height: 300,
                        width: double.infinity,
                        color: Colors.grey[800],
                        child: const Icon(
                          Icons.image,
                          size: 100,
                          color: Colors.white,
                        ),
                      ),
            ),
            const SizedBox(height: 16),
            Text(
              movie.title,
              style: const TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
                color: Colors.white,
              ),
            ),
            const SizedBox(height: 8),
            RichText(
              text: TextSpan(
                style: const TextStyle(color: Colors.white),
                children: [
                  const TextSpan(
                    text: '🎬 Director: ',
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                  TextSpan(text: movie.director),
                ],
              ),
            ),
            RichText(
              text: TextSpan(
                style: const TextStyle(color: Colors.white),
                children: [
                  const TextSpan(
                    text: '📅 Año: ',
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                  TextSpan(text: movie.year),
                ],
              ),
            ),
            RichText(
              text: TextSpan(
                style: const TextStyle(color: Colors.white),
                children: [
                  const TextSpan(
                    text: '🎭 Género: ',
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                  TextSpan(text: movie.genre),
                ],
              ),
            ),
            const SizedBox(height: 12),
            const Text(
              'Sinopsis:',
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 16,
                color: Colors.white,
              ),
            ),
            const SizedBox(height: 4),
            Text(movie.synopsis, style: const TextStyle(color: Colors.white)),
          ],
        ),
      ),
    );
  }
}
