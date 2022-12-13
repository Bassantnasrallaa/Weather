import 'package:elgaw/model/ConditionModel.dart';

class Day {
  double? maxtempC;
  double? mintempC;
  double? maxwindKph;
  Condition? condition;

  Day({
    this.maxtempC,
    this.mintempC,
    this.maxwindKph,
    this.condition,
  });

  Day.fromJson(Map<String, dynamic> json) {
    maxtempC = json['maxtemp_c'];
    mintempC = json['mintemp_c'];
    maxwindKph = json['maxwind_kph'];
    condition = json['condition'] != null
        ? Condition.fromJson(json['condition'])
        : null;
  }
}
