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
  final Color color;

  Course({required this.courseTitle, required this.schedule, required this.color});
}

class ScheduleWithCourse {
  final String courseTitle;
  final Schedule schedule;
  final Color color;

  ScheduleWithCourse({required this.courseTitle, required this.schedule, required this.color});
}

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
          Schedule(days: ["Lunes"], startTime: "15:00", endTime: "17:00"),
        ],
        color: Colors.green,
      ),
    ],
  ),
];

class _HorarioScreenState extends State<HorarioScreen> {
  String? selectedFaculty;
  String? selectedCourse;
  List<Course> selectedCourses = [];
  List<List<ScheduleWithCourse>> generatedSchedules = [];
  int currentScheduleIndex = 0;
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  Widget build(BuildContext context) {
    final screenSize = MediaQuery.of(context).size;
    final orientation = MediaQuery.of(context).orientation;
    final bool isMobile = screenSize.width < 600;

    return Scaffold(
      key: _scaffoldKey,
      appBar: AppBar(
        backgroundColor: const Color.fromARGB(255, 19, 9, 155),
        elevation: 0,
        title: Row(
          children: [
            Image.asset(
              'assets/logo_alt.png',
              height: screenSize.height * 0.05,
              fit: BoxFit.contain,
            ),
          ],
        ),
      ),
      drawer: isMobile
          ? Drawer(
              child: ListView(
                padding: EdgeInsets.zero,
                children: <Widget>[
                  _buildDrawerHeader(screenSize),
                  _buildDrawerItem(Icons.home, 'Inicio', context),
                  _buildDrawerItem(Icons.schedule, 'Horarios', context),
                ],
              ),
            )
          : null,
      body: LayoutBuilder(
        builder: (context, constraints) {
          if (isMobile || orientation == Orientation.portrait) {
            return _buildMobileViewContent();
          } else {
            return Row(
              children: [
                Expanded(
                  flex: 3,
                  child: _buildGeneratedSchedulesPanel(),
                ),
                const VerticalDivider(),
                Expanded(
                  flex: 2,
                  child: _buildSelectionPanel(),
                ),
              ],
            );
          }
        },
      ),
    );
  }

  Widget _buildDrawerHeader(Size screenSize) {
    return DrawerHeader(
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
    );
  }

  Widget _buildDrawerItem(IconData icon, String title, BuildContext context) {
    return ListTile(
      leading: Icon(icon),
      title: Text(title),
      onTap: () {
        Navigator.pop(context);
      },
    );
  }

  Widget _buildGeneratedSchedulesPanel() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _buildGeneratedSchedulesHeader(),
        Expanded(
          child: _buildTimetable(),
        ),
        _buildNavigationButtons(),
      ],
    );
  }

  Widget _buildGeneratedSchedulesHeader() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        const Padding(
          padding: EdgeInsets.only(left: 8.0),
          child: Text(
            'Horarios Generados',
            style: TextStyle(fontSize: 20),
          ),
        ),
        if (generatedSchedules.isNotEmpty)
          Padding(
            padding: const EdgeInsets.only(right: 8.0),
            child: Text(
              '${currentScheduleIndex + 1}-${generatedSchedules.length}',
              style: const TextStyle(fontSize: 16),
            ),
          ),
      ],
    );
  }

  Widget _buildSelectionPanel() {
    return Column(
      children: [
        _buildDropdownFaculty(),
        SizedBox(height: MediaQuery.of(context).size.height * 0.02),
        _buildDropdownCourse(),
        SizedBox(height: MediaQuery.of(context).size.height * 0.02),
        _buildAddCourseButton(),
        SizedBox(height: MediaQuery.of(context).size.height * 0.02),
        Expanded(
          child: _buildSelectedCoursesList(),
        ),
      ],
    );
  }

  Widget _buildDropdownFaculty() {
    return DropdownButton<String>(
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
          selectedCourse = null;
        });
      },
    );
  }

  Widget _buildDropdownCourse() {
    return DropdownButton<String>(
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
    );
  }

  Widget _buildAddCourseButton() {
    return ElevatedButton(
      style: ElevatedButton.styleFrom(
        backgroundColor: Colors.blue,
        foregroundColor: Colors.white,
        elevation: 4,
        shadowColor: Colors.black.withOpacity(0.3),
      ),
      onPressed: addSelectedCourse,
      child: const Text('Agregar Curso'),
    );
  }

  Widget _buildSelectedCoursesList() {
    return ListView.builder(
      itemCount: selectedCourses.length,
      itemBuilder: (context, index) {
        return Card(
          margin: EdgeInsets.symmetric(
              horizontal: MediaQuery.of(context).size.width * 0.02,
              vertical: MediaQuery.of(context).size.height * 0.01),
          color: selectedCourses[index].color,
          child: ListTile(
            title: Text(
              selectedCourses[index].courseTitle,
              style: const TextStyle(color: Colors.white),
            ),
            trailing: IconButton(
              icon: const Icon(Icons.delete, color: Colors.white),
              onPressed: () {
                setState(() {
                  selectedCourses.remove(selectedCourses[index]);
                });
              },
            ),
          ),
        );
      },
    );
  }

