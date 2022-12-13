import 'package:elgaw/core/api_constant.dart';
import 'package:elgaw/model/weather_model.dart';
import 'package:elgaw/view_model/network/remote_data_source.dart';
import 'package:elgaw/view_model/weather_cubit/weather_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class WeatherCubit extends Cubit<WeatherState> {
  WeatherCubit() : super(WeatherInitialState());

  static WeatherCubit get(context) => BlocProvider.of(context);
  WeatherModel? model;

  Future getWeather({
   double? long,
    double? lat
}) async {
    emit(WeatherLoadingState());
    WeatherDio.getData(url: ApiConstant.foreCast, queryParameters: {
      'q': '$lat,$long',
      'key': ApiConstant.apiKey,
      'days': 7,
    }).then((value) {
      model = WeatherModel.fromJson(value.data);
      print(value.data);
      emit(WeatherSuccessState());
    }).catchError((error) {
      print(error.toString());
      emit(WeatherErrorState());
    });
  }

  Future getWeatherByCity({
 String? city,
  }) async {
    emit(WeatherByCityLoadingState());
    WeatherDio.getData(url: ApiConstant.foreCast, queryParameters: {
      'q': city,
      'key': ApiConstant.apiKey,
      'days': 7,
    }).then((value) {
      model = WeatherModel.fromJson(value.data);
      print(value.data);
      emit(WeatherByCitySuccessState());
    }).catchError((error) {
      print(error.toString());
      emit(WeatherByCityErrorState());
    });
  }

  String getImage(context) {
    if (WeatherCubit.get(context).model!.current!.condition!.text == 'Sunny') {
      return 'assets/images/summer.png';
    } else if (WeatherCubit.get(context).model!.current!.condition!.text ==
        'Partly cloudy') {
      return 'assets/images/partlycloud.png';
    } else if (WeatherCubit.get(context).model!.current!.condition!.text ==
        'Cloudy') {
      return 'assets/images/cloud.png';
    } else if (WeatherCubit.get(context).model!.current!.condition!.text ==
        'Mist') {
      return 'assets/images/mist.png';
    } else if (WeatherCubit.get(context).model!.current!.condition!.text ==
        'Patchy rain possible') {
      return 'assets/images/.png';
    } else if (WeatherCubit.get(context).model!.current!.condition!.text ==
        'Patchy snow possible') {
      return 'assets/images/snow.png';
    } else if (WeatherCubit.get(context).model!.current!.condition!.text ==
        'Light rain') {
      return 'assets/images/lightrain.png';
    } else if (WeatherCubit.get(context).model!.current!.condition!.text ==
        'Overcast') {
      return 'assets/images/overcast.png';
    } else if (WeatherCubit.get(context).model!.current!.condition!.text ==
        'Clear') {
      return 'assets/images/clear.png';
    } else if (WeatherCubit.get(context).model!.current!.condition!.text ==
        'Patchy sleet nearby') {
      return 'assets/images/sleet.png';
    } else if (WeatherCubit.get(context).model!.current!.condition!.text ==
        'Thundery outbreaks in nearby') {
      return 'assets/images/thunder.png';
    } else {
      return 'assets/images/summer.png';
    }
  }

  String getImageForCast(context,index) {
    if (WeatherCubit.get(context).model!.forecast!.forecastday![0].hour![index].condition!.text == 'Sunny') {
      return 'assets/images/summer.png';
    } else if (WeatherCubit.get(context).model!.forecast!.forecastday![0].hour![index].condition!.text ==
        'Partly cloudy') {
      return 'assets/images/partlycloud.png';
    } else if (WeatherCubit.get(context).model!.forecast!.forecastday![0].hour![index].condition!.text ==
        'Cloudy') {
      return 'assets/images/cloud.png';
    } else if (WeatherCubit.get(context).model!.forecast!.forecastday![0].hour![index].condition!.text ==
        'Mist') {
      return 'assets/images/mist.png';
    } else if (WeatherCubit.get(context).model!.forecast!.forecastday![0].hour![index].condition!.text ==
        'Patchy rain possible') {
      return 'assets/images/.png';
    } else if (WeatherCubit.get(context).model!.forecast!.forecastday![0].hour![index].condition!.text ==
        'Patchy snow possible') {
      return 'assets/images/snow.png';
    } else if (WeatherCubit.get(context).model!.forecast!.forecastday![0].hour![index].condition!.text ==
        'Light rain') {
      return 'assets/images/lightrain.png';
    } else if (WeatherCubit.get(context).model!.forecast!.forecastday![0].hour![index].condition!.text ==
        'Overcast') {
      return 'assets/images/overcast.png';
    } else if (WeatherCubit.get(context).model!.forecast!.forecastday![0].hour![index].condition!.text ==
        'Clear') {
      return 'assets/images/clear.png';
    } else if (WeatherCubit.get(context).model!.forecast!.forecastday![0].hour![index].condition!.text ==
        'Patchy sleet nearby') {
      return 'assets/images/sleet.png';
    } else if (WeatherCubit.get(context).model!.forecast!.forecastday![0].hour![index].condition!.text ==
        'Thundery outbreaks in nearby') {
      return 'assets/images/thunder.png';
    } else {
      return 'assets/images/summer.png';
    }
  }

  String getImageDaily(context,index) {
    if (WeatherCubit.get(context).model!.forecast!.forecastday![index].day!.condition!.text == 'Sunny') {
      return 'assets/images/summer.png';
    } else if (WeatherCubit.get(context).model!.forecast!.forecastday![index].day!.condition!.text ==
        'Partly cloudy') {
      return 'assets/images/partlycloud.png';
    } else if (WeatherCubit.get(context).model!.forecast!.forecastday![index].day!.condition!.text ==
        'Cloudy') {
      return 'assets/images/cloud.png';
    } else if (WeatherCubit.get(context).model!.forecast!.forecastday![index].day!.condition!.text ==
        'Mist') {
      return 'assets/images/mist.png';
    } else if (WeatherCubit.get(context).model!.forecast!.forecastday![index].day!.condition!.text ==
        'Patchy rain possible') {
      return 'assets/images/.png';
    } else if (WeatherCubit.get(context).model!.forecast!.forecastday![index].day!.condition!.text ==
        'Patchy snow possible') {
      return 'assets/images/snow.png';
    } else if (WeatherCubit.get(context).model!.forecast!.forecastday![index].day!.condition!.text ==
        'Light rain') {
      return 'assets/images/lightrain.png';
    } else if (WeatherCubit.get(context).model!.forecast!.forecastday![index].day!.condition!.text ==
        'Overcast') {
      return 'assets/images/overcast.png';
    } else if (WeatherCubit.get(context).model!.forecast!.forecastday![index].day!.condition!.text ==
        'Clear') {
      return 'assets/images/clear.png';
    } else if (WeatherCubit.get(context).model!.forecast!.forecastday![index].day!.condition!.text ==
        'Patchy sleet nearby') {
      return 'assets/images/sleet.png';
    } else if (WeatherCubit.get(context).model!.forecast!.forecastday![index].day!.condition!.text ==
        'Thundery outbreaks in nearby') {
      return 'assets/images/thunder.png';
    } else {
      return 'assets/images/summer.png';
    }
  }

  String getImageBackGround(context) {
    if (WeatherCubit.get(context).model!.current!.condition!.text == 'Sunny') {
      return 'assets/images/MorningBackGround.gif';
    } else if (WeatherCubit.get(context).model!.current!.condition!.text ==
        'Partly cloudy') {
      return 'assets/images/CloudlyBackGround.gif';
    } else if (WeatherCubit.get(context).model!.current!.condition!.text ==
        'Cloudy') {
      return 'assets/images/CloudlyBackGround.gif';
    } else if (WeatherCubit.get(context).model!.current!.condition!.text==
        'Mist') {
      return 'assets/images/mist.jpeg';
    } else if (WeatherCubit.get(context).model!.current!.condition!.text ==
        'Patchy rain possible') {
      return 'assets/images/RainBackGround.gif';
    } else if (WeatherCubit.get(context).model!.current!.condition!.text==
        'Patchy snow possible') {
      return 'assets/images/SnowBackGround.gif';
    } else if (WeatherCubit.get(context).model!.current!.condition!.text ==
        'Light rain') {
      return 'assets/images/RainBackGround.gif';
    } else if (WeatherCubit.get(context).model!.current!.condition!.text ==
        'Overcast') {
      return 'assets/images/overcastBack.jpeg';
    } else if (WeatherCubit.get(context).model!.current!.condition!.text ==
        'Clear') {
      return 'assets/images/NightBackGround.gif';
    } else if (WeatherCubit.get(context).model!.current!.condition!.text ==
        'Patchy sleet nearby') {
      return 'assets/images/SnowBackGround.gif';
    } else if (WeatherCubit.get(context).model!.current!.condition!.text ==
        'Thundery outbreaks in nearby') {
      return 'assets/images/ThunderBackGround.gif';
    } else {
      return 'assets/images/MorningBackGround.gif';
    }
  }

}
