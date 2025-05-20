import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:integracion_base_de_datos/auth/login_page.dart';
import 'package:integracion_base_de_datos/auth/register_page.dart';
import 'package:integracion_base_de_datos/screens/welcome_page.dart';
import 'package:integracion_base_de_datos/auth/reset_password_page.dart';
import 'package:integracion_base_de_datos/screens/catalog_page.dart';
import 'package:integracion_base_de_datos/screens/movie_detail_page.dart';
import 'package:integracion_base_de_datos/screens/admin_page.dart';

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
      initialRoute: '/',
      routes: {
        '/': (context) => const WelcomePage(), // Página principal
        '/login': (context) => const LoginPage(), // Pantalla de Login
        '/register': (context) => const RegisterPage(), // Pantalla de Registro
        '/reset-password':
            (context) =>
                const ResetPasswordPage(), //Pantalla para resetear contraseña
        '/catalog': (context) => const CatalogPage(), // Pantalla de Catálogo
        '/movie_detail':
            (context) =>
                const MovieDetailPage(), //Pantalla de detalle de película
        '/admin': (context) => const AdminPage(), //Página de administración
      },
    );
  }
}
