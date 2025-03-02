// import 'package:flutter/material.dart';

// void main() {
//   runApp(const MaterialApp(title: 'Navigation Basics', home: FirstRoute()));
// }

// class FirstRoute extends StatelessWidget {
//   const FirstRoute({super.key});

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(title: const Text('First Route')),
//       body: Center(
//         child: ElevatedButton(
//           child: const Text('Open route'),
//           onPressed: () {
//             Navigator.push(
//               context,
//               MaterialPageRoute(builder: (context) => const SecondRoute()),
//             );
//           },
//         ),
//       ),
//     );
//   }
// }

// class SecondRoute extends StatefulWidget {
//   const SecondRoute({super.key});

//   @override
//   State<SecondRoute> createState() => _SecondRouteState();
// }

// class _SecondRouteState extends State<SecondRoute> {
//   final List<String> _exercises = ['Squats', 'Pushups', 'Legpress'];
//   String _exercise = 'Pushups';
//   bool _isWorkoutStarted = false;

//   void _toggleWorkout() {
//     setState(() {
//       _isWorkoutStarted = !_isWorkoutStarted;
//     });
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(),
//       body: Stack(
//         children: [
//           Center(),
//           Align(
//             alignment: Alignment.topCenter,
//             child: Padding(
//               padding: const EdgeInsets.all(16.0),
//               child: DropdownButtonFormField( // Выпадающий список упражнений
//                 decoration: InputDecoration(
//                   border: OutlineInputBorder(
//                     borderRadius: BorderRadius.circular(10),
//                   ),
//                   contentPadding: const EdgeInsets.symmetric(vertical: 20, horizontal: 10),
//                   enabledBorder: OutlineInputBorder(
//                     borderRadius: BorderRadius.circular(10),
//                     borderSide: const BorderSide(color: Colors.blueAccent, width: 1.5),
//                   ),
//                   focusedBorder: OutlineInputBorder(
//                     borderRadius: BorderRadius.circular(10),
//                     borderSide: const BorderSide(color: Colors.blueAccent, width: 2.5),
//                   ),
//                   labelText: 'Choose an exercise',
//                   labelStyle: Theme.of(context).textTheme.titleMedium?.copyWith(fontSize: 18),
//                 ),
//                 items: _exercises
//                     .map<DropdownMenuItem<String>>(
//                       (String exercise) => DropdownMenuItem<String>(
//                         value: exercise,
//                         child: Text(exercise),
//                       ),
//                     )
//                     .toList(),
//                 onChanged: (String? exercise) {
//                   setState(() {
//                     _exercise = exercise ?? _exercise;
//                   });
//                 },
//                 value: _exercise,
//               ),
//             ),
//           ),
//           Align(
//             alignment: Alignment.bottomCenter,
//             child: Padding(
//               padding: const EdgeInsets.all(16.0),
//               child: ElevatedButton(
//                 onPressed: _toggleWorkout,
//                 style: ElevatedButton.styleFrom( // Кнопка для начала/конца записи упражнения
//                   backgroundColor: _isWorkoutStarted ? const Color.fromARGB(255, 78, 121, 143) : Colors.blueAccent,
//                   padding: const EdgeInsets.symmetric(horizontal: 32, vertical: 16),
//                 ),
//                 child: Text(
//                   _isWorkoutStarted ? 'Finish my workout' : 'Start my workout',
//                   style: const TextStyle(fontSize: 18),
//                 ),
//               ),
//             ),
//           ),
//         ],
//       ),
//     );
//   }
// }

import 'dart:math' as math;
import 'package:flutter/material.dart';

void main() {
  runApp(const MaterialApp(title: 'Navigation Basics', home: FirstRoute()));
}

class FirstRoute extends StatelessWidget {
  const FirstRoute({super.key});

