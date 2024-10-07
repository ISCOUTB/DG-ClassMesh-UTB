import 'package:flutter/material.dart';

class HorarioScreen extends StatefulWidget {
  const HorarioScreen({super.key});

  @override
  State<HorarioScreen> createState() => _HorarioScreenState();
}

class Schedule {
  final List<String> days;
  final String startTime;
  final String endTime;

  Schedule({required this.days, required this.startTime, required this.endTime});
}

class Course {
  final String courseTitle;
  final List<Schedule> schedule;
  final Color color; // Agregar propiedad de color al curso

  Course({required this.courseTitle, required this.schedule, required this.color});
}

// Definimos la clase ScheduleWithCourse para tener el horario y el título del curso asociado
class ScheduleWithCourse {
  final String courseTitle;
  final Schedule schedule;
  final Color color; // Agregar propiedad de color

  ScheduleWithCourse(
      {required this.courseTitle, required this.schedule, required this.color});
}

// Datos de ejemplo para Facultades y Cursos
class Faculty {
  final String name;
  final List<Course> courses;

  Faculty({required this.name, required this.courses});
}

List<Faculty> faculties = [
  Faculty(
    name: "Facultad de Ingeniería de Sistemas",
    courses: [
      Course(
        courseTitle: "Fundamentos de Programación",
        schedule: [
          Schedule(days: ["Lunes"], startTime: "08:00", endTime: "10:00"),
          Schedule(days: ["Miércoles"], startTime: "14:00", endTime: "16:00"),
        ],
        color: Colors.orange,
      ),
      Course(
        courseTitle: "Estructuras de Datos",
        schedule: [
          Schedule(days: ["Martes"], startTime: "09:00", endTime: "11:00"),
          Schedule(days: ["Jueves"], startTime: "15:00", endTime: "17:00"),
        ],
        color: Colors.green,
      ),
    ],
  ),
  Faculty(
    name: "Facultad de Ciencias Básicas",
    courses: [
      Course(
        courseTitle: "Física III",
        schedule: [
          Schedule(days: ["Lunes"], startTime: "10:00", endTime: "12:00"),
          Schedule(days: ["Miércoles"], startTime: "13:00", endTime: "15:00"),
        ],
        color: Colors.purple,
      ),
      Course(
        courseTitle: "Química General",
        schedule: [
          Schedule(days: ["Martes"], startTime: "11:00", endTime: "13:00"),
          Schedule(days: ["Jueves"], startTime: "14:00", endTime: "16:00"),
        ],
        color: Colors.blue,
      ),
    ],
  ),
  Faculty(
    name: "Facultad de Ciencias Humanidades y Lenguas Extranjeras",
    courses: [
      Course(
        courseTitle: "Historia del Arte",
        schedule: [
          Schedule(days: ["Miércoles"], startTime: "09:00", endTime: "11:00"),
          Schedule(days: ["Viernes"], startTime: "13:00", endTime: "15:00"),
        ],
        color: Colors.yellow,
      ),
      Course(
        courseTitle: "Inglés III",
        schedule: [
          Schedule(days: ["Martes"], startTime: "08:00", endTime: "10:00"),
          Schedule(days: ["Jueves"], startTime: "16:00", endTime: "18:00"),
        ],
        color: Colors.red,
      ),
    ],
  ),
  Faculty(
    name: "Facultad de Ciencias Humanidades",
    courses: [
      Course(
        courseTitle: "Filosofía Moderna",
        schedule: [
          Schedule(days: ["Lunes"], startTime: "13:00", endTime: "15:00"),
          Schedule(days: ["Miércoles"], startTime: "10:00", endTime: "12:00"),
        ],
        color: Colors.teal,
      ),
      Course(
        courseTitle: "Psicología Social",
        schedule: [
          Schedule(days: ["Martes"], startTime: "12:00", endTime: "14:00"),
          Schedule(days: ["Jueves"], startTime: "09:00", endTime: "11:00"),
        ],
        color: Colors.pink,
      ),
    ],
  ),
];

