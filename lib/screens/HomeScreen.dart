import 'dart:async';
import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:elgaw/core/AppConst.dart';
import 'package:elgaw/screens/searchScreen.dart';
import 'package:elgaw/view_model/weather_cubit/weather_cubit.dart';
import 'package:elgaw/view_model/weather_cubit/weather_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:geolocator/geolocator.dart';
import 'package:intl/intl.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key});

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  String formattedTime = DateFormat.jm().format(DateTime.now());
  String hour = DateFormat('a').format(DateTime.now());
  Timer? _timer;

  @override
  void initState() {
    super.initState();
    _timer =
        Timer.periodic(const Duration(milliseconds: 500), (timer) => _update());
  }

  void _update() {
    setState(() {
      formattedTime = DateFormat.jm().format(DateTime.now());
      hour = DateFormat('a').format(DateTime.now());
    });
  }

  var date = DateFormat('yyyy-MMMM-dd').format(DateTime.now());
  var searchController = TextEditingController();
  GlobalKey<FormState> key=GlobalKey<FormState>();


  @override
  Widget build(BuildContext context) {
    return BlocBuilder<WeatherCubit, WeatherState>(
        builder: (context, state) {
          return  ConditionalBuilder(
              condition: state is WeatherSuccessState,
              builder: (context){
                return Scaffold(
                  body: Container(
                    decoration: BoxDecoration(
                        image: DecorationImage(
                            fit: BoxFit.cover,
                            image: AssetImage(
                              WeatherCubit.get(context).getImageBackGround(context),
                            ))),
                    child: Padding(
                      padding: const EdgeInsets.all(10.0),
                      child: Center(
                        child: ListView(
                          physics: const BouncingScrollPhysics(),
                          children: [
                            Text(
                              formattedTime,
                              textAlign: TextAlign.right,
                              style: const TextStyle(
                                  fontSize: 25,
                                  decoration: TextDecoration.underline,
                                  fontFamily: 'Cairo-ExtraBold.ttf',
                                  color: AppConstant.textColor,
                                  fontWeight: FontWeight.bold),
                            ),
                            Text(
                              date,
                              textAlign: TextAlign.right,
                              style: const TextStyle(
                                  fontSize: 25,
                                  fontFamily: 'Cairo-ExtraBold.ttf',
                                  color: AppConstant.textColor,
                                  fontWeight: FontWeight.bold),
                            ),
                            RichText(
                                text: TextSpan(
                                  children: [
                                    const WidgetSpan(
                                        child: Icon(
                                          Icons.location_on,
                                          color: AppConstant.iconColor,
                                          size: 24,
                                        )),
                                    TextSpan(
                                      text:
                                      '${WeatherCubit.get(context).model!.location!.name}',
                                      style: const TextStyle(
                                          fontWeight: FontWeight.bold,
                                          color: AppConstant.textColor,
                                          fontSize: 24),
                                    ),
                                    TextSpan(
                                      text:
                                      '/${WeatherCubit.get(context).model!.location!.country}',
                                      style: const TextStyle(
                                          fontSize: 20,
                                          fontFamily: 'Cairo-ExtraBold.ttf',
                                          color: AppConstant.textColor,
                                          fontWeight: FontWeight.bold),
                                    ),
                                  ],
                                )),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children: [
                                Text(
                                  '${WeatherCubit.get(context).model!.current!.tempC!.toInt()}${AppConstant.temp}',
                                  style: const TextStyle(
                                      fontSize: 35,
                                      color: AppConstant.textColor,
                                      fontWeight: FontWeight.bold),
                                ),
                                // Image.network(
                                //     'https:${WeatherCubit.get(context).model!.current!.condition!.icon}'),
                                Image.asset(
                                    WeatherCubit.get(context).getImage(context)),
                              ],
                            ),
                            Center(
                              child: Text(
                                '${WeatherCubit.get(context).model!.current!.condition!.text}',
                                style: const TextStyle(
                                    fontSize: 30,
                                    color: AppConstant.textColor,
                                    fontWeight: FontWeight.bold),
                              ),
                            ),
                            Card(
                              elevation: 15,
                              shadowColor: Colors.black,
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(15)),
                              child: Container(
                                padding: const EdgeInsets.all(10),
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(15),
                                  color: AppConstant.backGround,
                                ),
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                                  children: [
                                    buildColumn(
                                      image: 'assets/images/sunrise.png',
                                      text1:
                                      '${WeatherCubit.get(context).model!.forecast!.forecastday![0].astro!.sunrise}',
                                      text2: 'SunRise',
                                    ),
                                    buildColumn(
                                      image: 'assets/images/sunset.png',
                                      text1:
                                      '${WeatherCubit.get(context).model!.forecast!.forecastday![0].astro!.sunset}',
                                      text2: 'SunSet',
                                    ),
                                  ],
                                ),
                              ),
                            ),
                            Card(
                              elevation: 15,
                              shadowColor: Colors.black,
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(15)),
                              child: Container(
                                padding: const EdgeInsets.all(10),
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(15),
                                  color: AppConstant.backGround,
                                ),
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                                  children: [
                                    buildColumn(
                                      image: 'assets/images/wind.png',
                                      text1:
                                      '${WeatherCubit.get(context).model!.current!.windKph} m/s',
                                      text2: 'Wind',
                                    ),
                                    buildColumn(
                                      image: 'assets/images/wet.png',
                                      text1:
                                      '${WeatherCubit.get(context).model!.current!.humidity}%',
                                      text2: 'Humidity',
                                    ),
                                    buildColumn(
                                      image: 'assets/images/higtTemp.png',
                                      text1:
                                      '${WeatherCubit.get(context).model!.forecast!.forecastday![0].day!.maxtempC}${AppConstant.temp}',
                                      text2: 'Max_temp',
                                    ),
                                    buildColumn(
                                      image: 'assets/images/lowTemp.png',
                                      text1:
                                      '${WeatherCubit.get(context).model!.forecast!.forecastday![0].day!.mintempC}${AppConstant.temp}',
                                      text2: 'Low_temp',
                                    ),
                                  ],
                                ),
                              ),
                            ),
                            const Text(
                              'All Day',
                              textAlign: TextAlign.right,
                              style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  color: AppConstant.textColor,
                                  fontSize: 24,
                                  decoration: TextDecoration.underline),
                            ),
                            Container(
                              height: 170,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(15),
                              ),
                              child: ListView.separated(
                                physics: const BouncingScrollPhysics(),
                                scrollDirection: Axis.horizontal,
                                itemBuilder: (context, index) {
                                  return Card(
                                    shape: RoundedRectangleBorder(
                                        borderRadius: BorderRadius.circular(15)),
                                    color: AppConstant.backGround,
                                    child: Column(
                                      mainAxisAlignment:
                                      MainAxisAlignment.spaceEvenly,
                                      children: [
                                        Text(
                                          WeatherCubit.get(context)
                                              .model!
                                              .forecast!
                                              .forecastday![0]
                                              .hour![index]
                                              .time
                                              .toString(),
                                          style: const TextStyle(
                                              fontWeight: FontWeight.w500,
                                              color: AppConstant.textColor,
                                              fontSize: 14),
                                        ),
                                        Image.asset(
                                          WeatherCubit.get(context)
                                              .getImageForCast(context, index),
                                          height: 100,
                                          width: 100,
                                        ),
                                        Text(
                                          '${WeatherCubit.get(context).model!.forecast!.forecastday![0].hour![index].tempC}${AppConstant.temp}',
                                          style: const TextStyle(
                                              fontWeight: FontWeight.bold,
                                              color: AppConstant.textColor,
                                              fontSize: 24),
                                        )
                                      ],
                                    ),
                                  );
                                },
                                separatorBuilder: (context, index) => const SizedBox(
                                  width: 5,
                                ),
                                itemCount: WeatherCubit.get(context)
                                    .model!
                                    .forecast!
                                    .forecastday![0]
                                    .hour!
                                    .length,
                              ),
                            ),
                            const Text(
                              '3 Days',
                              textAlign: TextAlign.right,
                              style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  color: AppConstant.textColor,
                                  fontSize: 24,
                                  decoration: TextDecoration.underline),
                            ),
                            Container(
                              height: 300,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(15),
                              ),
                              child: ListView.separated(
                                physics: const BouncingScrollPhysics(),
                                scrollDirection: Axis.vertical,
                                itemBuilder: (context, index) {
                                  return Card(
                                    shape: RoundedRectangleBorder(
                                        borderRadius: BorderRadius.circular(15)),
                                    color: AppConstant.backGround,
                                    child: Row(
                                      mainAxisAlignment:
                                      MainAxisAlignment.spaceEvenly,
                                      children: [
                                        Text(
                                          WeatherCubit.get(context)
                                              .model!
                                              .forecast!
                                              .forecastday![index]
                                              .date
                                              .toString(),
                                          style: const TextStyle(
                                              fontWeight: FontWeight.w500,
                                              color: AppConstant.textColor,
                                              fontSize: 16),
                                        ),
                                        Image.asset(
                                          WeatherCubit.get(context)
                                              .getImageDaily(context, index),
                                          width: 60,
                                          height: 60,
                                        ),
                                        RichText(
                                            text: TextSpan(
                                              children: [
                                                TextSpan(
                                                  text:
                                                  '${WeatherCubit.get(context).model!.forecast!.forecastday![index].day!.maxtempC}${AppConstant.temp}',
                                                  style: const TextStyle(
                                                      fontWeight: FontWeight.bold,
                                                      color: AppConstant.textColor,
                                                      fontSize: 24),
                                                ),
                                                TextSpan(
                                                  text:
                                                  '/${WeatherCubit.get(context).model!.forecast!.forecastday![index].day!.mintempC}${AppConstant.temp}',
                                                  style: const TextStyle(
                                                      fontWeight: FontWeight.w400,
                                                      color: AppConstant.textColor,
                                                      fontSize: 20),
                                                ),
                                              ],
                                            )),
                                      ],
                                    ),
                                  );
                                },
                                separatorBuilder: (context, index) => const SizedBox(
                                  width: 5,
                                ),
                                itemCount: WeatherCubit.get(context)
                                    .model!
                                    .forecast!
                                    .forecastday!
                                    .length,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                  // floatingActionButton: FloatingActionButton(
                  //   backgroundColor: Colors.blue[800],
                  //   onPressed: (){
                  //     Navigator.push(context,MaterialPageRoute(builder: (context)=> SearchScreen()));
                  //   },
                  //   child: const Icon(
                  //     Icons.search,
                  //     size: 30,
                  //   ),
                  // ),
                );
              },
              fallback: (context)=> Center(child: LoadingAnimationWidget.staggeredDotsWave(
                color:AppConstant.backGround,
                size: 50,
              ),),
          );
        },
      );
  }

  void getCurrent()async{
    await Geolocator.checkPermission();
    await Geolocator.requestPermission();
    Position position = await Geolocator.getCurrentPosition(desiredAccuracy: LocationAccuracy.high);
    print(position);
  }

  Widget buildColumn(
          {required String image,
          required String text1,
          required String text2}) =>
      Column(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          Image.asset(
            image,
            width: 45,
            height: 45,
          ),
          Text(
            text1,
            style: const TextStyle(
                fontWeight: FontWeight.w500,
                color: AppConstant.textColor,
                fontSize: 18),
          ),
          Text(
            text2,
            style: const TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.w500,
                color: AppConstant.textColor),
          )
        ],
      );
}
