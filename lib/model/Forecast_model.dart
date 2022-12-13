import 'package:elgaw/model/forecast_day_model.dart';

class Forecast {
  List<ForeCastDay>? forecastday;

  Forecast({this.forecastday});

  Forecast.fromJson(Map<String, dynamic> json) {
    if (json['forecastday'] != null) {
      forecastday = <ForeCastDay>[];
      json['forecastday'].forEach((v) {
        forecastday!.add(ForeCastDay.fromJson(v));
      });
    }
  }

}