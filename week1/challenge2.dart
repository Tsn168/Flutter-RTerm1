class Performance {
  final String artist;
  final String stage;
  final int startTime;
  final int endTime;

  Performance({
    required this.artist,
    required this.stage,
    required this.startTime,
    required this.endTime,
  });

  int get duration {
    return endTime - startTime;
  }
}

class ScheduleRules {
  final int minimumGap;
  final int maximumPerformances;
  final bool allowOverlap;

  ScheduleRules({
    this.minimumGap = 0,
    this.maximumPerformances = 10,
    this.allowOverlap = false,
  });
}

class FestivalSchedule {
  final List<Performance> performances = [];

  final ScheduleRules rules;

