import 'package:flutter/material.dart';
import 'preview.dart'; // Asegúrate de importar el archivo preview.dart

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'ClassMesh - Plataforma de Horarios',
      initialRoute: '/',
      routes: {
        '/': (context) => const HomePage(),
        '/preview': (context) => const ClassMeshApp(), // Navegar a ClassMeshApp
      },
    );
  }
}

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color(0xFF1B399E),
        title: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Image.asset(
              'assets/logo_alt.png', // Reemplaza con la ruta de tu logo
              height: 40,
            ),
            Row(
              children: [
                ElevatedButton(
                  onPressed: () {
                    Navigator.pushNamed(context, '/preview'); // Navegar a la página preview
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xFFF0DFDF), // Color de fondo del botón
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(5),
                    ),
                  ),
                  child: const Text(
                    'Iniciar sesión con Microsoft 365',
                    style: TextStyle(color: Colors.black),
                  ),
                ),
                const SizedBox(width: 20),
                const CircleAvatar(
                  radius: 20,
                  backgroundImage: AssetImage('assets/icon.png'), // Reemplaza con la ruta de tu ícono de usuario
                ),
              ],
            ),
          ],
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: <Widget>[
            Container(
              padding: const EdgeInsets.all(50),
              child: Card(
                elevation: 5,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(15),
                ),
                child: Container(
                  padding: const EdgeInsets.all(30),
                  child: Row(
                    children: <Widget>[
                      const Expanded(
                        flex: 3,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            Text(
                              'Simplifica tu planificación de horarios',
                              style: TextStyle(
                                fontSize: 24,
                                fontWeight: FontWeight.bold,
                                color: Color(0xFF003366),
                              ),
                            ),
                            SizedBox(height: 10),
                            Text(
                              'ClassMesh-UTB te ayuda a gestionar y visualizar tus horarios de clases de manera simple y eficiente. Organiza mejor tu jornada gracias a esta herramienta.',
                              style: TextStyle(
                                fontSize: 16,
                                color: Color(0xFF666666),
                              ),
                            ),
                            SizedBox(height: 20),
                          ],
                        ),
                      ),
                      const SizedBox(width: 20),
                      Expanded(
                        flex: 2,
                        child: Column(
                          children: [
                            ClipRRect(
                              borderRadius: BorderRadius.circular(10),
                              child: Image.asset(
                                'assets/schedule.jpg', // Reemplaza con la ruta de tu imagen
                                fit: BoxFit.cover,
                              ),
                            ),
                            const SizedBox(height: 10),
                            const Text(
                              'Imágenes de horarios de ejemplo',
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                fontSize: 14,
                                color: Colors.black54,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
            Container(
              padding: const EdgeInsets.all(10),
              color: const Color(0xFF003366),
              child: const Center(
                child: Text(
                  '© 2024 ClassMesh. Todos los derechos reservados.',
                  style: TextStyle(color: Colors.white),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
