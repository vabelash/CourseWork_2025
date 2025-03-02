import 'dart:math' as math;
import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter/services.dart'; // Для Clipboard
import 'package:url_launcher/url_launcher.dart'; // Для launch

void main() {
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  static void setLocale(BuildContext context, Locale newLocale) {
    MyAppState? state = context.findAncestorStateOfType<MyAppState>();
    state?.setLocale(newLocale);
  }

  @override
  MyAppState createState() => MyAppState();
}

class MyAppState extends State<MyApp> {
  Locale? _locale;

  void setLocale(Locale locale) {
    setState(() {
      _locale = locale;
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Navigation Basics',
      locale: _locale,
      localizationsDelegates: [
        AppLocalizations.delegate,
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
      ],
      supportedLocales: [
        const Locale('en', ''),
        const Locale('ru', ''),
        const Locale('zh', ''),
      ],
      home: const FirstRoute(),
    );
  }
}

class AppLocalizations {
  final Locale locale;

  AppLocalizations(this.locale);

  static AppLocalizations? of(BuildContext context) {
    return Localizations.of<AppLocalizations>(context, AppLocalizations);
  }

  static const LocalizationsDelegate<AppLocalizations> delegate = AppLocalizationsDelegate();

  static final Map<String, Map<String, String>> _localizedValues = {
    'en': {
      'title': 'Smart Workout Tracking',
      'start': 'Start',
      'help': 'Help',
      'changeLanguage': 'Change the language',
      'getInformation': 'Get information',
      'close': 'CLOSE',
      'chooseExercise': 'Choose an exercise',
      'startWorkout': 'Start my workout',
      'finishWorkout': 'Finish my workout',
      'squats': 'Squats',
      'pushups': 'Pushups',
      'legpress': 'Legpress',
      'welcomeText': 'Welcome! This tool will help you track your performance in physical exercises such as push-ups, squats, and leg presses using the YOLO neural network. Ready to train? :)',
      'email': 'posehelapp@gmail.com',
    },
    'ru': {
      'title': 'Умный трекер тренировок',
      'start': 'Начать',
      'help': 'Помощь',
      'changeLanguage': 'Изменить язык',
      'getInformation': 'Получить информацию',
      'close': 'ЗАКРЫТЬ',
      'chooseExercise': 'Выберите упражнение',
      'startWorkout': 'Начать тренировку',
      'finishWorkout': 'Завершить тренировку',
      'squats': 'Приседания',
      'pushups': 'Отжимания',
      'legpress': 'Жим ногами',
      'welcomeText': 'Добро пожаловать! Этот инструмент поможет отслеживать ваше выполнение таких физических упражнений, как отжимания, приседания и жим ногами, с помощью нейросети YOLO. Готовы к тренировке?)',
      'email': 'posehelapp@gmail.com',
    },
    'zh': {
      'title': '智能锻炼跟踪',
      'start': '开始',
      'help': '帮助',
      'changeLanguage': '更改语言',
      'getInformation': '获取信息',
      'close': '关闭',
      'chooseExercise': '选择一个练习',
      'startWorkout': '开始我的锻炼',
      'finishWorkout': '完成我的锻炼',
      'squats': '深蹲',
      'pushups': '俯卧撑',
      'legpress': '腿举',
      'welcomeText': '欢迎！这个工具将帮助您使用YOLO神经网络跟踪俯卧撑、深蹲和腿举等体育锻炼的表现。准备好训练了吗？',
      'email': 'posehelapp@gmail.com',
    },
  };

  String? get title => _localizedValues[locale.languageCode]?['title'];
  String? get start => _localizedValues[locale.languageCode]?['start'];
  String? get help => _localizedValues[locale.languageCode]?['help'];
  String? get changeLanguage => _localizedValues[locale.languageCode]?['changeLanguage'];
  String? get getInformation => _localizedValues[locale.languageCode]?['getInformation'];
  String? get close => _localizedValues[locale.languageCode]?['close'];
  String? get chooseExercise => _localizedValues[locale.languageCode]?['chooseExercise'];
  String? get startWorkout => _localizedValues[locale.languageCode]?['startWorkout'];
  String? get finishWorkout => _localizedValues[locale.languageCode]?['finishWorkout'];
  String? get squats => _localizedValues[locale.languageCode]?['squats'];
  String? get pushups => _localizedValues[locale.languageCode]?['pushups'];
  String? get legpress => _localizedValues[locale.languageCode]?['legpress'];
  String? get welcomeText => _localizedValues[locale.languageCode]?['welcomeText'];
  String? get email => _localizedValues[locale.languageCode]?['email'];
}

class AppLocalizationsDelegate extends LocalizationsDelegate<AppLocalizations> {
  const AppLocalizationsDelegate();

