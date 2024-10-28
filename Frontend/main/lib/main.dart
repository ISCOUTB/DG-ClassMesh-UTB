import 'package:flutter/material.dart';
import 'preview.dart'; // Importa el archivo preview.dart
import 'schedule.dart'; // Importa el archivo schedule.dart

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'ClassMesh - Plataforma de Horarios',
      theme: ThemeData(
        primaryColor: const Color(0xFF1B399E),
        textTheme: const TextTheme(
          displayLarge: TextStyle(fontSize: 28, fontWeight: FontWeight.bold, color: Color(0xFF003366)),
          displayMedium: TextStyle(fontSize: 24, fontWeight: FontWeight.bold, color: Color(0xFF003366)),
          bodyLarge: TextStyle(fontSize: 16, color: Color(0xFF666666)),
          bodyMedium: TextStyle(fontSize: 14, color: Color(0xFF666666)),
        ),
      ),
      initialRoute: '/',
      routes: {
        '/': (context) => const HomePage(),
        '/preview': (context) => const ClassMeshPreview(),
        '/schedule': (context) => const HorarioScreen(), // Ruta para el HorarioScreen
      },
    );
  }
}

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    final Size screenSize = MediaQuery.of(context).size;

    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color.fromARGB(255, 19, 9, 155),
        elevation: 0,
        title: Row(
          children: [
            Image.asset(
              'assets/logo_alt.png', // Reemplaza con la ruta de tu logo
              height: screenSize.height * 0.05,
            ),
            Expanded(
              child: Container(
                height: screenSize.height * 0.05,
              ),
            ),
          ],
        ),
      ),
      body: Column(
        children: <Widget>[
          Expanded(
            child: SingleChildScrollView(
              child: Padding(
                padding: EdgeInsets.all(screenSize.width * 0.05),
                child: Card(
                  elevation: 5,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(15),
                  ),
                  child: Padding(
                    padding: EdgeInsets.all(screenSize.width * 0.05),
                    child: Column(
                      children: [
                        LayoutBuilder(
                          builder: (context, constraints) {
                            final isSmallWidth = constraints.maxWidth < 600;
                            return Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: <Widget>[
                                // Imagen de horario de ejemplo centrada
                                ClipRRect(
                                  borderRadius: BorderRadius.circular(10),
                                  child: Image.asset(
                                    'assets/schedule.jpg', // Reemplaza con la ruta de tu imagen
                                    fit: BoxFit.cover,
                                    height: isSmallWidth ? 200 : 250,
                                    width: double.infinity,
                                  ),
                                ),
                                const SizedBox(height: 15),
                                const Center(
                                  child: Text(
                                    'Imágenes de horarios de ejemplo',
                                    style: TextStyle(
                                      fontSize: 14,
                                      color: Colors.black54,
                                      fontWeight: FontWeight.w500,
                                    ),
                                  ),
                                ),
                                const SizedBox(height: 25),
                                // Texto y descripción
                                Text(
                                  'Simplifica tu planificación de horarios',
                                  style: Theme.of(context).textTheme.displayMedium,
                                ),
                                const SizedBox(height: 10),
                                Text(
                                  'ClassMesh-UTB te ayuda a gestionar y visualizar tus horarios de clases de manera simple y eficiente. Organiza mejor tu jornada gracias a esta herramienta.',
                                  style: Theme.of(context).textTheme.bodyLarge,
                                ),
                                const SizedBox(height: 20),
                                // Botón "Empezar ahora"
                                Center(
                                  child: ElevatedButton(
                                    onPressed: () {
                                      Navigator.pushNamed(context, '/preview');
                                    },
                                    style: ElevatedButton.styleFrom(
                                      padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 15),
                                      shape: RoundedRectangleBorder(
                                        borderRadius: BorderRadius.circular(8),
                                      ),
                                      backgroundColor: const Color(0xFF1B399E),
                                      elevation: 4,
                                    ),
                                    child: const Text(
                                      'Empezar ahora',
                                      style: TextStyle(color: Colors.white, fontSize: 16),
                                    ),
                                  ),
                                ),
                                const SizedBox(height: 20),
                              ],
                            );
                          },
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ),
          Container(
            height: 50,
            alignment: Alignment.center,
            color: const Color(0xFF003366),
            child: const Text(
              '© 2024 ClassMesh. Todos los derechos reservados.',
              style: TextStyle(color: Colors.white),
            ),
          ),
        ],
      ),
    );
  }
}
