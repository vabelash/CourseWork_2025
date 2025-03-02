import 'package:flutter/material.dart';

void main() {
  runApp(const MaterialApp(title: 'Navigation Basics', home: FirstRoute()));
}

class FirstRoute extends StatelessWidget {
  const FirstRoute({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('First Route')),
      body: Center(
        child: ElevatedButton(
          child: const Text('Open route'),
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => const SecondRoute()),
            );
          },
        ),
      ),
    );
  }
}

class SecondRoute extends StatefulWidget {
  const SecondRoute({super.key});

  @override
  State<SecondRoute> createState() => _SecondRouteState();
}

class _SecondRouteState extends State<SecondRoute> {
  final List<String> _exercises = ['Squats', 'Pushups', 'Legpress'];
  String _exercise = 'Pushups';
  bool _isWorkoutStarted = false;

  void _toggleWorkout() {
    setState(() {
      _isWorkoutStarted = !_isWorkoutStarted;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Stack(
        children: [
          Center(),
          Align(
            alignment: Alignment.topCenter,
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: DropdownButtonFormField( // Выпадающий список упражнений
                decoration: InputDecoration(
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                  contentPadding: const EdgeInsets.symmetric(vertical: 20, horizontal: 10),
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                    borderSide: const BorderSide(color: Colors.blueAccent, width: 1.5),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                    borderSide: const BorderSide(color: Colors.blueAccent, width: 2.5),
                  ),
                  labelText: 'Choose an exercise',
                  labelStyle: Theme.of(context).textTheme.titleMedium?.copyWith(fontSize: 18),
                ),
                items: _exercises
                    .map<DropdownMenuItem<String>>(
                      (String exercise) => DropdownMenuItem<String>(
                        value: exercise,
                        child: Text(exercise),
                      ),
                    )
                    .toList(),
                onChanged: (String? exercise) {
                  setState(() {
                    _exercise = exercise ?? _exercise;
                  });
                },
                value: _exercise,
              ),
            ),
          ),
          Align(
            alignment: Alignment.bottomCenter,
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: ElevatedButton(
                onPressed: _toggleWorkout,
                style: ElevatedButton.styleFrom( // Кнопка для начала/конца записи упражнения
                  backgroundColor: _isWorkoutStarted ? const Color.fromARGB(255, 78, 121, 143) : Colors.blueAccent,
                  padding: const EdgeInsets.symmetric(horizontal: 32, vertical: 16),
                ),
                child: Text(
                  _isWorkoutStarted ? 'Finish my workout' : 'Start my workout',
                  style: const TextStyle(fontSize: 18),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}