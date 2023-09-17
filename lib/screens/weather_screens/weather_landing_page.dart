import 'dart:ui';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:location/location.dart';
import '../../api/weather/weather_api.dart';
import '../../components/location/fetch_location.dart';
import '../../models/local_task_model.dart';
import '../../models/weather_forecast_model.dart';
import '../../utils/constant_data.dart';
import '../../utils/local_storage/hive_methods.dart';
import '../../utils/local_storage/local_store_manager.dart';

extension StringCasingExtension on String {
  String toCapitalized() =>
      length > 0 ? '${this[0].toUpperCase()}${substring(1).toLowerCase()}' : '';
  String toTitleCase() => replaceAll(RegExp(' +'), ' ')
      .split(' ')
      .map((str) => str.toCapitalized())
      .join(' ');
}

class WeatherLandingPage extends StatefulWidget {
  const WeatherLandingPage({Key? key}) : super(key: key);

  @override
  State<WeatherLandingPage> createState() => _WeatherLandingPageState();
}

class _WeatherLandingPageState extends State<WeatherLandingPage> {
  WeatherForecastModel? _data;
  LocationData? _locationData;
  List<Alert> alertList = [];
  List<LocalTaskModel> tasks = [];
  @override
  void initState() {
    _getLocalData();
    _getTaskList();
    super.initState();
  }

  _getLocation() {
    FetchLocation().getCurrentLocation().then((value) {
      if (value != null) {
        setState(() {
          _locationData = value;
        });
        _getWeatherData("${value.latitude},${value.longitude}");
      }
    });
  }

  _getLocalData() async {
    LocalStorageManager.readData(AppConstant.location).then((value) {
      if (value != null) {
        _getWeatherData(value);
      } else {
        _getLocation();
      }
    });
  }

  _getWeatherData(String location) {
    WeatherApi().getForecastDataApi(location).then((value) {
      if (value != null) {
        setState(() {
          _data = value;
          alertList = value.alerts!.alert!;
        });
      } else {
        _getLocation();
      }
    });
  }

