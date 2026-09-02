class measurment {
  String sensorName;
  double value;
  String unit;
  String? comment;
  measurment({
    required this.sensorName,
    this.comment,
    required this.unit,
    required this.value,
  });
}

class configSensor {
  final double? minimum;
  final double? maximum;
  configSensor({this.maximum, this.minimum});
}

class sateliteTelemetry {}

void main() {}
