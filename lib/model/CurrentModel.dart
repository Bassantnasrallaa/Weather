import 'package:elgaw/model/ConditionModel.dart';

class Current {
  String? lastUpdated;
  double? tempC;
  int? isDay;
  int? humidity;
  Condition? condition;
  double? windKph;
  int? windDegree;
  String? windDir;
  double? pressureMb;
  double? pressureIn;


  Current({
    this.lastUpdated,
    this.tempC,
    this.isDay,
    this.condition,
    this.windKph,
    this.windDegree,
    this.windDir,
    this.pressureMb,
    this.pressureIn,
    this.humidity,
  });

  Current.fromJson(Map<String, dynamic> json) {
    lastUpdated = json['last_updated'];
    tempC = json['temp_c'];
    isDay = json['is_day'];
    condition = json['condition'] != null
        ? Condition.fromJson(json['condition'])
        : null;
    windKph = json['wind_kph'];
    windDegree = json['wind_degree'];
    windDir = json['wind_dir'];
    pressureMb = json['pressure_mb'];
    pressureIn = json['pressure_in'];
    humidity = json['humidity'];
  }
}
