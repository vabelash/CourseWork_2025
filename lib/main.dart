import 'dart:math' as math;
import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter/services.dart'; // Для Clipboard
import 'package:url_launcher/url_launcher.dart'; // Для launch
import 'package:camera/camera.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'dart:async';
import 'package:image/image.dart' as img;
import 'package:uuid/uuid.dart';
import 'dart:developer';
import 'dart:typed_data';

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
      'emailMessage': 'If you have any questions, you can contact us by the official e-mail:',
      'emailCopy': 'E-mail copied',
      'helpOpen': 'Open the "User Guide"',
      'startVideo': 'Click on ‘Start my workout’ to start the video stream',
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
      'emailMessage': 'Если у вас возникли какие-либо вопросы, можете обратиться по официальному e-mail:',
      'emailCopy': 'E-mail скопирован',
      'helpOpen': 'Открыть "Руководство пользователя"',
      'startVideo': 'Нажмите "Начать тренировку" для запуска видеопотока',
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
      'emailMessage': '如果您有任何问题，您可以通过官方电子邮件与我们联系:',
      'emailCopy': 'E-mail 复制的',
      'helpOpen': '打开"用户指南"',
      'startVideo': '点击 “开始我的锻炼” 启动视频流',
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
  String? get emailMessage => _localizedValues[locale.languageCode]?['emailMessage'];
  String? get emailCopy => _localizedValues[locale.languageCode]?['emailCopy'];
  String? get helpOpen => _localizedValues[locale.languageCode]?['helpOpen'];
  String? get startVideo => _localizedValues[locale.languageCode]?['startVideo'];
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

