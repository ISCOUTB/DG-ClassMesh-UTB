import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class SchedulePage extends StatefulWidget {
  const SchedulePage({super.key});

  @override
  State<SchedulePage> createState() => _SchedulePageState();
}

class _SchedulePageState extends State<SchedulePage> {
  List<Map<String, String>> faculties = [];
  String? selectedFaculty;
  List<String> availableCourses = [];
  String? selectedCourse;
  List<String> selectedCourses = [];

  @override
  void initState() {
    super.initState();
    fetchFaculties(); // Cargar facultades al iniciar
  }

  Future<void> fetchFaculties() async {
    try {
      final response = await http.get(Uri.parse('http://127.0.0.1:8000/faculties'));
      if (response.statusCode == 200) {
        List<dynamic> data = jsonDecode(response.body);
        setState(() {
          faculties = data.map<Map<String, String>>((faculty) {
            return {
              'name': faculty['name'],
              'abbreviation': faculty['abbreviation'],
            };
          }).toList();
        });
      } else {
        throw Exception('Failed to load faculties');
      }
    } catch (e) {
      // ignore: avoid_print
      print('Error fetching faculties: $e');
    }
  }

  Future<void> fetchCourses(String facultyAbbr) async {
    try {
      final response = await http.get(Uri.parse('http://127.0.0.1:8000/faculties/$facultyAbbr/courses'));
      if (response.statusCode == 200) {
        List<dynamic> data = jsonDecode(response.body);
        setState(() {
          availableCourses = data.map<String>((course) => '${course['name']} - ${course['abbreviation']}').toList();
          selectedCourse = null; // Resetear curso seleccionado
        });
      } else {
        throw Exception('Failed to load courses');
      }
    } catch (e) {
      // ignore: avoid_print
      print('Error fetching courses: $e');
    }
  }

  void handleFacultyChange(String? facultyAbbr) {
    setState(() {
      selectedFaculty = facultyAbbr;
      availableCourses = []; // Limpiar cursos disponibles al cambiar facultad
      selectedCourse = null; // Resetear curso seleccionado
    });

    if (facultyAbbr != null) {
      fetchCourses(facultyAbbr); // Cargar cursos de la facultad seleccionada
    }
  }

  void addSelectedCourse() {
    if (selectedCourse != null && !selectedCourses.contains(selectedCourse)) {
      showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            title: const Text('Confirmación'),
            content: Text('¿Estás seguro de que deseas agregar "$selectedCourse"?'),
            actions: [
              TextButton(
                onPressed: () {
                  setState(() {
                    selectedCourses.add(selectedCourse!);
                    selectedCourse = null; // Resetear la selección
                  });
                  Navigator.of(context).pop(); // Cerrar el diálogo
                },
                child: const Text('Sí'),
              ),
              TextButton(
                onPressed: () {
                  Navigator.of(context).pop(); // Cerrar el diálogo sin agregar
                },
                child: const Text('No'),
              ),
            ],
          );
        },
      );
    } else {
      // Mostrar mensaje de error personalizado
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          backgroundColor: Colors.redAccent,
          content: Row(
            children: [
              const Padding(
                padding: EdgeInsets.only(right: 8.0),
                child: Icon(Icons.warning, color: Colors.white),
              ),
              const Text(
                'Selecciona un curso válido para agregar',
                style: TextStyle(color: Colors.white),
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
              'assets/logo_alt.png', // Reemplaza con la ruta de tu logo
              height: 40,
            ),
            const Spacer(),
            const Spacer(),
            const CircleAvatar(
              backgroundImage: AssetImage('assets/profile.jpg'), // Reemplaza con la ruta de tu imagen de perfil
            ),
          ],
        ),
      ),
      body: Row(
        children: [
          Expanded(
            flex: 3,
            child: Padding(
              padding: const EdgeInsets.all(20.0),
              child: Container(
                color: Colors.grey[300],
                child: const Center(
                  child: Text(
                    'HORARIO #1',
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
                  ),
                ),
              ),
            ),
          ),
          Expanded(
            flex: 1,
            child: Column(
              children: [
                const Padding(
                  padding: EdgeInsets.all(10.0),
                  child: Text(
                    'CURSOS SELECCIONADOS',
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
                  ),
                ),
                Expanded(
                  child: ListView(
                    children: selectedCourses.map((course) => Padding(
                      padding: const EdgeInsets.symmetric(vertical: 10.0),
                      child: Container(
                        padding: const EdgeInsets.all(10.0),
                        color: Colors.grey[300],
                        child: Text(course),
                      ),
                    )).toList(),
                  ),
                ),
                // Formulario para facultades
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Container(
                    decoration: BoxDecoration(
                      border: Border.all(color: Colors.grey),
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: DropdownButton<String>(
                      hint: const Padding(
                        padding: EdgeInsets.all(8.0),
                        child: Text('Seleccionar Facultad'),
                      ),
                      value: selectedFaculty,
                      onChanged: handleFacultyChange,
                      items: faculties.map<DropdownMenuItem<String>>((Map<String, String> faculty) {
                        return DropdownMenuItem<String>(
                          value: faculty['abbreviation'],
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Text(faculty['name']!),
                          ),
                        );
                      }).toList(),
                    ),
                  ),
                ),
                // Formulario para cursos
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Container(
                    decoration: BoxDecoration(
                      border: Border.all(color: Colors.grey),
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: DropdownButton<String>(
                      hint: const Padding(
                        padding: EdgeInsets.all(8.0),
                        child: Text('Seleccionar Curso'),
                      ),
                      value: selectedCourse,
                      onChanged: (String? newValue) {
                        setState(() {
                          selectedCourse = newValue;
                        });
                      },
                      items: availableCourses.isNotEmpty
                          ? availableCourses.map<DropdownMenuItem<String>>((String course) {
                              return DropdownMenuItem<String>(
                                value: course,
                                child: Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Text(course),
                                ),
                              );
                            }).toList()
                          : [const DropdownMenuItem(child: Text('No hay cursos disponibles'))],
                    ),
                  ),
                ),
                ElevatedButton(
                  onPressed: addSelectedCourse,
                  child: const Text('Agregar Curso'),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}