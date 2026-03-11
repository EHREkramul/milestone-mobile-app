import 'dart:async';
import 'package:flutter/foundation.dart';
import '../models/milestone_session.dart';
import 'database_service.dart';

class TimerService extends ChangeNotifier {
  static final TimerService _instance = TimerService._internal();
  factory TimerService() => _instance;
  TimerService._internal();

  final DatabaseService _db = DatabaseService();
  Timer? _timer;
  MilestoneSession? _activeSession;
  Duration _elapsed = Duration.zero;
  bool _isRunning = false;

  MilestoneSession? get activeSession => _activeSession;
  Duration get elapsed => _elapsed;
  bool get isRunning => _isRunning;

  // Time remaining in the current 24h cycle
  Duration get timeRemainingInCycle {
    if (!_isRunning) return const Duration(hours: 24);
    final secondsElapsed = _elapsed.inSeconds % (24 * 3600);
    final secondsRemaining = (24 * 3600) - secondsElapsed;
    return Duration(seconds: secondsRemaining);
  }

  // Progress of the current 24h cycle (0.0 to 1.0)
  double get cycleProgress {
    if (!_isRunning) return 0.0;
    final secondsElapsed = _elapsed.inSeconds % (24 * 3600);
    return secondsElapsed / (24 * 3600);
  }

  int get days => _elapsed.inDays;
  int get hours => _elapsed.inHours % 24;
  int get minutes => _elapsed.inMinutes % 60;
  int get seconds => _elapsed.inSeconds % 60;

  Future<void> init() async {
    final active = await _db.getActiveSession();
    if (active != null) {
      _activeSession = active;
      _elapsed = DateTime.now().difference(active.startTime);
      _isRunning = true;
      _startTicking();
    }
    notifyListeners();
  }

  Future<void> start() async {
    if (_isRunning) return;
    final session = MilestoneSession(startTime: DateTime.now(), isActive: true);
    final id = await _db.insertSession(session);
    _activeSession = session.copyWith(id: id);
    _elapsed = Duration.zero;
    _isRunning = true;
    _startTicking();
    notifyListeners();
  }

  Future<void> reset() async {
    // Stop current session and immediately start a fresh one from now
    _timer?.cancel();
    await _db.deactivateAllSessions();
    final session = MilestoneSession(startTime: DateTime.now(), isActive: true);
    final id = await _db.insertSession(session);
    _activeSession = session.copyWith(id: id);
    _elapsed = Duration.zero;
    _isRunning = true;
    _startTicking();
    notifyListeners();
  }

  Future<void> stop() async {
    _timer?.cancel();
    await _db.deactivateAllSessions();
    _activeSession = null;
    _elapsed = Duration.zero;
    _isRunning = false;
    notifyListeners();
  }

  Future<void> updateStartTime(DateTime newStartTime) async {
    if (_isRunning && _activeSession != null) {
      final updated = _activeSession!.copyWith(startTime: newStartTime);
      await _db.updateSession(updated);
      _activeSession = updated;
    } else {
      await _db.deactivateAllSessions();
      final session = MilestoneSession(startTime: newStartTime, isActive: true);
      final id = await _db.insertSession(session);
      _activeSession = session.copyWith(id: id);
      _isRunning = true;
      _startTicking();
    }
    _elapsed = DateTime.now().difference(newStartTime);
    notifyListeners();
  }

  void _startTicking() {
    _timer?.cancel();
    _timer = Timer.periodic(const Duration(seconds: 1), (_) {
      if (_activeSession != null) {
        _elapsed = DateTime.now().difference(_activeSession!.startTime);
        notifyListeners();
      }
    });
  }

  @override
  void dispose() {
    _timer?.cancel();
    super.dispose();
  }
}