class FirstRoute extends StatelessWidget {
  const FirstRoute({super.key});

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
    final emailMessage = AppLocalizations.of(context)!.emailMessage!;
    final emailCopy = AppLocalizations.of(context)!.emailCopy!;
    showDialog<void>(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text(AppLocalizations.of(context)!.getInformation!),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(emailMessage),
              const SizedBox(height: 10),
              GestureDetector(
                onTap: () async {
                  await Clipboard.setData(ClipboardData(text: "vabelash@edu.hse.ru"));
                  if (context.mounted) {
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(content: Text('$emailCopy: vabelash@edu.hse.ru')),
                    );
                  }
                  final Uri emailUri = Uri(
                    scheme: 'mailto',
                    path: "vabelash@edu.hse.ru",
                  );
                  if (await canLaunchUrl(emailUri)) {
                    await launchUrl(emailUri);
                  } else {
                    if (context.mounted) {
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(content: Text('Could not launch email client')),
                      );
                    }
                  }
                },
                child: Text(
                  "vabelash@edu.hse.ru",
                  style: const TextStyle(
                    color: Colors.blue,
                    decoration: TextDecoration.underline,
                    fontSize: 18,
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

  void _showHelpDialog(BuildContext context) {
    final help = AppLocalizations.of(context)!.help!;
    final helpOpen = AppLocalizations.of(context)!.helpOpen!;
    showDialog<void>(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text(help),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              SizedBox(
                width: 300,
                height: 200,
                child: Image.asset(
                  'assets/trainGif.gif',
                  fit: BoxFit.cover,
                ),
              ),
              const SizedBox(height: 20),
              GestureDetector(
                onTap: () async {
                  final Uri pdfUri = Uri.parse(
                      'https://drive.google.com/file/d/1Z7gJbI0JlDELvG0xJvQ22kFfuFK9eb2g/view?usp=sharing');
                  if (await canLaunchUrl(pdfUri)) {
                    await launchUrl(pdfUri);
                  } else {
                    if (context.mounted) {
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(content: Text('Не удалось открыть PDF')),
                      );
                    }
                  }
                },
                child: Text(
                  helpOpen,
                  style: TextStyle(
                    color: Colors.blue,
                    decoration: TextDecoration.underline,
                    fontSize: 18,
                  ),
                  textAlign: TextAlign.left,
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
      appBar: AppBar(
        title: Text(
          AppLocalizations.of(context)!.title!,
          style: TextStyle(
            fontSize: 24,
            color: const Color.fromARGB(255, 0, 0, 0),
            fontWeight: FontWeight.bold,
            shadows: [
              Shadow(
                blurRadius: 5.0,
                color: const Color.fromARGB(255, 197, 179, 220).withValues(),
                offset: Offset(2.0, 2.0),
              ),
            ],
          ),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(24),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              AppLocalizations.of(context)!.welcomeText!,
              style: const TextStyle(fontSize: 20),
            ),
            const SizedBox(height: 40),
            Center(
              child: ElevatedButton(
                child: Text(AppLocalizations.of(context)!.start!, style: const TextStyle(fontSize: 26)),
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
            onPressed: () => _showHelpDialog(context),
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

  int _repsCount = 0;
  var uuid = Uuid();
  late String uniqueId;

  late CameraController _cameraController;
  late Future<void> _initializeCameraFuture;
  late Future<void> _imageOutputFuture;

  @override
  void initState() {
    super.initState();
    _initializeCameraFuture = _initializeCamera(); // Инициализация Future
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    _updateExercises();
  }

  Future<void> _initializeCamera() async {
    try {
      final cameras = await availableCameras();
      final frontCamera = cameras.firstWhere(
        (camera) => camera.lensDirection == CameraLensDirection.front,
      );

      _cameraController = CameraController(
        frontCamera,
        fps: 30,
        ResolutionPreset.medium,
        enableAudio: false,
      );

      await _cameraController.initialize(); // Инициализация камеры
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text("Camera error: $e")),
        );
      }
    }
  }

  void _updateExercises() {
    final appLocalizations = AppLocalizations.of(context)!;
    setState(() {
      _exercises = [
        appLocalizations.squats!,
        appLocalizations.pushups!,
        appLocalizations.legpress!,
      ];
      if (_exercises.contains(_exercise)) {
        _exercise = _exercise;
      } else {
        _exercise = _exercises.first;
      }
    });
  }

  void _toggleWorkout() {
      if (!_cameraController.value.isInitialized) {
      print("Камера не инициализирована.");
        return;
      }
      setState(() {
        _isWorkoutStarted = !_isWorkoutStarted;
      });
      if (_isWorkoutStarted) {
        uniqueId = uuid.v4();
        _startVideoStream();
      } else {
        _stopVideoStream();
        _repsCount = 0;
      }
}

bool _isProcessing = false; // Флаг для отслеживания обработки кадра


void _startVideoStream() async {
  int countFrames = 0;
  if (!_cameraController.value.isStreamingImages) {
    await _cameraController.startImageStream((CameraImage img) async {
      countFrames++;
      if (!_isProcessing && countFrames % 5 == 0) {
        _isProcessing = true;

        try {
          // Преобразуем кадр и отправляем на сервер
          // final resizedImage = await _resizeImage(img, 720, 480);
          await _sendFrame(img);
        } catch (e) {
          print("Ошибка обработки кадра: $e");
        } finally {
          _isProcessing = false;
        }
      }
    });
  }
}



void _stopVideoStream() async {
  if (_cameraController.value.isStreamingImages) {
    await _cameraController.stopImageStream();
  }
}

List<Uint8List> _receivedFrames = [];
// Future<void> _sendFrame(CameraImage img) async {
//   try {
//     // Конвертируем CameraImage в байты
//     Uint8List imageBytes = await _convertYUV420ToJPEG(img);

//     var request = http.MultipartRequest('POST', Uri.parse("http://172.27.27.254:8000/process_frame/"))
//       ..files.add(http.MultipartFile.fromBytes('file', imageBytes, filename: "file.jpg"))
//       ..fields['session_id'] = uniqueId; // Можно сгенерировать ID

//     var response = await request.send();
//     if (response.statusCode == 200) {
//       var responseData = await response.stream.bytesToString();
//       var jsonResponse = jsonDecode(responseData);

//       // Обновляем изображение в UI
//       if (mounted)
//       {
//         setState(() {
//         if (jsonResponse.containsKey('image') && jsonResponse['image'].isNotEmpty){
//           _receivedFrames.add(base64Decode(jsonResponse['image']));
//         }
        
//         if (_receivedFrames.length > 10) {
//           _receivedFrames.removeAt(0); // Ограничение на 10 кадров
//         }
//         _repsCount = jsonResponse['reps'];
//         });
//       }
//       int receivedFramesLen = _receivedFrames.length;
//       log("$receivedFramesLen");
//     } else {
//       print("Ошибка сервера: ${response.statusCode}");
//     }
//   } catch (e) {
//     print("Ошибка отправки кадра: $e");
//   }
// }

// Future<void> _sendFrame(CameraImage img) async {
//   try {
//     Uint8List imageBytes = await _convertYUV420ToJPEG(img);

//     var request = http.MultipartRequest('POST', Uri.parse("http://172.27.27.254:8000/process_frame/"))
//       ..files.add(http.MultipartFile.fromBytes('file', imageBytes, filename: "frame.jpg"))
//       ..fields['session_id'] = uniqueId;

//     var response = await request.send();

//     if (response.statusCode == 200) {
//       Uint8List responseBytes = await response.stream.toBytes();
//       String responseString = utf8.decode(responseBytes);
//       Map<String, dynamic> jsonResponse = jsonDecode(responseString);

//       //String? repsCount = response.headers['reps-count']; // Получаем число повторений из заголовка

//       setState(() {
//         _receivedFrames.add(responseBytes);
//         if (_receivedFrames.length > 10) {
//           _receivedFrames.removeAt(0);
//         }
//         _repsCount = jsonResponse['reps-count'];
//       });
//       log("Кадров в списке: ${_receivedFrames.length}");
//     } else {
//       print("Ошибка сервера: ${response.statusCode}");
//     }
//   } catch (e) {
//     print("Ошибка отправки кадра: $e");
//   }
// }

Future<void> _sendFrame(CameraImage img) async {
  try {
    // Преобразуем изображение из CameraImage в байты JPEG
    Uint8List imageBytes = await _convertYUV420ToJPEG(img); //_convertYUV420ToJPEG

    var request = http.MultipartRequest(
      'POST', 
      Uri.parse("http://172.27.27.254:8001/process_frame/")
    )
      ..files.add(http.MultipartFile.fromBytes('file', imageBytes, filename: "frame.jpg"))
      ..fields['session_id'] = uniqueId;

    var response = await request.send();

    if (response.statusCode == 200) {
      // Получаем байты изображения из ответа
      Uint8List responseBytes = await response.stream.toBytes();

      // Получаем количество повторений из заголовка
      String repsCountHeader = response.headers['reps-count'] ?? '0';
      log("Проверка парсинга: $repsCountHeader");
      int repsCount = int.parse(repsCountHeader[1]);

      setState(() {
        _receivedFrames.add(responseBytes); // Добавляем изображение в список
        if (_receivedFrames.length > 10) {
          _receivedFrames.removeAt(0); // Ограничиваем список до 10 кадров
        }
        _repsCount = repsCount; // Обновляем число повторений
      });

      log("Кадров в списке: ${_receivedFrames.length}, Повторений: $_repsCount");
    } else {
      print("Ошибка сервера: ${response.statusCode}");
    }
  } catch (e) {
    print("Ошибка отправки кадра: $e");
  }
}

// Future<Uint8List> _convertYUV420ToJPEG(CameraImage cameraImage) async {
//   try {
//     int width = cameraImage.width;
//     int height = cameraImage.height;

//     // Получаем компоненты Y, U, V
//     Plane yPlane = cameraImage.planes[0];
//     Plane uPlane = cameraImage.planes[1];
//     Plane vPlane = cameraImage.planes[2];

//     // Вычисляем размер для U и V, так как они в два раза меньше по ширине и высоте
//     int uvWidth = (width / 2).toInt();
//     int uvHeight = (height / 2).toInt();

//     // Создаём картину в формате Image с использованием данных YUV
//     img.Image image = img.Image(width, height);

//     // Конвертируем вручную YUV в RGB
//     int yIndex = 0;
//     int uvIndex = 0;
//     for (int i = 0; i < height; i++) {
//       for (int j = 0; j < width; j++) {
//         int y = yPlane.bytes[yIndex++];
//         int u = uPlane.bytes[uvIndex];
//         int v = vPlane.bytes[uvIndex++];

//         // YUV to RGB conversion (ITU-R BT.601)
//         int r = (y + 1.402 * (v - 128)).toInt();
//         int g = (y - 0.344136 * (u - 128) - 0.714136 * (v - 128)).toInt();
//         int b = (y + 1.772 * (u - 128)).toInt();

//         // Ограничиваем значения R, G, B в допустимом диапазоне
//         r = r.clamp(0, 255);
//         g = g.clamp(0, 255);
//         b = b.clamp(0, 255);

//         // Устанавливаем пиксель в изображении
//         image.setPixel(j, i, img.getColor(r, g, b));
//       }
//     }

//     // Преобразуем изображение в JPEG
//     List<int> jpegBytes = img.encodeJpg(image);
//     return Uint8List.fromList(jpegBytes);
//   } catch (e) {
//     print("Ошибка конвертации YUV в JPEG: $e");
//     rethrow;
//   }
// }


Future<Uint8List> _convertYUV420ToJPEG(CameraImage image, {int targetWidth = 720, int targetHeight = 480}) async {
  final int width = image.width;
  final int height = image.height;

  // Создаем изображение из YUV420
  final img.Image convertedImage = img.Image(width, height);

  final Uint8List yPlane = image.planes[0].bytes;
  final Uint8List uPlane = image.planes[1].bytes;
  final Uint8List vPlane = image.planes[2].bytes;

  final int uvPixelStride = image.planes[1].bytesPerPixel!;
  final int uvRowStride = image.planes[1].bytesPerRow;

  for (int y = 0; y < height; y++) {
    for (int x = 0; x < width; x++) {
      final int yValue = yPlane[y * width + x] & 0xFF;

      final int uvX = x ~/ 2;
      final int uvY = y ~/ 2;
      final int uvIndex = uvY * uvRowStride + uvX * uvPixelStride;

      final int uValue = uPlane[uvIndex] & 0xFF;
      final int vValue = vPlane[uvIndex] & 0xFF;

      // Преобразование YUV в RGB
      final int r = (yValue + 1.402 * (vValue - 128)).clamp(0, 255).toInt();
      final int g = (yValue - 0.344136 * (uValue - 128) - 0.714136 * (vValue - 128)).clamp(0, 255).toInt();
      final int b = (yValue + 1.772 * (uValue - 128)).clamp(0, 255).toInt();

      convertedImage.setPixelRgba(x, y, r, g, b);
    }
  }

  // Изменяем размер изображения до targetWidth x targetHeight
  final img.Image resizedImage = img.copyResize(convertedImage, width: targetWidth, height: targetHeight);

  // Конвертируем изображение в JPEG
  return Uint8List.fromList(img.encodeJpg(resizedImage));
}


// Future<Uint8List> _convertYUV420ToJPEG(CameraImage image, {int targetWidth = 480, int targetHeight = 720}) async {
//   final int width = image.width;
//   final int height = image.height;

//   // Создаем изображение из YUV420
//   final img.Image convertedImage = img.Image(width, height);

//   final int uvPixelStride = image.planes[1].bytesPerPixel!;

//   final Uint8List yPlane = image.planes[0].bytes;
//   final Uint8List uPlane = image.planes[1].bytes;
//   final Uint8List vPlane = image.planes[2].bytes;

//   int yIndex = 0;
//   int uvIndex = 0;
//   for (int y = 0; y < height; y++) {
//     for (int x = 0; x < width; x++) {
//       final int yValue = yPlane[yIndex++] & 0xFF;
//       final int uvOffset = uvIndex ~/ uvPixelStride;
//       final int uValue = uPlane[uvOffset] & 0xFF;
//       final int vValue = vPlane[uvOffset] & 0xFF;

//       convertedImage.setPixelRgba(x, y, yValue, uValue, vValue);
//       if (x % 2 == 1) uvIndex++;
//     }
//   }

//   // Изменяем размер изображения до targetWidth x targetHeight
//   final img.Image resizedImage = img.copyResize(convertedImage, width: targetWidth, height: targetHeight);

//   // Конвертируем изображение в JPEG
//   return Uint8List.fromList(img.encodeJpg(resizedImage));
// }



// ниже вряд ли ошибка
//   void _stopVideoStream() async {
//     if (_cameraController.value.isStreamingImages) {
//       await _cameraController.stopImageStream();
//     }
//   }

  @override
  void dispose() {
  if (_cameraController.value.isInitialized) {
    _cameraController.dispose();
  }
  super.dispose();
}

//   @override
//   Widget build(BuildContext context) {
//     final startVideo =  AppLocalizations.of(context)!.startVideo!;
//     return Scaffold(
//       appBar: AppBar(),
//       body: Stack(
//         children: [
//           Column(
//             children: [
//               Padding(
//                 padding: const EdgeInsets.all(16.0),
//                 child: DropdownButtonFormField(
//                   decoration: InputDecoration(
//                     border: OutlineInputBorder(
//                       borderRadius: BorderRadius.circular(10),
//                     ),
//                     contentPadding:
//                         const EdgeInsets.symmetric(vertical: 20, horizontal: 10),
//                     enabledBorder: OutlineInputBorder(
//                       borderRadius: BorderRadius.circular(10),
//                       borderSide: const BorderSide(
//                           color: Color.fromARGB(255, 198, 157, 252), width: 1.5),
//                     ),
//                     focusedBorder: OutlineInputBorder(
//                       borderRadius: BorderRadius.circular(10),
//                       borderSide: const BorderSide(
//                           color: Color.fromARGB(255, 198, 157, 252), width: 2.5),
//                     ),
//                     labelText: AppLocalizations.of(context)!.chooseExercise,
//                     labelStyle:
//                         Theme.of(context).textTheme.titleMedium?.copyWith(fontSize: 18),
//                   ),
//                   items: _exercises
//                       .map<DropdownMenuItem<String>>(
//                         (String exercise) => DropdownMenuItem<String>(
//                           value: exercise,
//                           child: Text(exercise),
//                         ),
//                       )
//                       .toList(),
//                   onChanged: (String? exercise) {
//                     setState(() {
//                       _exercise = exercise ?? _exercise;
//                       _updateExercises();

//                       if (_isWorkoutStarted) {
//                         _stopVideoStream();
//                         _isWorkoutStarted = false;
//                       }
//                     });
//                   },
//                   value: _exercise,
//                 ),
//               ),

//               Expanded(
//                 child: FutureBuilder<void>(
//                   future: _initializeCameraFuture,
//                   builder: (context, snapshot) {
//                     if (snapshot.connectionState == ConnectionState.done) {
//                       if (snapshot.hasError) {
//                         return Center(
//                           child: Text("Camera error: ${snapshot.error}"),
//                         );
//                       }
//                       return _isWorkoutStarted
//                           ? CameraPreview(_cameraController)
//                           : Container(
//                               color: Colors.grey[300],
//                               child: Center(
//                                 child: Text(
//                                   startVideo,
//                                   style: TextStyle(
//                                     color: Colors.grey[700],
//                                     fontSize: 16,
//                                   ),
//                                 ),
//                               ),
//                             );
//                     } else {
//                       return const Center(child: CircularProgressIndicator());
//                     }
//                   },
//                 ),
//               ),

//               Padding(
//                 padding: const EdgeInsets.all(16.0),
//                 child: ElevatedButton(
//                   onPressed: _toggleWorkout,
//                   style: ElevatedButton.styleFrom(
//                     backgroundColor: _isWorkoutStarted
//                         ? const Color.fromARGB(255, 108, 91, 131)
//                         : const Color.fromARGB(255, 161, 90, 254),
//                     foregroundColor: Colors.white,
//                     padding:
//                         const EdgeInsets.symmetric(horizontal: 32, vertical: 16),
//                   ),
//                   child: Text(
//                     _isWorkoutStarted
//                         ? AppLocalizations.of(context)!.finishWorkout!
//                         : AppLocalizations.of(context)!.startWorkout!,
//                     style: const TextStyle(fontSize: 18),
//                   ),
//                 ),
//               ),
//             ],
//           ),
//         ],
//       ),
//     );
//   }
// }


// версия на 11.49
@override
Widget build(BuildContext context) {
  final startVideo = AppLocalizations.of(context)!.startVideo!;
  return Scaffold(
    appBar: AppBar(),
    body: Stack(
      children: [
        Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: DropdownButtonFormField(
                decoration: InputDecoration(
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                  contentPadding:
                      const EdgeInsets.symmetric(vertical: 20, horizontal: 10),
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                    borderSide: const BorderSide(
                        color: Color.fromARGB(255, 198, 157, 252), width: 1.5),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                    borderSide: const BorderSide(
                        color: Color.fromARGB(255, 198, 157, 252), width: 2.5),
                  ),
                  labelText: AppLocalizations.of(context)!.chooseExercise,
                  labelStyle:
                      Theme.of(context).textTheme.titleMedium?.copyWith(fontSize: 18),
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
                    _updateExercises();

                    if (_isWorkoutStarted) {
                      _stopVideoStream();
                      _isWorkoutStarted = false;
                    }
                  });
                },
                value: _exercise,
              ),
            ),

            Expanded(
              // child: FutureBuilder<void>(
              //   future: _imageOutputFuture,
              //   builder: (context, snapshot) {
              //     if (snapshot.connectionState == ConnectionState.done) {
              //       if (snapshot.hasError) {
              //         return Center(
              //           child: Text("Camera error: ${snapshot.error}"),
              //         );
              //       }
              //       return _isWorkoutStarted
              //           ? (Image.memory(_processedImage!))
              //           : Container(
              //               color: Colors.grey[300],
              //               child: Center(
              //                 child: Text(
              //                   startVideo,
              //                   style: TextStyle(
              //                     color: Colors.grey[700],
              //                     fontSize: 16,
              //                   ),
              //                 ),
              //               ),
              //             );
              //     } else {
              //       return const Center(child: CircularProgressIndicator());
              //     }
              //   },
              // ),
              child: _isWorkoutStarted
                  ? (_receivedFrames.isNotEmpty
                      ? Image.memory(_receivedFrames.last, fit: BoxFit.cover)
                      : Center(child: Text("Ожидание видео...")))
                  : Container(
                      color: Colors.grey[300],
                      child: Center(
                        child: Text(
                          startVideo,
                          style: TextStyle(
                            color: Colors.grey[700],
                            fontSize: 16,
                          ),
                        ),
                      ),
                    ),
            ),

            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                children: [
                  Text(
                    "Повторений: $_repsCount",
                    style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                  ),
                  SizedBox(height: 10),
                  ElevatedButton(
                    onPressed: _toggleWorkout,
                    style: ElevatedButton.styleFrom(
                      backgroundColor: _isWorkoutStarted
                          ? const Color.fromARGB(255, 108, 91, 131)
                          : const Color.fromARGB(255, 161, 90, 254),
                      foregroundColor: Colors.white,
                      padding:
                          const EdgeInsets.symmetric(horizontal: 32, vertical: 16),
                    ),
                    child: Text(
                      _isWorkoutStarted
                          ? AppLocalizations.of(context)!.finishWorkout!
                          : AppLocalizations.of(context)!.startWorkout!,
                      style: const TextStyle(fontSize: 18),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}


// class _SecondRouteState extends State<SecondRoute> {
//   late List<String> _exercises;
//   String _exercise = 'Pushups';
//   bool _isWorkoutStarted = false;

//   // Камера
//   late CameraController _cameraController;
//   late Future<void> _initializeCameraFuture;

//   // Для отображения обработанного видеопотока
//   late StreamController<Uint8List> _imageStreamController;
//   late Stream<Uint8List> _imageStream;
//   late Timer _timer;

//   @override
//   void initState() {
//     super.initState();
//     _initializeCameraFuture = _initializeCamera(); // Инициализация Future
//     _imageStreamController = StreamController<Uint8List>();
//     _imageStream = _imageStreamController.stream;
//   }

//   @override
//   void didChangeDependencies() {
//     super.didChangeDependencies();
//     _updateExercises();
//   }

//   Future<void> _initializeCamera() async {
//     try {
//       final cameras = await availableCameras();
//       final frontCamera = cameras.firstWhere(
//         (camera) => camera.lensDirection == CameraLensDirection.front,
//       );

//       _cameraController = CameraController(
//         frontCamera,
//         ResolutionPreset.medium,
//       );

//       await _cameraController.initialize(); // Инициализация камеры
//     } catch (e) {
//       if (mounted) {
//         ScaffoldMessenger.of(context).showSnackBar(
//           SnackBar(content: Text("Camera error: $e")),
//         );
//       }
//     }
//   }

//   void _updateExercises() {
//     final appLocalizations = AppLocalizations.of(context)!;
//     setState(() {
//       _exercises = [
//         appLocalizations.squats!,
//         appLocalizations.pushups!,
//         appLocalizations.legpress!,
//       ];
//       if (_exercises.contains(_exercise)) {
//         _exercise = _exercise;
//       } else {
//         _exercise = _exercises.first;
//       }
//     });
//   }

//   void _toggleWorkout() {
//     setState(() {
//       _isWorkoutStarted = !_isWorkoutStarted;
//     });

//     if (_isWorkoutStarted) {
//       _startVideoStream();
//     } else {
//       _stopVideoStream();
//     }
//   }

//   void _startVideoStream() async {
//     if (!_cameraController.value.isStreamingImages) {
//       await _cameraController.startImageStream((CameraImage img) async {
//         // Отправка кадра на сервер для обработки
//         final processedFrame = await _sendFrameToServer(img);
//         if (processedFrame != null) {
//           _imageStreamController.add(processedFrame);
//         }
//       });
//     }
//   }

//   void _stopVideoStream() async {
//     if (_cameraController.value.isStreamingImages) {
//       await _cameraController.stopImageStream();
//     }
//     _timer.cancel(); // Остановка таймера
//   }

//   Future<Uint8List?> _sendFrameToServer(CameraImage img) async {
//     try {
//       // Преобразование CameraImage в JPEG
//       final jpegBytes = await _convertCameraImageToJpeg(img);

//       // Отправка на сервер
//       final url = Uri.parse('http://<your-server-ip>:5000/process_frame');
//       final request = http.MultipartRequest('POST', url);
//       request.files.add(http.MultipartFile.fromBytes('frame', jpegBytes));

//       final response = await request.send();

//       if (response.statusCode == 200) {
//         final responseData = await response.stream.toBytes();
//         return responseData;
//       } else {
//         throw Exception('Failed to process frame');
//       }
//     } catch (e) {
//       if (mounted) {
//         ScaffoldMessenger.of(context).showSnackBar(
//           SnackBar(content: Text("Error processing frame: $e")),
//         );
//       }
//       return null;
//     }
//   }

//   Future<Uint8List> _convertCameraImageToJpeg(CameraImage img) async {
//     // Преобразование CameraImage в JPEG (примерная реализация)
//     // В реальном проекте используйте библиотеку для обработки изображений, например `image` или `flutter_image`
//     // Здесь приведен упрощенный пример
//     final plane = img.planes[0];
//     final bytes = plane.bytes;
//     return Uint8List.fromList(bytes);
//   }

//   @override
//   void dispose() {
//     _cameraController.dispose();
//     _imageStreamController.close();
//     super.dispose();
//   }

//   @override
//   Widget build(BuildContext context) {
//     final startVideo = AppLocalizations.of(context)!.startVideo!;
//     return Scaffold(
//       appBar: AppBar(),
//       body: Stack(
//         children: [
//           Column(
//             children: [
//               Padding(
//                 padding: const EdgeInsets.all(16.0),
//                 child: DropdownButtonFormField(
//                   decoration: InputDecoration(
//                     border: OutlineInputBorder(
//                       borderRadius: BorderRadius.circular(10),
//                     ),
//                     contentPadding:
//                         const EdgeInsets.symmetric(vertical: 20, horizontal: 10),
//                     enabledBorder: OutlineInputBorder(
//                       borderRadius: BorderRadius.circular(10),
//                       borderSide: const BorderSide(
//                           color: Color.fromARGB(255, 198, 157, 252), width: 1.5),
//                     ),
//                     focusedBorder: OutlineInputBorder(
//                       borderRadius: BorderRadius.circular(10),
//                       borderSide: const BorderSide(
//                           color: Color.fromARGB(255, 198, 157, 252), width: 2.5),
//                     ),
//                     labelText: AppLocalizations.of(context)!.chooseExercise,
//                     labelStyle:
//                         Theme.of(context).textTheme.titleMedium?.copyWith(fontSize: 18),
//                   ),
//                   items: _exercises
//                       .map<DropdownMenuItem<String>>(
//                         (String exercise) => DropdownMenuItem<String>(
//                           value: exercise,
//                           child: Text(exercise),
//                         ),
//                       )
//                       .toList(),
//                   onChanged: (String? exercise) {
//                     setState(() {
//                       _exercise = exercise ?? _exercise;
//                       _updateExercises();

//                       if (_isWorkoutStarted) {
//                         _stopVideoStream();
//                         _isWorkoutStarted = false;
//                       }
//                     });
//                   },
//                   value: _exercise,
//                 ),
//               ),

//               Expanded(
//                 child: FutureBuilder<void>(
//                   future: _initializeCameraFuture,
//                   builder: (context, snapshot) {
//                     if (snapshot.connectionState == ConnectionState.done) {
//                       if (snapshot.hasError) {
//                         return Center(
//                           child: Text("Camera error: ${snapshot.error}"),
//                         );
//                       }
//                       return _isWorkoutStarted
//                           ? StreamBuilder<Uint8List>(
//                               stream: _imageStream,
//                               builder: (context, snapshot) {
//                                 if (snapshot.hasData) {
//                                   return Image.memory(snapshot.data!);
//                                 } else {
//                                   return Center(
//                                     child: Text(
//                                       startVideo,
//                                       style: TextStyle(
//                                         color: Colors.grey[700],
//                                         fontSize: 16,
//                                       ),
//                                     ),
//                                   );
//                                 }
//                               },
//                             )
//                           : Container(
//                               color: Colors.grey[300],
//                               child: Center(
//                                 child: Text(
//                                   startVideo,
//                                   style: TextStyle(
//                                     color: Colors.grey[700],
//                                     fontSize: 16,
//                                   ),
//                                 ),
//                               ),
//                             );
//                     } else {
//                       return const Center(child: CircularProgressIndicator());
//                     }
//                   },
//                 ),
//               ),

//               Padding(
//                 padding: const EdgeInsets.all(16.0),
//                 child: ElevatedButton(
//                   onPressed: _toggleWorkout,
//                   style: ElevatedButton.styleFrom(
//                     backgroundColor: _isWorkoutStarted
//                         ? const Color.fromARGB(255, 108, 91, 131)
//                         : const Color.fromARGB(255, 161, 90, 254),
//                     foregroundColor: Colors.white,
//                     padding:
//                         const EdgeInsets.symmetric(horizontal: 32, vertical: 16),
//                   ),
//                   child: Text(
//                     _isWorkoutStarted
//                         ? AppLocalizations.of(context)!.finishWorkout!
//                         : AppLocalizations.of(context)!.startWorkout!,
//                     style: const TextStyle(fontSize: 18),
//                   ),
//                 ),
//               ),
//             ],
//           ),
//         ],
//       ),
//     );
//   }
// }


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
    for (var i = 0, angleInDegrees = 0.0; i < count; i++, angleInDegrees += step) {
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