  void _getTaskList() {
    HiveMethods().getTaskLists().then((value) {
      setState(() {
        tasks = value;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: _data != null
          ? RefreshIndicator(
              onRefresh: () async {
                _getLocalData();
                _getTaskList();
              },
              child: Container(
                height: double.infinity,
                width: double.infinity,
                decoration: const BoxDecoration(
                    image: DecorationImage(
                        fit: BoxFit.cover,
                        image:
                            CachedNetworkImageProvider(AppConstant.onBackImg))),
                child: Column(
                  children: [
                    _weatherSummery(),
                    _taskList(),
                    _fiveDaysWeather(),
                    _alertWidget()
                  ],
                ),
              ),
            )
          : const Center(child: CircularProgressIndicator()),
    );
  }

  Widget _weatherSummery() {
    final Duration duration = DateTime.now().difference(
        DateTime.fromMillisecondsSinceEpoch(
            _data!.current!.lastUpdatedEpoch! * 1000));
    int localTime = _data!.location!.localtimeEpoch! * 1000;
    return Container(
      width: double.infinity,
      margin: const EdgeInsets.symmetric(vertical: 20.0, horizontal: 10.0),
      child: ClipRect(
          child: BackdropFilter(
              filter: ImageFilter.blur(sigmaX: 10.0, sigmaY: 10.0),
              child: Container(
                padding:
                    const EdgeInsets.symmetric(vertical: 5.0, horizontal: 8.0),
                decoration: BoxDecoration(
                    color: Colors.grey.shade200.withOpacity(0.5),
                    borderRadius: const BorderRadius.all(Radius.circular(8.0))),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        const Icon(
                          Icons.location_on_outlined,
                          color: Colors.white,
                          size: 20,
                        ),
                        Text(
                          _data!.location!.name!,
                          style: Theme.of(context)
                              .textTheme
                              .titleSmall!
                              .copyWith(
                                  fontWeight: FontWeight.bold,
                                  color: Colors.white),
                        ),
                        const Spacer(),
                        const SizedBox(width: 8.0),
                        const Icon(
                          Icons.update,
                          color: Colors.white,
                          size: 20,
                        ),
                        Text(
                          "${duration.inMinutes} Minutes",
                          style: Theme.of(context)
                              .textTheme
                              .titleSmall!
                              .copyWith(
                                  fontWeight: FontWeight.bold,
                                  color: Colors.white),
                        )
                      ],
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Image.network(
                            "https:${_data!.current!.condition!.icon!}"),
                        Text(
                          "${_data!.current!.tempC}°C",
                          style: Theme.of(context)
                              .textTheme
                              .titleLarge!
                              .copyWith(
                                  fontSize: 30,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.white),
                        )
                      ],
                    ),
                    Text(
                      _data!.current!.condition!.text!.toTitleCase(),
                      style: Theme.of(context).textTheme.titleLarge!.copyWith(
                          fontSize: 24,
                          fontWeight: FontWeight.w500,
                          color: Colors.white),
                    ),
                    Text(
                      DateFormat("EEEE, dd MMM yyyy").format(
                          DateTime.fromMillisecondsSinceEpoch(localTime)),
                      style: Theme.of(context).textTheme.titleLarge!.copyWith(
                          fontSize: 18,
                          fontWeight: FontWeight.normal,
                          color: Colors.white),
                    ),
                    const SizedBox(height: 8.0),
                    Text(
                      "Min ${_data!.forecast!.forecastday![0].day!.mintempC}°  |  Max ${_data!.forecast!.forecastday![0].day!.maxtempC}°  |  Feels Like ${_data!.current!.feelslikeC}°",
                      style: Theme.of(context).textTheme.titleLarge!.copyWith(
                          fontSize: 14,
                          fontWeight: FontWeight.w500,
                          color: Colors.white),
                    ),
                    const SizedBox(height: 8.0),
                    Text(
                      "Wind ${_data!.current!.windKph} Km/H  |  Humidity ${_data!.current!.humidity}%",
                      style: Theme.of(context).textTheme.titleLarge!.copyWith(
                          fontSize: 14,
                          fontWeight: FontWeight.w500,
                          color: Colors.white),
                    ),
                    const SizedBox(height: 8.0),
                    Text(
                      "Sunrise  ${_data!.forecast!.forecastday![0].astro!.sunrise}  |  Sunset ${_data!.forecast!.forecastday![0].astro!.sunset}",
                      style: Theme.of(context).textTheme.titleLarge!.copyWith(
                          fontSize: 14,
                          fontWeight: FontWeight.w500,
                          color: Colors.white),
                    ),
                  ],
                ),
              ))),
    );
  }

  Widget _taskList() {
    return Expanded(
      child: ListView.builder(
          itemCount: tasks.length > 2 ? 2 : tasks.length,
          itemBuilder: (c, int i) {
            return Container(); //TaskComponent(task: tasks[i],);
          }),
    );
  }

  Widget _fiveDaysWeather() {
    return Container(
      height: 210,
      padding: const EdgeInsets.symmetric(vertical: 5.0, horizontal: 8.0),
      margin: const EdgeInsets.symmetric(vertical: 5.0, horizontal: 8.0),
      decoration: BoxDecoration(
          color: Colors.grey.shade200.withOpacity(0.2),
          borderRadius: const BorderRadius.all(Radius.circular(8.0))),
      child: ListView.builder(
          itemCount: _data!.forecast!.forecastday!.length,
          itemBuilder: (c, i) {
            Forecastday _fDay = _data!.forecast!.forecastday![i];
            if (i == 0) {
              return const SizedBox();
            }
            return Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  DateFormat("dd MMM").format(_fDay.date!),
                  style: Theme.of(context).textTheme.titleLarge!.copyWith(
                      fontSize: 18,
                      fontWeight: FontWeight.w500,
                      color: Colors.white),
                ),
                Text(
                  DateFormat("EEE").format(_fDay.date!),
                  style: Theme.of(context).textTheme.titleLarge!.copyWith(
                      fontSize: 18,
                      fontWeight: FontWeight.w500,
                      color: Colors.white),
                ),
                Image.network(
                  "https:${_fDay.day!.condition!.icon}",
                  height: 40,
                  width: 40,
                ),
                Text(
                  "${_fDay.day!.mintempC}° / ${_fDay.day!.maxtempC}°",
                  style: Theme.of(context).textTheme.titleLarge!.copyWith(
                      fontSize: 18,
                      fontWeight: FontWeight.w500,
                      color: Colors.white),
                ),
              ],
            );
          }),
    );
  }

  Widget _alertWidget() {
    return CarouselSlider(
      options: CarouselOptions(
        height: 40,
        aspectRatio: 16 / 9,
        viewportFraction: 1,
        initialPage: 0,
        enableInfiniteScroll: true,
        reverse: false,
        autoPlay: true,
        autoPlayInterval: const Duration(seconds: 10),
        autoPlayAnimationDuration: const Duration(milliseconds: 800),
        autoPlayCurve: Curves.linear,
        enlargeCenterPage: true,
        enlargeFactor: 0,
        scrollDirection: Axis.horizontal,
      ),
      items: alertList.map((item) {
        return Builder(
          builder: (BuildContext context) {
            return InkWell(
              onTap: () {
                _showAlertsDetailsDialog(context, item);
              },
              child: Container(
                  width: MediaQuery.of(context).size.width,
                  padding: const EdgeInsets.symmetric(
                      horizontal: 5.0, vertical: 5.0),
                  margin: const EdgeInsets.symmetric(vertical: 5.0),
                  alignment: Alignment.center,
                  decoration: const BoxDecoration(color: Colors.white70),
                  child: Wrap(
                    alignment: WrapAlignment.center,
                    children: [
                      const Icon(
                        Icons.crisis_alert_outlined,
                        color: Colors.red,
                      ),
                      Text(
                        item.headline!,
                        style: const TextStyle(fontSize: 16.0),
                      ),
                    ],
                  )),
            );
          },
        );
      }).toList(),
    );
  }

  Future<void> _showAlertsDetailsDialog(context, Alert alert) async {
    String fromDate = DateFormat("dd MMM hh:mm a").format(alert.effective!);
    String toDate = DateFormat("dd MMM hh:mm a").format(alert.expires!);
    return showDialog<void>(
      context: context,
      barrierDismissible: true,
      builder: (BuildContext context) {
        return AlertDialog(
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
          title: const Icon(
            Icons.crisis_alert_rounded,
            color: Colors.red,
            size: 40,
          ),
          contentPadding:
              const EdgeInsets.symmetric(horizontal: 3.0, vertical: 3.0),
          content: SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Text(
                    alert.headline!,
                    textAlign: TextAlign.center,
                    style: Theme.of(context).textTheme.titleLarge,
                  ),
                  const SizedBox(height: 10.0),
                  Text(
                    "Alert Duration",
                    style: Theme.of(context).textTheme.bodyLarge,
                  ),
                  const SizedBox(height: 5.0),
                  Text(
                    "$fromDate - $toDate",
                    style: Theme.of(context).textTheme.bodyMedium,
                  ),
                  const SizedBox(height: 20.0),
                  Text(
                    "${alert.desc}",
                    textAlign: TextAlign.center,
                    style: Theme.of(context).textTheme.bodyMedium,
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
