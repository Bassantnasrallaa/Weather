import 'package:elgaw/screens/HomeScreen.dart';
import 'package:elgaw/view_model/weather_cubit/weather_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:geolocator/geolocator.dart';

class GetLocationScreen extends StatefulWidget {
  const GetLocationScreen({Key? key}) : super(key: key);

  @override
  State<GetLocationScreen> createState() => _GetLocationScreenState();
}

class _GetLocationScreenState extends State<GetLocationScreen> {
  double? long;
  double? lat;
  late Position position;

  void getCurrent() async {
    await Geolocator.checkPermission();
    await Geolocator.requestPermission();
    position = await Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.high);
  }
  @override
  void initState() {
    super.initState();
    getCurrent();
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
        create: (context) => WeatherCubit(),
        child: Scaffold(
          backgroundColor: Colors.grey[400],
          body: Center(
            child: ElevatedButton(
                onPressed: () async {
                  lat = position.latitude;
                  long = position.longitude;
                   WeatherCubit.get(context)
                      .getWeather(long: long, lat: lat);
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => const MyHomePage()));
                },
                child: const Text('Get your location')),
          ),
        ));
  }
}
