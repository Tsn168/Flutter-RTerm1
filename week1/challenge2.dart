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

  FestivalSchedule({required this.rules});
  void addPerformance(Performance performance) {
    if (performances.length >= rules.maximumPerformances) {
      print('Too many performances');
      return;
    }
    if (hasConflict(performance)) {
      print('Conflict! Cannot add ${performance.artist}');
      return;
    }
    performances.add(performance);
    print('${performance.artist} added successfully');
  }

  void listStage(String stage) {
    print('\nPerformances on $stage:');

    for (var performance in performances) {
      if (performance.stage == stage) {
        print(
          '${performance.artist}: '
          '${performance.startTime} - '
          '${performance.endTime}',
        );
      }
    }
  }

  Performance? findArtist(String artist) {
    for (var performance in performances) {
      if (performance.artist == artist) {
        return performance;
      }
    }
    return null;
  }

  bool hasConflict(Performance newPerformance) {
    for (var performance in performances) {
      if (performance.stage != newPerformance.stage) {
        continue;
      }
      if (rules.allowOverlap) {
        continue;
      }

      if (newPerformance.startTime < performance.endTime &&
          newPerformance.endTime > performance.startTime) {
        return true;
      }
      if (newPerformance.startTime >= performance.endTime) {
        int gap = newPerformance.startTime - performance.endTime;

        if (gap < rules.minimumGap) {
          return true;
        }
      }
    }

    return false;
  }

  int get totalDuration {
    int total = 0;

    for (var performance in performances) {
      total += performance.duration;
    }
    return total;
  }
}

void main() {
  final rules = ScheduleRules(
    minimumGap: 10,
    maximumPerformances: 5,
    allowOverlap: false,
  );

  final festival = FestivalSchedule(rules: rules);
  final p1 = Performance(
    artist: 'VannDa',
    stage: 'Stage A',
    startTime: 19 * 60,
    endTime: 20 * 60,
  );

  final p2 = Performance(
    artist: 'DARA',
    stage: 'Stage B',
    startTime: 19 * 60 + 30,
    endTime: 20 * 60 + 30,
  );

  final p3 = Performance(
    artist: 'Artist C',
    stage: 'Stage A',
    startTime: 20 * 60 + 10,
    endTime: 21 * 60,
  );

  final p4 = Performance(
    artist: 'Artist D',
    stage: 'Stage B',
    startTime: 21 * 60,
    endTime: 22 * 60,
  );

  final p5 = Performance(
    artist: 'Artist E',
    stage: 'Stage A',
    startTime: 21 * 60 + 10,
    endTime: 22 * 60,
  );
  festival.addPerformance(p1);
  festival.addPerformance(p2);
  festival.addPerformance(p3);
  festival.addPerformance(p4);
  festival.addPerformance(p5);

  festival.listStage('Stage A');

  final result = festival.findArtist('VannDa');

  if (result != null) {
    print('\nArtist found: ${result.artist}');
    print('Stage: ${result.stage}');
    print('Duration: ${result.duration} minutes');
  }
  print(
    '\nTotal duration: '
    '${festival.totalDuration} minutes',
  );
  final conflict = Performance(
    artist: 'Artist F',
    stage: 'Stage A',
    startTime: 19 * 60 + 30,
    endTime: 20 * 60 + 30,
  );
  festival.addPerformance(conflict);
}
