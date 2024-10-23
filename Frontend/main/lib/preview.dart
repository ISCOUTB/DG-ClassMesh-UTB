import 'package:flutter/material.dart';
import 'schedule.dart'; // Importa el archivo schedule.dart

void main() {
  runApp(const ClassMeshApp());
}

class ClassMeshApp extends StatelessWidget {
  const ClassMeshApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      initialRoute: '/',
      routes: {
        '/': (context) => const ClassMeshHome(),
        '/schedule': (context) => const HorarioScreen(),
      },
    );
  }
}

class ClassMeshHome extends StatefulWidget {
  const ClassMeshHome({super.key});

  @override
  State<ClassMeshHome> createState() => _ClassMeshHomeState();
}

class _ClassMeshHomeState extends State<ClassMeshHome> {
  final List<Map<String, dynamic>> _schedules = List.generate(4, (index) {
    return {
      'name': 'Horario #${index + 1}',
      'visible': true,
    };
  });
  final String _searchTerm = "";

  Widget _buildDrawerItem(IconData icon, String title, BuildContext context) {
    return ListTile(
      leading: Icon(icon),
      title: Text(title),
      onTap: () {
        Navigator.pop(context);
        if (title == 'Horarios') {
          Navigator.pushNamed(context, '/schedule');
        }
      },
    );
  }

  void _showDeleteConfirmationDialog(int index) {
  showDialog(
    context: context,
    builder: (BuildContext context) {
      return AlertDialog(
        title: const Text('Eliminar horario?'),
        content: Text(
          '¿Estás seguro de que deseas eliminar "${_schedules[index]['name']}"? Esta acción no se puede deshacer.',
        ),
        actions: <Widget>[
          TextButton(
            onPressed: () => Navigator.of(context).pop(),
            child: const Text('Cancelar'),
          ),
          TextButton(
            style: TextButton.styleFrom(
              backgroundColor: Colors.red,
            ),
            onPressed: () {
              setState(() {
                // Eliminar el elemento de la lista
                _schedules.removeAt(index);
                
                // Reorganizar los nombres para reflejar las nuevas posiciones
                for (int i = 0; i < _schedules.length; i++) {
                  _schedules[i]['name'] = 'Horario #${i + 1}';
                }
              });
              Navigator.of(context).pop();
            },
            child: const Text(
              'Eliminar',
              style: TextStyle(color: Colors.white),
            ),
          ),
        ],
      );
    },
  );
}


  @override
  Widget build(BuildContext context) {
    final screenSize = MediaQuery.of(context).size;

    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color.fromARGB(255, 19, 9, 155),
        elevation: 0,
        title: Row(
          children: [
            Image.asset(
              'assets/logo_alt.png',
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
      drawer: Drawer(
        child: ListView(
          padding: EdgeInsets.zero,
          children: <Widget>[
            DrawerHeader(
              decoration: const BoxDecoration(
                color: Color.fromARGB(255, 19, 9, 155),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Image.asset(
                    'assets/logo_alt.png',
                    height: screenSize.height * 0.05,
                  ),
                ],
              ),
            ),
            _buildDrawerItem(Icons.home, 'Inicio', context),
            _buildDrawerItem(Icons.schedule, 'Horarios', context),
          ],
        ),
      ),
      body: Padding(
        padding: EdgeInsets.all(screenSize.width * 0.05),
        child: LayoutBuilder(
          builder: (context, constraints) {
            int crossAxisCount;
            if (constraints.maxWidth > 1200) {
              crossAxisCount = 4;
            } else if (constraints.maxWidth > 800) {
              crossAxisCount = 3;
            } else if (constraints.maxWidth > 600) {
              crossAxisCount = 2;
            } else {
              crossAxisCount = 1;
            }

            return GridView.builder(
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: crossAxisCount,
                crossAxisSpacing: constraints.maxWidth * 0.02,
                mainAxisSpacing: constraints.maxHeight * 0.02,
              ),
              itemCount: _schedules.length,
              itemBuilder: (context, index) {
                final schedule = _schedules[index];

                if (schedule['visible'] &&
                    schedule['name']
                        .toLowerCase()
                        .contains(_searchTerm.toLowerCase())) {
                  return Card(
                    elevation: 5,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Flexible(
                          child: Container(
                            width: double.infinity,
                            decoration: const BoxDecoration(
                              borderRadius: BorderRadius.only(
                                topLeft: Radius.circular(20),
                                topRight: Radius.circular(20),
                              ),
                            ),
                            child: Image.asset(
                              'assets/schedule.jpg',
                              fit: BoxFit.cover,
                              height: constraints.maxWidth > 600
                                  ? constraints.maxHeight * 0.25
                                  : constraints.maxHeight * 0.20,
                            ),
                          ),
                        ),
                        Padding(
                          padding: EdgeInsets.all(constraints.maxWidth * 0.02),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Flexible(
                                child: Text(
                                  schedule['name'],
                                  style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    fontSize: constraints.maxWidth * 0.04,
                                  ),
                                ),
                              ),
                              IconButton(
                                icon: const Icon(Icons.close),
                                color: Colors.red,
                                onPressed: () =>
                                    _showDeleteConfirmationDialog(index),
                              ),
                            ],
                          ),
                        ),
                        Padding(
                          padding: EdgeInsets.symmetric(
                              horizontal: constraints.maxWidth * 0.02),
                          child: ElevatedButton(
                            onPressed: () {
                              Navigator.pushNamed(context, '/schedule');
                            },
                            style: ElevatedButton.styleFrom(
                              backgroundColor:
                                  const Color.fromARGB(255, 66, 71, 164),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(10),
                              ),
                            ),
                            child: Text(
                              'Editar',
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: constraints.maxWidth * 0.03,
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  );
                } else {
                  return const SizedBox.shrink();
                }
              },
            );
          },
        ),
      ),
    );
  }
}
