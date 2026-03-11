class MilestoneSession {
  final int? id;
  final DateTime startTime;
  final DateTime? endTime;
  final bool isActive;

  MilestoneSession({
    this.id,
    required this.startTime,
    this.endTime,
    this.isActive = false,
  });

  int get daysCompleted {
    final end = endTime ?? DateTime.now();
    return end.difference(startTime).inDays;
  }

  Duration get totalDuration {
    final end = endTime ?? DateTime.now();
    return end.difference(startTime);
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'start_time': startTime.millisecondsSinceEpoch,
      'end_time': endTime?.millisecondsSinceEpoch,
      'is_active': isActive ? 1 : 0,
    };
  }

  factory MilestoneSession.fromMap(Map<String, dynamic> map) {
    return MilestoneSession(
      id: map['id'],
      startTime: DateTime.fromMillisecondsSinceEpoch(map['start_time']),
      endTime: map['end_time'] != null
          ? DateTime.fromMillisecondsSinceEpoch(map['end_time'])
          : null,
      isActive: map['is_active'] == 1,
    );
  }

  MilestoneSession copyWith({
    int? id,
    DateTime? startTime,
    DateTime? endTime,
    bool? isActive,
  }) {
    return MilestoneSession(
      id: id ?? this.id,
      startTime: startTime ?? this.startTime,
      endTime: endTime ?? this.endTime,
      isActive: isActive ?? this.isActive,
    );
  }
}