class _HorarioScreenState extends State<HorarioScreen> {
  String? selectedFaculty; // Facultad seleccionada
  String? selectedCourse; // Curso seleccionado
  List<Course> selectedCourses = []; // Lista de cursos seleccionados
  List<List<ScheduleWithCourse>> generatedSchedules = [];
  int currentScheduleIndex = 0;
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
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
            const CircleAvatar(
              backgroundImage: AssetImage('assets/profile.jpg'),
            ),
          ],
        ),
      ),
      // ... (Drawer code)
      body: Row(
        children: [
          Expanded(
            flex: 3,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Título y conteo de horarios
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Padding(
                      padding: EdgeInsets.only(left: 8.0),
                      child: Text(
                        'Horarios Generados',
                        style: TextStyle(fontSize: 20),
                      ),
                    ),
                    // Conteo visible solo después de generar horarios
                    if (generatedSchedules.isNotEmpty)
                      Padding(
                        padding: const EdgeInsets.only(right: 8.0),
                        child: Text(
                          '${currentScheduleIndex + 1}-${generatedSchedules.length}',
                          style: const TextStyle(fontSize: 16),
                        ),
                      ),
                  ],
                ),
                Expanded(
                  child: _buildTimetable(),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    // Botón "Anterior" con cambio de color
                    ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.blue, // Color de fondo
                        foregroundColor: Colors.white, // Color del texto
                        // Sombras para el efecto de presionado
                        elevation: 4,
                        shadowColor: Colors.black.withOpacity(0.3),
                      ),
                      onPressed: () {
                        if (currentScheduleIndex > 0) {
                          setState(() {
                            currentScheduleIndex--;
                          });
                        }
                      },
                      child: const Text('Anterior'),
                    ),
                    // Botón "Generar Horario" con cambio de color
                    ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.blue, // Color de fondo
                        foregroundColor: Colors.white, // Color del texto
                        // Sombras para el efecto de presionado
                        elevation: 4,
                        shadowColor: Colors.black.withOpacity(0.3),
                      ),
                      onPressed: () {
                        setState(() {
                          generatedSchedules =
                              generateAllCombinations(selectedCourses);
                          currentScheduleIndex = 0;
                        });
                      },
                      child: const Text('Generar Horario'),
                    ),
                    // Botón "Siguiente" con cambio de color
                    ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.blue, // Color de fondo
                        foregroundColor: Colors.white, // Color del texto
                        // Sombras para el efecto de presionado
                        elevation: 4,
                        shadowColor: Colors.black.withOpacity(0.3),
                      ),
                      onPressed: () {
                        if (currentScheduleIndex <
                            generatedSchedules.length - 1) {
                          setState(() {
                            currentScheduleIndex++;
                          });
                        }
                      },
                      child: const Text('Siguiente'),
                    ),
                  ],
                )
              ],
            ),
          ),
          const VerticalDivider(),
          Expanded(
            flex: 2,
            child: Column(
              children: [
                // Dropdown para seleccionar Facultad
                DropdownButton<String>(
                  hint: const Text('Seleccionar Facultad'),
                  value: selectedFaculty,
                  items: faculties.map((faculty) {
                    return DropdownMenuItem<String>(
                      value: faculty.name,
                      child: Text(faculty.name),
                    );
                  }).toList(),
                  onChanged: (String? newValue) {
                    setState(() {
                      selectedFaculty = newValue;
                      selectedCourse = null; // Reiniciar al cambiar facultad
                    });
                  },
                ),
                const SizedBox(height: 16.0),

                // Dropdown para seleccionar Curso
                DropdownButton<String>(
                  hint: const Text('Seleccionar Curso'),
                  value: selectedCourse,
                  items: selectedFaculty != null
                      ? faculties
                          .firstWhere((f) => f.name == selectedFaculty)
                          .courses
                          .map((course) {
                            return DropdownMenuItem<String>(
                              value: course.courseTitle,
                              child: Text(course.courseTitle),
                            );
                          }).toList()
                      : null,
                  onChanged: (String? newValue) {
                    setState(() {
                      selectedCourse = newValue;
                    });
                  },
                ),
                const SizedBox(height: 16.0),
                // Botón "Agregar Curso" con cambio de color
                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.blue, // Color de fondo
                    foregroundColor: Colors.white, // Color del texto
                    // Sombras para el efecto de presionado
                    elevation: 4,
                    shadowColor: Colors.black.withOpacity(0.3),
                  ),
                  onPressed: addSelectedCourse,
                  child: const Text('Agregar Curso'),
                ),
                const SizedBox(height: 16.0),
                Expanded(
                  child: ListView.builder(
                    itemCount: selectedCourses.length,
                    itemBuilder: (context, index) {
                      return Card(
                        margin: const EdgeInsets.all(8.0),
                        color: selectedCourses[index].color, // Usar el color del curso
                        child: ListTile(
                          title: Text(
                            selectedCourses[index].courseTitle,
                            style: const TextStyle(color: Colors.white), // Texto blanco para mejor contraste
                          ),
                          trailing: IconButton(
                            icon: const Icon(Icons.delete, color: Colors.white), // Icono blanco
                            onPressed: () {
                              setState(() {
                                selectedCourses.remove(selectedCourses[index]);
                              });
                            },
                          ),
                        ),
                      );
                    },
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  // Función para agregar el curso seleccionado
  void addSelectedCourse() {
    if (selectedCourse != null &&
        !selectedCourses.any((c) => c.courseTitle == selectedCourse)) {
      showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            title: const Text('Confirmación'),
            content:
                Text('¿Estás seguro de que deseas agregar "$selectedCourse"?'),
            actions: [
              TextButton(
                onPressed: () {
                  setState(() {
                    selectedCourses.add(faculties
                        .firstWhere((f) => f.name == selectedFaculty)
                        .courses
                        .firstWhere(
                            (c) => c.courseTitle == selectedCourse));
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

  Widget _buildTimetable() {
    List<String> days = [
      'Lunes',
      'Martes',
      'Miércoles',
      'Jueves',
      'Viernes'
    ];
    return GridView.builder(
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: days.length,
        childAspectRatio: 0.5,
      ),
      itemCount: days.length,
      itemBuilder: (context, index) {
        String day = days[index];
        return _buildDayColumn(day);
      },
    );
  }

  Widget _buildDayColumn(String day) {
    List<Widget> events = [];
    if (generatedSchedules.isNotEmpty) {
      List<ScheduleWithCourse> currentCombination =
          generatedSchedules[currentScheduleIndex];

      // Ordenar los horarios por hora de inicio usando DateTime para comparación
      currentCombination.sort((a, b) {
        bool aContainsDay = a.schedule.days.contains(day);
        bool bContainsDay = b.schedule.days.contains(day);

        // Si ambos tienen el día, comparamos las horas de inicio
        if (aContainsDay && bContainsDay) {
          DateTime startTimeA = _timeStringToDateTime(a.schedule.startTime);
          DateTime startTimeB = _timeStringToDateTime(b.schedule.startTime);
          return startTimeA.compareTo(startTimeB);
        }

        // Si solo uno de los dos tiene el día, el que lo tiene va primero
        if (aContainsDay && !bContainsDay) {
          return -1; // a va antes que b
        }

        if (!aContainsDay && bContainsDay) {
          return 1; // b va antes que a
        }

        // Si ninguno tiene el día, mantenemos el orden original
        return 0;
      });

      for (var scheduleWithCourse in currentCombination) {
        if (scheduleWithCourse.schedule.days.contains(day)) {
          events.add(Container(
            margin: const EdgeInsets.all(4.0),
            padding: const EdgeInsets.all(8.0),
            decoration: BoxDecoration(
              color: scheduleWithCourse.color, // Usar el color del curso
              borderRadius: BorderRadius.circular(10),
            ),
            child: Column(
              children: [
                Text(
                  scheduleWithCourse.courseTitle,
                  style: const TextStyle(fontWeight: FontWeight.bold, color: Colors.white), // Texto blanco para mejor contraste
                ),
                Text(
                    '${scheduleWithCourse.schedule.startTime} - ${scheduleWithCourse.schedule.endTime}',
                    style: const TextStyle(color: Colors.white), // Texto blanco
                ),
              ],
            ),
          ));
        }
      }
    }
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(day, style: const TextStyle(fontWeight: FontWeight.bold)),
        Expanded(
          child: ListView(children: events),
        ),
      ],
    );
  }

  List<List<ScheduleWithCourse>> generateAllCombinations(
      List<Course> selectedCourses) {
    List<List<ScheduleWithCourse>> validCombinations = [];

    if (selectedCourses.isNotEmpty) {
      _combineSchedulesRecursive(0, selectedCourses, [], validCombinations);
    }

    return validCombinations;
  }

  void _combineSchedulesRecursive(
    int index,
    List<Course> courses,
    List<ScheduleWithCourse> currentCombination,
    List<List<ScheduleWithCourse>> validCombinations,
  ) {
    if (index == courses.length) {
      if (isValidCombination(currentCombination)) {
        validCombinations.add(List.from(currentCombination));
      }
      return;
    }

    for (var schedule in courses[index].schedule) {
      currentCombination.add(ScheduleWithCourse(
          courseTitle: courses[index].courseTitle,
          schedule: schedule,
          color: courses[index].color)); // Agregar color al ScheduleWithCourse
      _combineSchedulesRecursive(
          index + 1, courses, currentCombination, validCombinations);
      currentCombination.removeLast();
    }
  }

  // Función para validar si una combinación de horarios es válida
  bool isValidCombination(List<ScheduleWithCourse> combination) {
    for (int i = 0; i < combination.length; i++) {
      for (int j = i + 1; j < combination.length; j++) {
        if (_schedulesOverlap(combination[i].schedule, combination[j].schedule)) {
          return false;
        }
      }
    }
    return true;
  }

  // Función para verificar si dos horarios se superponen
  bool _schedulesOverlap(Schedule schedule1, Schedule schedule2) {
    // Verificar si hay intersección en los días
    if (schedule1.days.any((day) => schedule2.days.contains(day))) {
      // Convertir horas de inicio y fin a DateTime para facilitar la comparación
      DateTime startTime1 = _timeStringToDateTime(schedule1.startTime);
      DateTime endTime1 = _timeStringToDateTime(schedule1.endTime);
      DateTime startTime2 = _timeStringToDateTime(schedule2.startTime);
      DateTime endTime2 = _timeStringToDateTime(schedule2.endTime);

      // Verificar si hay superposición en los rangos de tiempo
      if (startTime1.isBefore(endTime2) && startTime2.isBefore(endTime1)) {
        return true;
      }
    }
    return false;
  }

  // Función auxiliar para convertir una cadena de tiempo a DateTime
  DateTime _timeStringToDateTime(String timeString) {
    List<String> parts = timeString.split(':');
    int hour = int.parse(parts[0]);
    int minute = int.parse(parts[1]);
    return DateTime(DateTime.now().year, DateTime.now().month,
        DateTime.now().day, hour, minute);
  }
}