  void _showAction(BuildContext context, int index) {
    final actionTitles = ['Help', 'Change the language', 'Get information'];
    showDialog<void>(
      context: context,
      builder: (context) {
        return AlertDialog(
          content: Text(actionTitles[index]),
          actions: [
            TextButton(
              onPressed: () => Navigator.of(context).pop(),
              child: const Text('CLOSE'),
            ),
          ],
        );
      },
    );
  }

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
      floatingActionButton: ExpandableFab(
        distance: 112,
        children: [
          ActionButton(
            onPressed: () => _showAction(context, 0),
            icon: const Icon(Icons.help_outline),
          ),
          ActionButton(
            onPressed: () => _showAction(context, 1),
            icon: const Icon(Icons.language),
          ),
          ActionButton(
            onPressed: () => _showAction(context, 2),
            icon: const Icon(Icons.mail_outline),
          ),
        ],
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
              child: DropdownButtonFormField(
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
                style: ElevatedButton.styleFrom(
                  backgroundColor: _isWorkoutStarted ? Colors.blueGrey : Colors.blueAccent,
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

@immutable
class ExpandableFab extends StatefulWidget {
  const ExpandableFab({
    super.key,
    this.initialOpen,
    required this.distance,
    required this.children,
  });

  final bool? initialOpen;
  final double distance;
  final List<Widget> children;

  @override
  State<ExpandableFab> createState() => _ExpandableFabState();
}

class _ExpandableFabState extends State<ExpandableFab>
    with SingleTickerProviderStateMixin {
  late final AnimationController _controller;
  late final Animation<double> _expandAnimation;
  bool _open = false;

  @override
  void initState() {
    super.initState();
    _open = widget.initialOpen ?? false;
    _controller = AnimationController(
      value: _open ? 1.0 : 0.0,
      duration: const Duration(milliseconds: 250),
      vsync: this,
    );
    _expandAnimation = CurvedAnimation(
      curve: Curves.fastOutSlowIn,
      reverseCurve: Curves.easeOutQuad,
      parent: _controller,
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  void _toggle() {
    setState(() {
      _open = !_open;
      if (_open) {
        _controller.forward();
      } else {
        _controller.reverse();
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox.expand(
      child: Stack(
        alignment: Alignment.bottomRight,
        clipBehavior: Clip.none,
        children: [
          _buildTapToCloseFab(),
          ..._buildExpandingActionButtons(),
          _buildTapToOpenFab(),
        ],
      ),
    );
  }

  Widget _buildTapToCloseFab() {
    return SizedBox(
      width: 56,
      height: 56,
      child: Center(
        child: Material(
          shape: const CircleBorder(),
          clipBehavior: Clip.antiAlias,
          elevation: 4,
          child: InkWell(
            onTap: _toggle,
            child: Padding(
              padding: const EdgeInsets.all(8),
              child: Icon(Icons.close, color: Theme.of(context).primaryColor),
            ),
          ),
        ),
      ),
    );
  }

  List<Widget> _buildExpandingActionButtons() {
    final children = <Widget>[];
    final count = widget.children.length;
    final step = 90.0 / (count - 1);
    for (
      var i = 0, angleInDegrees = 0.0;
      i < count;
      i++, angleInDegrees += step
    ) {
      children.add(
        _ExpandingActionButton(
          directionInDegrees: angleInDegrees,
          maxDistance: widget.distance,
          progress: _expandAnimation,
          child: widget.children[i],
        ),
      );
    }
    return children;
  }

  Widget _buildTapToOpenFab() {
    return IgnorePointer(
      ignoring: _open,
      child: AnimatedContainer(
        transformAlignment: Alignment.center,
        transform: Matrix4.diagonal3Values(
          _open ? 0.7 : 1.0,
          _open ? 0.7 : 1.0,
          1.0,
        ),
        duration: const Duration(milliseconds: 250),
        curve: const Interval(0.0, 0.5, curve: Curves.easeOut),
        child: AnimatedOpacity(
          opacity: _open ? 0.0 : 1.0,
          curve: const Interval(0.25, 1.0, curve: Curves.easeInOut),
          duration: const Duration(milliseconds: 250),
          child: FloatingActionButton(
            onPressed: _toggle,
            child: const Icon(Icons.create),
          ),
        ),
      ),
    );
  }
}

@immutable
class _ExpandingActionButton extends StatelessWidget {
  const _ExpandingActionButton({
    required this.directionInDegrees,
    required this.maxDistance,
    required this.progress,
    required this.child,
  });

  final double directionInDegrees;
  final double maxDistance;
  final Animation<double> progress;
  final Widget child;

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: progress,
      builder: (context, child) {
        final offset = Offset.fromDirection(
          directionInDegrees * (math.pi / 180.0),
          progress.value * maxDistance,
        );
        return Positioned(
          right: 4.0 + offset.dx,
          bottom: 4.0 + offset.dy,
          child: Transform.rotate(
            angle: (1.0 - progress.value) * math.pi / 2,
            child: child!,
          ),
        );
      },
      child: FadeTransition(opacity: progress, child: child),
    );
  }
}

@immutable
class ActionButton extends StatelessWidget {
  const ActionButton({super.key, this.onPressed, required this.icon});

  final VoidCallback? onPressed;
  final Widget icon;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Material(
      shape: const CircleBorder(),
      clipBehavior: Clip.antiAlias,
      color: theme.colorScheme.secondary,
      elevation: 4,
      child: IconButton(
        onPressed: onPressed,
        icon: icon,
        color: theme.colorScheme.onSecondary,
      ),
    );
  }
}