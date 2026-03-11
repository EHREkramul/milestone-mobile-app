import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import 'services/timer_service.dart';
import 'screens/home_screen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);
  SystemChrome.setSystemUIOverlayStyle(
    const SystemUiOverlayStyle(
      statusBarColor: Colors.transparent,
      statusBarIconBrightness: Brightness.light,
    ),
  );

  final timerService = TimerService();
  try {
    await timerService.init();
  } catch (_) {
    // Database init failure is non-fatal; app will start with no active session
  }

  runApp(
    ChangeNotifierProvider.value(
      value: timerService,
      child: const MilestoneApp(),
    ),
  );
}

class MilestoneApp extends StatelessWidget {
  const MilestoneApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Milestone',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        useMaterial3: true,
        colorScheme: ColorScheme.fromSeed(
          seedColor: const Color(0xFF7B2FF7),
          brightness: Brightness.dark,
        ),
        scaffoldBackgroundColor: const Color(0xFF0D0D1A),
        fontFamily: 'SF Pro Display',
      ),
      home: const HomeScreen(),
    );
  }
}
