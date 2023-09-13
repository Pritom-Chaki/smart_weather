import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../../api/weather/weather_api.dart';
import '../../models/local_task_model.dart';
import '../../models/weather_future_model.dart';

class TaskDetailsPage extends StatefulWidget {
  final LocalTaskModel task;
  const TaskDetailsPage({Key? key, required this.task}) : super(key: key);

  @override
  State<TaskDetailsPage> createState() => _TaskDetailsPageState();
}

class _TaskDetailsPageState extends State<TaskDetailsPage> {
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
            widget.task.location,
            DateFormat("yyyy-MM-dd").format(
              widget.task.date,
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
      body: SingleChildScrollView(
        child: Column(
          children: [
            _taskCard(),
            _weatherWidget(),
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
              widget.task.task,
              textAlign: TextAlign.center,
              style: Theme.of(context).textTheme.titleLarge,
            ),
            Text(
              widget.task.details,
              textAlign: TextAlign.center,
              style: Theme.of(context).textTheme.titleMedium,
            ),
            Row(
              children: [
                const SizedBox(
                  width: 8.0,
                ),
                const Icon(
                  Icons.calendar_month_outlined,
                  color: Colors.blue,
                ),
                Text(
                  DateFormat("dd MMM yyyy").format(
                    widget.task.date,
                  ),
                  style: Theme.of(context).textTheme.titleSmall!.copyWith(
                        fontWeight: FontWeight.w500,
                      ),
                ),
                const Spacer(),
                const Icon(
                  Icons.location_on,
                  color: Colors.red,
                ),
                Text(
                  widget.task.location,
                  style: Theme.of(context).textTheme.titleSmall!.copyWith(
                        fontWeight: FontWeight.w500,
                      ),
                ),
                const SizedBox(
                  width: 8.0,
                ),
              ],
            )
          ],
        ),
      ),
    );
  }

  Widget _weatherWidget() {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 10.0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Image.network(
                  "https://cdn.weatherapi.com/weather/64x64/day/356.png"),
              Column(
                children: [
                  Text(
                    "33°C",
                    style: Theme.of(context)
                        .textTheme
                        .titleLarge!
                        .copyWith(fontSize: 40, color: _textColor),
                    textAlign: TextAlign.start,
                  ),
                  Text(
                    "Haze",
                    style: Theme.of(context).textTheme.titleLarge!,
                  ),
                ],
              )
            ],
          ),
          Text(
            "33 / 38",
            textAlign: TextAlign.end,
            style: Theme.of(context).textTheme.titleLarge!,
          ),
          Container(
            height: 100,
            color: Colors.red,
            alignment: Alignment.center,
            child: ListView.builder(
                itemCount: 10,
                scrollDirection: Axis.horizontal,
                itemBuilder: (c, i) {
                  return Container(
                    color: Colors.green,
                    alignment: Alignment.center,
                    margin: const EdgeInsets.symmetric(horizontal: 5.0, vertical: 3.0),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Text("18:00", style: Theme.of(context).textTheme.bodyMedium!.copyWith(fontWeight: FontWeight.w500),),
                        Image.network(
                            "https://cdn.weatherapi.com/weather/64x64/day/356.png", height: 40, width: 40,),
                        Text("30°C", style: Theme.of(context).textTheme.bodyMedium!.copyWith(fontWeight: FontWeight.w500),),
                      ],
                    ),
                  );
                }),
          ),
        ],
      ),
    );
  }
}
