import 'package:elgaw/model/AstroModel.dart';
import 'package:elgaw/model/DayModel.dart';
import 'package:elgaw/model/HoureModel.dart';

class ForeCastDay {
  String? date;
  int? dateEpoch;
  Day? day;
  Astro? astro;
  List<Hour>? hour;

  ForeCastDay({this.date, this.dateEpoch, this.day, this.astro, this.hour});

  ForeCastDay.fromJson(Map<String, dynamic> json) {
    date = json['date'];
    dateEpoch = json['date_epoch'];
    day = json['day'] != null ? Day.fromJson(json['day']) : null;
    astro = json['astro'] != null ? Astro.fromJson(json['astro']) : null;
    if (json['hour'] != null) {
      hour = <Hour>[];
      json['hour'].forEach((v) {
        hour!.add(Hour.fromJson(v));
      });
    }
  }
}