  @override
  bool isSupported(Locale locale) {
    return ['en', 'ru', 'zh'].contains(locale.languageCode);
  }

  @override
  Future<AppLocalizations> load(Locale locale) async {
    return AppLocalizations(locale);
  }

  @override
  bool shouldReload(AppLocalizationsDelegate old) => false;
}

// class FirstRoute extends StatelessWidget {
//   const FirstRoute({super.key});

//   void _showAction(BuildContext context, int index) {
//     final actionTitles = [
//       AppLocalizations.of(context)!.help,
//       AppLocalizations.of(context)!.changeLanguage,
//       AppLocalizations.of(context)!.getInformation,
//     ];
//     showDialog<void>(
//       context: context,
//       builder: (context) {
//         return AlertDialog(
//           content: Text(actionTitles[index]!),
//           actions: [
//             TextButton(
//               onPressed: () => Navigator.of(context).pop(),
//               child: Text(AppLocalizations.of(context)!.close!),
//             ),
//           ],
//         );
//       },
//     );
//   }

//   void _changeLanguage(BuildContext context) {
//     showDialog<void>(
//       context: context,
//       builder: (context) {
//         return AlertDialog(
//           title: Text(AppLocalizations.of(context)!.changeLanguage!),
//           content: Column(
//             mainAxisSize: MainAxisSize.min,
//             children: [
//               ListTile(
//                 title: const Text('English'),
//                 onTap: () {
//                   MyApp.setLocale(context, const Locale('en'));
//                   Navigator.of(context).pop();
//                 },
//               ),
//               ListTile(
//                 title: const Text('Русский'),
//                 onTap: () {
//                   MyApp.setLocale(context, const Locale('ru'));
//                   Navigator.of(context).pop();
//                 },
//               ),
//               ListTile(
//                 title: const Text('中文'),
//                 onTap: () {
//                   MyApp.setLocale(context, const Locale('zh'));
//                   Navigator.of(context).pop();
//                 },
//               ),
//             ],
//           ),
//         );
//       },
//     );
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(title: Text(AppLocalizations.of(context)!.title!)),
//       body: Padding(
//         padding: const EdgeInsets.all(16.0),
//         child: Column(
//           crossAxisAlignment: CrossAxisAlignment.start, // Выравнивание по левому краю
//           children: [
//             Text(
//               AppLocalizations.of(context)!.welcomeText!,
//               style: const TextStyle(fontSize: 20),
//             ),
//             const SizedBox(height: 120), // Отступ между текстом и кнопкой
//             Center(
//               child: ElevatedButton(
//                 child: Text(AppLocalizations.of(context)!.start!, style: const TextStyle(fontSize: 24)),
//                 onPressed: () {
//                   Navigator.push(
//                     context,
//                     MaterialPageRoute(builder: (context) => const SecondRoute()),
//                   );
//                 },
//               ),
//             ),
//           ],
//         ),
//       ),
//       floatingActionButton: ExpandableFab(
//         distance: 112,
//         children: [
//           ActionButton(
//             onPressed: () => _showAction(context, 0),
//             icon: const Icon(Icons.help_outline),
//           ),
//           ActionButton(
//             onPressed: () => _changeLanguage(context),
//             icon: const Icon(Icons.language),
//           ),
//           ActionButton(
//             onPressed: () => _showAction(context, 2),
//             icon: const Icon(Icons.mail_outline),
//           ),
//         ],
//       ),
//     );
//   }
// }

class FirstRoute extends StatelessWidget {
  const FirstRoute({super.key});

  void _showAction(BuildContext context, int index) {
    final actionTitles = [
      AppLocalizations.of(context)!.help,
      AppLocalizations.of(context)!.changeLanguage,
      AppLocalizations.of(context)!.getInformation,
    ];
    showDialog<void>(
      context: context,
      builder: (context) {
        return AlertDialog(
          content: Text(actionTitles[index]!),
          actions: [
            TextButton(
              onPressed: () => Navigator.of(context).pop(),
              child: Text(AppLocalizations.of(context)!.close!),
            ),
          ],
        );
      },
    );
  }

