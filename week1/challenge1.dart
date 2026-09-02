class Measurement {
  final String sensorName;
  final double value;
  final String unit;
  final String? comment;
  Measurement({
    required this.sensorName,
    required this.value,
    required this.unit,
    this.comment,
  });
}

class SensorConfig {
  final String sensorName;
  final double? minimum;
  final double? maximum;
  SensorConfig({required this.sensorName, this.minimum, this.maximum});

  bool isValid(double value) {
    if (minimum != null && value < minimum!) {
      return false;
    }
    if (maximum != null && value > maximum!) {
      return false;
    }
    return true;
  }
}

class satelitetelemetry {
  final List<Measurement> mesurments = [];

  void addMesurement(Measurement mesurment) {
    mesurments.add(mesurment);
  }

  void display() {
    for (var mesurement in mesurments) {
      print(
        '${mesurement.sensorName}'
        '${mesurement.unit}'
        '${mesurement.value}',
      );
    }
  }

  List<Measurement> findWhichSensor(String sensorName) {
    return mesurments
        .where((mesurments) => mesurments.sensorName == sensorName)
        .toList();
  }

  double checkAverage(String sensorName) {
    final result = findWhichSensor(sensorName);
    if (result.isEmpty) {
      return 0;
    }
    double total = 0;
    for (var mesurements in result) {
      total = total + mesurements.value;
    }
    return total / result.length;
  }

  void checkSensorValue(double value, SensorConfig config) {
    if (config.isValid(value)) {
      print('$value, OK');
    } else {
      print('$value, Outside the range');
    }
  }
}

void main() {
  final tele = satelitetelemetry();

  tele.addMesurement(
    Measurement(sensorName: "temparature", value: 100, unit: 'C'),
  );
}
