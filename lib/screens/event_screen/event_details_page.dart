import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:intl/intl.dart';
import 'package:manage_calendar_events/manage_calendar_events.dart';

import '../../api/weather/weather_api.dart';

import '../../models/weather_future_model.dart';

class EventDetailsPage extends StatefulWidget {
  final CalendarEvent activeEvent;
  final CalendarPlugin calendarPlugin;
  const EventDetailsPage(
      {Key? key, required this.activeEvent, required this.calendarPlugin})
      : super(key: key);

  @override
  State<EventDetailsPage> createState() => _EventDetailsPageState();
}

class _EventDetailsPageState extends State<EventDetailsPage> {
  WeatherFutureModel? _weatherData;
  final Color _textColor = Colors.black87;
  @override
  void initState() {
    _getWeatherData();
    super.initState();
  }

  _getWeatherData() {
    WeatherApi()
        .getForecastFutureApi(
            widget.activeEvent.location!,
            DateFormat("yyyy-MM-dd").format(
              widget.activeEvent.startDate!,
            ))
        .then((value) {
      if (value != null) {
        setState(() {
          _weatherData = value;
        });
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Event Details"),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            _taskCard(),
            _weatherData != null ? _weatherWidget() :  Container(
                height: 100,
                alignment: Alignment.center,

                child: const Text("Location Not Found")),
          ],
        ),
      ),
    );
  }

  Widget _taskCard() {
    return Card(
      margin: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 5.0),
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: [
            Text(
              widget.activeEvent.title!,
              textAlign: TextAlign.center,
              style: Theme.of(context).textTheme.titleLarge,
            ),
            Text(
              widget.activeEvent.description!,
              textAlign: TextAlign.center,
              style: Theme.of(context).textTheme.titleMedium,
            ),
            Row(
              children: [
                const SizedBox(width: 8.0),
                const Icon(
                  Icons.calendar_month_outlined,
                  color: Colors.blue,
                ),
                Text(
                  DateFormat("dd MMM yyyy").format(
                    widget.activeEvent.startDate!,
                  ),
                  style: Theme.of(context).textTheme.titleSmall!.copyWith(
                        fontWeight: FontWeight.w500,
                      ),
                ),
                const Spacer(),
                const Icon(
                  Icons.calendar_month_outlined,
                  color: Colors.red,
                ),
                Text(
                  DateFormat("dd MMM yyyy").format(
                    widget.activeEvent.endDate!,
                  ),
                  style: Theme.of(context).textTheme.titleSmall!.copyWith(
                        fontWeight: FontWeight.w500,
                      ),
                ),
                const SizedBox(width: 8.0),
              ],
            ),
            const SizedBox(height: 5.0),
            Row(
              children: [
                const SizedBox(width: 8.0),
                const Icon(
                  Icons.location_on,
                  color: Colors.red,
                ),
                Text(
                  widget.activeEvent.location!.isNotEmpty ?  widget.activeEvent.location! : 'N/A',
                  style: Theme.of(context)
                      .textTheme
                      .titleSmall!
                      .copyWith(fontWeight: FontWeight.w500, fontSize: 16),
                ),
                const Spacer(),

                Text(
                  widget.activeEvent.isAllDay !=null ? 'All Day Event' : '',
                  style: Theme.of(context)
                      .textTheme
                      .titleSmall!
                      .copyWith(fontWeight: FontWeight.w500, fontSize: 16),
                ),
                const SizedBox(width: 8.0),
              ],
            ),
            const SizedBox(height: 5.0),
            Row(
              children: [
                const SizedBox(width: 8.0),
                const Icon(
                  Icons.notifications_active,
                  color: Colors.blue,
                ),
                const SizedBox(
                  width: 5.0,
                ),
                Text(
                  widget.activeEvent.hasAlarm.toString(),
                  style: Theme.of(context)
                      .textTheme
                      .titleSmall!
                      .copyWith(fontWeight: FontWeight.w500, fontSize: 16),
                ),
                const Spacer(),
                const Icon(
                  Icons.alarm_on,
                  color: Colors.green,
                ),
                const SizedBox(
                  width: 5.0,
                ),
                Text(
                  "${widget.activeEvent.reminder?.minutes ?? 'N/A'}",
                  style: Theme.of(context)
                      .textTheme
                      .titleSmall!
                      .copyWith(fontWeight: FontWeight.w500, fontSize: 16),
                ),
                const SizedBox(width: 8.0),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _weatherWidget() {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 10.0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  CachedNetworkImage(
                      imageUrl:
                          "https:${_weatherData!.forecast!.forecastday![0].day!.condition!.icon}"),
                  Text(
                    "${_weatherData!.forecast!.forecastday![0].day!.avgtempC}°C",
                    style: Theme.of(context)
                        .textTheme
                        .titleLarge!
                        .copyWith(fontSize: 40, color: _textColor),
                    textAlign: TextAlign.start,
                  ),
                ],
              ),
              Text(
                "${_weatherData!.forecast!.forecastday![0].day!.condition!.text}",
                style: Theme.of(context).textTheme.titleLarge!,
              ),
            ],
          ),
          Text(
            "${_weatherData!.forecast!.forecastday![0].day!.mintempC}°C / ${_weatherData!.forecast!.forecastday![0].day!.maxtempC}°C",
            textAlign: TextAlign.end,
            style: Theme.of(context).textTheme.titleLarge!,
          ),
          Container(
            height: 100,
            // color: Colors.red,
            alignment: Alignment.center,
            child: ListView.builder(
                itemCount: _weatherData!.forecast!.forecastday![0].hour!.length,
                scrollDirection: Axis.horizontal,
                itemBuilder: (c, i) {
                  Hour _hourData =
                      _weatherData!.forecast!.forecastday![0].hour![i];
                  return Container(
                    color: Colors.grey.shade200,
                    alignment: Alignment.center,
                    margin: const EdgeInsets.symmetric(
                        horizontal: 5.0, vertical: 3.0),
                    padding: const EdgeInsets.symmetric(
                        horizontal: 5.0, vertical: 3.0),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Text(
                          DateFormat("hh:mm a").format(
                            DateTime.parse(_hourData.time!),
                          ),
                          style: Theme.of(context)
                              .textTheme
                              .bodyMedium!
                              .copyWith(fontWeight: FontWeight.w500),
                        ),
                        CachedNetworkImage(
                          imageUrl: "https:${_hourData.condition!.icon}",
                          height: 40,
                          width: 40,
                        ),
                        Text(
                          "${_hourData.tempC}°C",
                          style: Theme.of(context)
                              .textTheme
                              .bodyMedium!
                              .copyWith(fontWeight: FontWeight.w500),
                        ),
                      ],
                    ),
                  );
                }),
          ),
          Card(
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: SizedBox(
                height: 120,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        _svgInfoWidget(
                            "${_weatherData!.forecast!.forecastday![0].day!.totalprecipMm} mm",
                            "assets/icons/rain.svg",
                            40),
                        _svgInfoWidget(
                            "${_weatherData!.forecast!.forecastday![0].day!.maxwindKph} km/h",
                            "assets/icons/win_speed.svg",
                            35),
                        _svgInfoWidget(
                            "${_weatherData!.forecast!.forecastday![0].day!.avghumidity} %",
                            "assets/icons/humidity.svg",
                            35),
                        _svgInfoWidget(
                            "${_weatherData!.forecast!.forecastday![0].day!.avgvisKm} km",
                            "assets/icons/visual.svg",
                            35),
                      ],
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        _svgInfoWidget(
                            "${_weatherData!.forecast!.forecastday![0].astro!.sunrise}",
                            "assets/icons/sun_rise.svg",
                            35),
                        _svgInfoWidget(
                            "${_weatherData!.forecast!.forecastday![0].astro!.sunset}",
                            "assets/icons/sun_set.svg",
                            35),
                        _svgInfoWidget(
                            "${_weatherData!.forecast!.forecastday![0].astro!.moonrise}",
                            "assets/icons/moon_rise.svg",
                            35),
                        _svgInfoWidget(
                            "${_weatherData!.forecast!.forecastday![0].astro!.moonset}",
                            "assets/icons/moon_set.svg",
                            35),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          )
        ],
      ),
    );
  }

  Widget _svgInfoWidget(String text, String svgLink, double size) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        SvgPicture.asset(
          svgLink,
          height: size,
          width: size,
          colorFilter: const ColorFilter.mode(Colors.blue, BlendMode.srcIn),
        ),
        Text(text),
      ],
    );
  }
}