  void _changeLanguage(BuildContext context) {
    showDialog<void>(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text(AppLocalizations.of(context)!.changeLanguage!),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              ListTile(
                title: const Text('English'),
                onTap: () {
                  MyApp.setLocale(context, const Locale('en'));
                  Navigator.of(context).pop();
                },
              ),
              ListTile(
                title: const Text('Русский'),
                onTap: () {
                  MyApp.setLocale(context, const Locale('ru'));
                  Navigator.of(context).pop();
                },
              ),
              ListTile(
                title: const Text('中文'),
                onTap: () {
                  MyApp.setLocale(context, const Locale('zh'));
                  Navigator.of(context).pop();
                },
              ),
            ],
          ),
        );
      },
    );
  }

  void _showEmailDialog(BuildContext context) {
  final email = AppLocalizations.of(context)!.email!;
  showDialog<void>(
    context: context,
    builder: (context) {
      return AlertDialog(
        title: Text(AppLocalizations.of(context)!.getInformation!),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text('Email: $email'),
            const SizedBox(height: 10),
            GestureDetector(
              onTap: () async {
                // Копируем email в буфер обмена
                await Clipboard.setData(ClipboardData(text: email));

                // Проверяем, что виджет все еще "смонтирован"
                if (context.mounted) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(content: Text('Email copied: $email')),
                  );
                }

                // Открываем почтовый клиент
                final Uri emailUri = Uri(
                  scheme: 'mailto',
                  path: email,
                );
                // Используем canLaunchUrl вместо canLaunch
                if (await canLaunchUrl(emailUri)) {
                  // Используем launchUrl вместо launch
                  await launchUrl(emailUri);
                } else {
                  // Проверяем, что виджет все еще "смонтирован"
                  if (context.mounted) {
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(content: Text('Could not launch email client')),
                    );
                  }
                }
              },
              child: Text(
                email,
                style: const TextStyle(
                  color: Colors.blue,
                  decoration: TextDecoration.underline,
                ),
              ),
            ),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(context).pop(),
            child: Text(AppLocalizations.of(context)!.close!),
          ),
        ],
      );
    },
  );
}

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(AppLocalizations.of(context)!.title!)),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              AppLocalizations.of(context)!.welcomeText!,
              style: const TextStyle(fontSize: 16),
            ),
            const SizedBox(height: 20),
            Center(
              child: ElevatedButton(
                child: Text(AppLocalizations.of(context)!.start!, style: const TextStyle(fontSize: 24)),
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => const SecondRoute()),
                  );
                },
              ),
            ),
          ],
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
            onPressed: () => _changeLanguage(context),
            icon: const Icon(Icons.language),
          ),
          ActionButton(
            onPressed: () => _showEmailDialog(context),
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
  late List<String> _exercises;
  String _exercise = 'Pushups';
  bool _isWorkoutStarted = false;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    _updateExercises();
  }

  void _updateExercises() {
    final appLocalizations = AppLocalizations.of(context)!;
    setState(() {
      _exercises = [
        appLocalizations.squats!,
        appLocalizations.pushups!,
        appLocalizations.legpress!,
      ];
      // Обновляем выбранное упражнение, если оно есть в новом списке
      if (_exercises.contains(_exercise)) {
        _exercise = _exercise;
      } else {
        _exercise = _exercises.first;
      }
    });
  }

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
                    borderSide: const BorderSide(color: Color.fromARGB(255, 198, 157, 252), width: 1.5),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                    borderSide: const BorderSide(color: Color.fromARGB(255, 198, 157, 252), width: 2.5),
                  ),
                  labelText: AppLocalizations.of(context)!.chooseExercise,
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
                  backgroundColor: _isWorkoutStarted ? const Color.fromARGB(255, 108, 91, 131) : const Color.fromARGB(255, 161, 90, 254),
                  foregroundColor: Colors.white,
                  padding: const EdgeInsets.symmetric(horizontal: 32, vertical: 16),
                ),
                child: Text(
                  _isWorkoutStarted ? AppLocalizations.of(context)!.finishWorkout! : AppLocalizations.of(context)!.startWorkout!,
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

class _ExpandableFabState extends State<ExpandableFab> with SingleTickerProviderStateMixin {
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
            backgroundColor: const Color.fromARGB(255, 198, 157, 252),
            child: const Icon(Icons.more_horiz),
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