import 'package:elgaw/model/CurrentModel.dart';
import 'package:elgaw/model/Forecast_model.dart';
import 'package:elgaw/model/LocationModel.dart';

class WeatherCityModel{
  Location? location;
  Current? current;
  Forecast? forecast;

  WeatherCityModel({this.location, this.current, this.forecast});

  WeatherCityModel.fromJson(Map<String, dynamic> json) {
    location = json['location'] != null
        ? Location.fromJson(json['location'])
        : null;
    current =
    json['current'] != null ? Current.fromJson(json['current']) : null;
    forecast = json['forecast'] != null
        ? Forecast.fromJson(json['forecast'])
        : null;
  }
}