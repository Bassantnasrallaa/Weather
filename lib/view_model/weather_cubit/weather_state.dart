abstract class WeatherState {}

class WeatherInitialState extends WeatherState {}

class WeatherLoadingState extends WeatherState {}

class WeatherSuccessState extends WeatherState {}

class WeatherErrorState extends WeatherState {}

class WeatherByCityLoadingState extends WeatherState {}

class WeatherByCitySuccessState extends WeatherState {}

class WeatherByCityErrorState extends WeatherState {}
