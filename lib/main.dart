import 'package:elgaw/screens/HomeScreen.dart';
import 'package:elgaw/screens/getlocationScreen.dart';
import 'package:elgaw/view_model/network/remote_data_source.dart';
import 'package:elgaw/view_model/weather_cubit/weather_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await WeatherDio.init();
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context)=>WeatherCubit()..getWeather(),
      child: const MaterialApp(
          title: 'Weather',
          debugShowCheckedModeBanner: false,
          home: GetLocationScreen()
      ),
    );
  }
}