Widget _buildTimetable() {
  List<String> days = ['Lunes', 'Martes', 'Miércoles', 'Jueves', 'Viernes'];
  return LayoutBuilder(
    builder: (context, constraints) {
      // Ajustar el childAspectRatio para dar más altura a las columnas de cada día
      double aspectRatio = constraints.maxWidth / (constraints.maxHeight / 0.1); 

      return GridView.builder(
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: days.length, // Una columna por cada día
          childAspectRatio: aspectRatio, // Más alto que ancho
          crossAxisSpacing: constraints.maxWidth * 0.02, // Espacio horizontal entre columnas
          mainAxisSpacing: constraints.maxHeight * 0.02, // Espacio vertical entre filas
        ),
        itemCount: days.length,
        itemBuilder: (context, index) {
          String day = days[index];
          return _buildDayColumn(day);
        },
      );
    },
  );
}

Widget _buildDayColumn(String day) {
  List<Widget> events = [];

  if (generatedSchedules.isNotEmpty) {
    List<ScheduleWithCourse> currentCombination =
        generatedSchedules[currentScheduleIndex];

    // Filtrar y agregar los eventos del día
    currentCombination
        .where((s) => s.schedule.days.contains(day))
        .forEach((scheduleWithCourse) {
      events.add(Container(
        margin: EdgeInsets.symmetric(
          horizontal: MediaQuery.of(context).size.width * 0.01,
          vertical: MediaQuery.of(context).size.height * 0.005,
        ),
        padding: EdgeInsets.all(MediaQuery.of(context).size.width * 0.02),
        decoration: BoxDecoration(
          color: scheduleWithCourse.color,
          borderRadius: BorderRadius.circular(10),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              scheduleWithCourse.courseTitle,
              style: const TextStyle(
                  fontWeight: FontWeight.bold, color: Colors.white),
            ),
            const SizedBox(height: 4),
            Text(
              '${scheduleWithCourse.schedule.startTime} - ${scheduleWithCourse.schedule.endTime}',
              style: const TextStyle(color: Colors.white),
            ),
          ],
        ),
      ));
    });
  }

  return Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      Text(day, style: const TextStyle(fontWeight: FontWeight.bold)),
      const SizedBox(height: 8),
      // Usar Expanded para ocupar el espacio disponible verticalmente
      Expanded(
        child: ListView(
          padding: EdgeInsets.zero, // Quitar padding para maximizar el uso de espacio
          children: events,
        ),
      ),
    ],
  );
}


  Widget _buildNavigationButtons() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        _buildNavButton('Anterior', currentScheduleIndex > 0, () {
          if (currentScheduleIndex > 0) {
            setState(() {
              currentScheduleIndex--;
            });
          }
        }),
        _buildNavButton('Generar Horario', true, () {
          setState(() {
            generatedSchedules = generateAllCombinations(selectedCourses);
            currentScheduleIndex = 0;
          });
        }),
        _buildNavButton('Siguiente',
            currentScheduleIndex < generatedSchedules.length - 1, () {
          if (currentScheduleIndex < generatedSchedules.length - 1) {
            setState(() {
              currentScheduleIndex++;
            });
          }
        }),
      ],
    );
  }

  Widget _buildNavButton(String text, bool enabled, VoidCallback onPressed) {
    return ElevatedButton(
      style: ElevatedButton.styleFrom(
        backgroundColor: enabled ? Colors.blue : Colors.grey,
        foregroundColor: Colors.white,
        elevation: enabled ? 4 : 0,
        shadowColor: enabled ? Colors.black.withOpacity(0.3) : Colors.transparent,
      ),
      onPressed: enabled ? onPressed : null,
      child: Text(text),
    );
  }

  void addSelectedCourse() {
    if (selectedCourse != null &&
        !selectedCourses.any((c) => c.courseTitle == selectedCourse)) {
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
                    selectedCourses.add(faculties
                        .firstWhere((f) => f.name == selectedFaculty)
                        .courses
                        .firstWhere((c) => c.courseTitle == selectedCourse));
                    selectedCourse = null;
                  });
                  Navigator.of(context).pop();
                },
                child: const Text('Sí'),
              ),
              TextButton(
                onPressed: () {
                  Navigator.of(context).pop();
                },
                child: const Text('No'),
              ),
            ],
          );
        },
      );
    } else {
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
          color: courses[index].color));
      _combineSchedulesRecursive(
          index + 1, courses, currentCombination, validCombinations);
      currentCombination.removeLast();
    }
  }

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

  bool _schedulesOverlap(Schedule schedule1, Schedule schedule2) {
    if (schedule1.days.any((day) => schedule2.days.contains(day))) {
      DateTime startTime1 = _timeStringToDateTime(schedule1.startTime);
      DateTime endTime1 = _timeStringToDateTime(schedule1.endTime);
      DateTime startTime2 = _timeStringToDateTime(schedule2.startTime);
      DateTime endTime2 = _timeStringToDateTime(schedule2.endTime);

      if (startTime1.isBefore(endTime2) && startTime2.isBefore(endTime1)) {
        return true;
      }
    }
    return false;
  }

  DateTime _timeStringToDateTime(String timeString) {
    List<String> parts = timeString.split(':');
    int hour = int.parse(parts[0]);
    int minute = int.parse(parts[1]);
    return DateTime(DateTime.now().year, DateTime.now().month,
        DateTime.now().day, hour, minute);
  }
  Widget _buildMobileViewContent() {
    return Column(
      children: [
        Expanded(
          child: _buildGeneratedSchedulesPanel(),
        ),
        const Divider(),
        Expanded(
          child: _buildSelectionPanel(),
        ),
      ],
    );
  }
}
