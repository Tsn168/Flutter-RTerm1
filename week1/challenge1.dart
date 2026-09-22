class Measurement {
  String sensorName;
  double value;
  String unit;

  Measurement({
    required this.sensorName,
    required this.value,
    required this.unit,
  });
}

class SensorConfig {
  String sensorName;
  double minimum;
  double maximum;

  SensorConfig({
    required this.sensorName,
    required this.minimum,
    required this.maximum,
  });

  bool isValid(double value) /{
    if (value < minimum) {
      return false;
    }

    if (value > maximum) {
      return false;
    }
    return true;
  }
}

class SatelliteTelemetry {
  final List<Measurement> measurements = [];

  void addMeasurement(Measurement measurement) {
    measurements.add(measurement);
  }

  void display() {
    for (var measurement in measurements) {
      print(
        '${measurement.sensorName} '
        '${measurement.value} '
        '${measurement.unit}',
      );
    }
  }

  List<Measurement> findSensor(String sensorName) {
    return measurements
        .where((measurement) => measurement.sensorName == sensorName)
        .toList();
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
  final tele = SatelliteTelemetry();
  tele.addMeasurement(
    Measurement(sensorName: 'temperature', value: 24.5, unit: 'C'),
  );

  tele.addMeasurement(
    Measurement(sensorName: 'temperature', value: 27.2, unit: 'C'),
  );

  tele.addMeasurement(Measurement(sensorName: 'battery', value: 87, unit: '%'));

  tele.addMeasurement(
    Measurement(sensorName: 'altitude', value: 540, unit: 'km'),
  );

  tele.addMeasurement(
    Measurement(sensorName: 'speed', value: 7.8, unit: 'km/s'),
  );

  tele.display();

  final temperatures = tele.findSensor('temperature');

  for (var measurement in temperatures) {
    print('${measurement.value} ${measurement.unit}');
  }

  final temperatureConfig = SensorConfig(
    sensorName: 'temperature',
    minimum: 0,
    maximum: 50,
  );

  tele.checkSensorValue(100, temperatureConfig);
}
