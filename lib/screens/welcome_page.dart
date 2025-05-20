import 'package:flutter/material.dart';
import '../auth/login_page.dart';
import '../auth/register_page.dart';

class WelcomePage extends StatelessWidget {
  const WelcomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 32.0),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              // Imagen del logo
              Image.asset('assets/images/logo.png', height: 120),
              const SizedBox(height: 24),
              // Texto de bienvenida
              const Text(
                'Bienvenido a Movie Shelf',
                style: TextStyle(
                  fontSize: 28,
                  fontWeight: FontWeight.bold,
                  color: Color(0xFFfef197),
                ),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 40),
              // Botón de registro
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                  foregroundColor: Colors.black,
                  backgroundColor: const Color(0xFFfef197),
                ),
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (_) => const RegisterPage()),
                  );
                },
                child: const Text('Registrarse'),
              ),
              const SizedBox(height: 16),
              // Botón de inicio de sesión
              OutlinedButton(
                style: OutlinedButton.styleFrom(
                  foregroundColor: const Color(0xFFfef197), // Texto
                  side: const BorderSide(color: Color(0xFFfef197)), // Borde
                ),
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (_) => const LoginPage()),
                  );
                },
                child: const Text('Iniciar sesión'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
