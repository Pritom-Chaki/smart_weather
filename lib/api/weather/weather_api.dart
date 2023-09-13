import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;

import '../../models/weather_forecast_model.dart';
import '../../models/weather_future_model.dart';
import '../../models/weather_search_model.dart';
import '../api_constant.dart';

class WeatherApi {
  // Weather Forecast api
  Future<WeatherForecastModel?> getForecastDataApi(String location) async {
    try {
      var headers = {
        ApiConstant.accept: ApiConstant.acceptValue,
      };
      var request = http.Request(
          'GET',
          Uri.parse(
              '${ApiConstant.baseUrl}/forecast.json?key=${ApiConstant.key}&q=$location&aqi=yes&days=5&alerts=yes'));

      request.headers.addAll(headers);

      http.StreamedResponse response = await request.send();

      var str = await response.stream.bytesToString();
      debugPrint("Location ==== $str");
      if (response.statusCode == 200) {
        return WeatherForecastModel.fromJson(str);
      } else {
        return null;
      }
    } catch (e) {
      debugPrint("Error: $e");
    }
    return null;
  }

  Future<List<WeatherSearchModel>> getSearchApi(String location) async {
    try {
      var headers = {
        ApiConstant.accept: ApiConstant.acceptValue,
      };
      var request = http.Request(
          'GET',
          Uri.parse(
              '${ApiConstant.baseUrl}/search.json?key=${ApiConstant.key}&q=$location'));

      request.headers.addAll(headers);

      http.StreamedResponse response = await request.send();

      var str = await response.stream.bytesToString();
      debugPrint("Location Search==== $str");

      List<WeatherSearchModel> prodList = [];

      if (response.statusCode == 200) {
        var jsonList = jsonDecode(str);
        for (var prod in jsonList) {
          prodList.add(WeatherSearchModel.fromJson(prod));
        }
        return prodList;
      } else {
        return [];
      }
    } catch (e) {
      debugPrint("Error: $e");
    }
    return [];
  }

  Future<WeatherFutureModel?> getForecastFutureApi(
      String location, String date) async {

    try {
      var headers = {
        ApiConstant.accept: ApiConstant.acceptValue,
      };
      var request = http.Request(
          'GET',
          Uri.parse(
              '${ApiConstant.baseUrl}/forecast.json?key=${ApiConstant.key}&q=$location&dt=$date'));

      request.headers.addAll(headers);

      http.StreamedResponse response = await request.send();

      var str = await response.stream.bytesToString();
      debugPrint("Location Future ==== $str");
      if (response.statusCode == 200) {
        return WeatherFutureModel.fromJson(str);
      } else {
        return null;
      }
    } catch (e) {
      debugPrint("Error: $e");
    }
    return null;
  }
}
