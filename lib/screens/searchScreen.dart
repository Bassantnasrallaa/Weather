import 'package:elgaw/model/weather_model.dart';
import 'package:elgaw/screens/SeachHome.dart';
import 'package:elgaw/view_model/weather_cubit/weather_cubit.dart';
import 'package:elgaw/view_model/weather_cubit/weather_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class SearchScreen extends StatelessWidget {
   SearchScreen({Key? key,this.updateUi}) : super(key: key);

  VoidCallback? updateUi;

  @override
  Widget build(BuildContext context) {
    String? cityName;
    return BlocBuilder<WeatherCubit, WeatherState>(
      builder: (context, state) {
        return Scaffold(
          appBar: AppBar(),
          body: Column(
            children: [
              TextFormField(
                keyboardType: TextInputType.text,
                onFieldSubmitted: (text)async {
                   cityName=text;
                  WeatherCubit.get(context).getWeatherByCity(city: cityName);
                  WeatherModel weather=await WeatherCubit.get(context).getWeatherByCity(city: cityName);
                   weatherData=weather;
                   updateUi!();
                },
                decoration: InputDecoration(
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                    )
                ),
              ),
              ElevatedButton(onPressed: (){
                Navigator.push(context, MaterialPageRoute(builder: (context)=> SearchHome()));
              }, child: const Text('Search'))
            ],
          ),
        );
      },
    );
  }
}
WeatherModel? weatherData;
