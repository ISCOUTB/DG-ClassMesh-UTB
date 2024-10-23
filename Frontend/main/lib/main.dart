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
    // Obtener el tamaño de la pantalla usando MediaQuery
    final Size screenSize = MediaQuery.of(context).size;
    final bool isSmallScreen = screenSize.width < 600;

    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color(0xFF1B399E),
        title: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Image.asset(
              'assets/logo_alt.png', // Reemplaza con la ruta de tu logo
              height: isSmallScreen ? 30 : 40,
            ),
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
              child: Text(
                isSmallScreen ? 'Generar horarios' : 'Presione aquí para generar horarios',
                style: const TextStyle(color: Colors.black),
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
                            // Verificar si el contenedor es pequeño
                            final isSmallWidth = constraints.maxWidth < 600;
                            return Row(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: <Widget>[
                                Expanded(
                                  flex: isSmallWidth ? 1 : 3,
                                  child: Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: <Widget>[
                                      Text(
                                        'Simplifica tu planificación de horarios',
                                        style: TextStyle(
                                          fontSize: isSmallWidth ? 20 : 24,
                                          fontWeight: FontWeight.bold,
                                          color: const Color(0xFF003366),
                                        ),
                                      ),
                                      const SizedBox(height: 10),
                                      Text(
                                        'ClassMesh-UTB te ayuda a gestionar y visualizar tus horarios de clases de manera simple y eficiente. Organiza mejor tu jornada gracias a esta herramienta.',
                                        style: TextStyle(
                                          fontSize: isSmallWidth ? 14 : 16,
                                          color: const Color(0xFF666666),
                                        ),
                                      ),
                                      const SizedBox(height: 20),
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
                                          height: isSmallWidth ? 100 : 150,
                                          width: double.infinity,
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
