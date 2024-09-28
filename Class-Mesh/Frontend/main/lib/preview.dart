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
        '/schedule': (context) => const SchedulePage(),
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
  String _searchTerm = "";

  void _showDeleteConfirmationDialog(int index) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Eliminar horario?'),
          content: Text(
              '¿Estás seguro de que deseas eliminar "${_schedules[index]['name']}"? Esta acción no se puede deshacer.'),
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
                  _schedules[index]['visible'] = false;
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

  void _filterSchedules(String searchTerm) {
    setState(() {
      _searchTerm = searchTerm.toLowerCase();
    });

    if (_searchTerm.isNotEmpty) {
      final searchedSchedules = _schedules.where((schedule) {
        return schedule['name'].toLowerCase().contains(_searchTerm);
      }).toList();

      if (searchedSchedules.isEmpty) {
        _showSearchError("No se encontró ningún horario con ese nombre");
      }
    }
  }

  void _showSearchError(String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        backgroundColor: Colors.redAccent,
        content: Row(
          children: [
            const Padding(
              padding: EdgeInsets.only(right: 8.0),
              child: Icon(Icons.warning, color: Colors.white),
            ),
            Text(
              message,
              style: const TextStyle(color: Colors.white),
            ),
            const Spacer(),
            IconButton(
              onPressed: () {
                ScaffoldMessenger.of(context).hideCurrentSnackBar();
              },
              icon: const Icon(Icons.close, color: Colors.white),
            ),
          ],
        ),
        behavior: SnackBarBehavior.floating,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10.0),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color.fromARGB(255, 19, 9, 155),
        elevation: 0,
        title: Row(
          children: [
            Image.asset(
              'assets/logo_alt.png',
              height: 40,
            ),
            const Spacer(),
            Container(
              width: 200,
              height: 40,
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(30),
              ),
              child: Row(
                children: [
                  IconButton(
                    icon: const Icon(Icons.search),
                    color: Colors.grey,
                    onPressed: () {},
                  ),
                  Expanded(
                    child: TextField(
                      decoration: const InputDecoration(
                        border: InputBorder.none,
                        hintText: 'Buscar...',
                      ),
                      onChanged: _filterSchedules,
                    ),
                  ),
                ],
              ),
            ),
            const Spacer(),
            IconButton(
              icon: const Icon(Icons.notifications_none),
              color: const Color.fromARGB(255, 240, 240, 240),
              onPressed: () {},
            ),
            const CircleAvatar(
              backgroundImage: AssetImage('assets/profile.jpg'),
            ),
          ],
        ),
      ),
      // ... (Drawer code)
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: GridView.builder(
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2,
            crossAxisSpacing: 20,
            mainAxisSpacing: 20,
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
                    Container(
                      height: 350,
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
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(10.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            schedule['name'],
                            style: const TextStyle(
                                fontWeight: FontWeight.bold, fontSize: 16),
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
                      padding: const EdgeInsets.symmetric(horizontal: 10.0),
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
                        child: const Text(
                          'Editar',
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 13,
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
        ),
      ),
    );
  }
} 