import 'dart:convert';

class WeatherFutureModel {
  final Location? location;
  final Forecast? forecast;

  WeatherFutureModel({
    this.location,
    this.forecast,
  });

  factory WeatherFutureModel.fromJson(String str) => WeatherFutureModel.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory WeatherFutureModel.fromMap(Map<String, dynamic> json) => WeatherFutureModel(
    location: json["location"] == null ? null : Location.fromMap(json["location"]),
    forecast: json["forecast"] == null ? null : Forecast.fromMap(json["forecast"]),
  );

  Map<String, dynamic> toMap() => {
    "location": location?.toMap(),
    "forecast": forecast?.toMap(),
  };
}

class Forecast {
  final List<Forecastday>? forecastday;

  Forecast({
    this.forecastday,
  });

  factory Forecast.fromJson(String str) => Forecast.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory Forecast.fromMap(Map<String, dynamic> json) => Forecast(
    forecastday: json["forecastday"] == null ? [] : List<Forecastday>.from(json["forecastday"]!.map((x) => Forecastday.fromMap(x))),
  );

  Map<String, dynamic> toMap() => {
    "forecastday": forecastday == null ? [] : List<dynamic>.from(forecastday!.map((x) => x.toMap())),
  };
}

class Forecastday {
  final DateTime? date;
  final dynamic dateEpoch;
  final Day? day;
  final Astro? astro;
  final List<Hour>? hour;

  Forecastday({
    this.date,
    this.dateEpoch,
    this.day,
    this.astro,
    this.hour,
  });

  factory Forecastday.fromJson(String str) => Forecastday.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory Forecastday.fromMap(Map<String, dynamic> json) => Forecastday(
    date: json["date"] == null ? null : DateTime.parse(json["date"]),
    dateEpoch: json["date_epoch"],
    day: json["day"] == null ? null : Day.fromMap(json["day"]),
    astro: json["astro"] == null ? null : Astro.fromMap(json["astro"]),
    hour: json["hour"] == null ? [] : List<Hour>.from(json["hour"]!.map((x) => Hour.fromMap(x))),
  );

  Map<String, dynamic> toMap() => {
    "date": "${date!.year.toString().padLeft(4, '0')}-${date!.month.toString().padLeft(2, '0')}-${date!.day.toString().padLeft(2, '0')}",
    "date_epoch": dateEpoch,
    "day": day?.toMap(),
    "astro": astro?.toMap(),
    "hour": hour == null ? [] : List<dynamic>.from(hour!.map((x) => x.toMap())),
  };
}

class Astro {
  final String? sunrise;
  final String? sunset;
  final String? moonrise;
  final String? moonset;
  final String? moonPhase;
  final String? moonIllumination;

  Astro({
    this.sunrise,
    this.sunset,
    this.moonrise,
    this.moonset,
    this.moonPhase,
    this.moonIllumination,
  });

  factory Astro.fromJson(String str) => Astro.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory Astro.fromMap(Map<String, dynamic> json) => Astro(
    sunrise: json["sunrise"],
    sunset: json["sunset"],
    moonrise: json["moonrise"],
    moonset: json["moonset"],
    moonPhase: json["moon_phase"],
    moonIllumination: json["moon_illumination"],
  );

  Map<String, dynamic> toMap() => {
    "sunrise": sunrise,
    "sunset": sunset,
    "moonrise": moonrise,
    "moonset": moonset,
    "moon_phase": moonPhase,
    "moon_illumination": moonIllumination,
  };
}

class Day {
  final dynamic maxtempC;
  final dynamic maxtempF;
  final dynamic mintempC;
  final dynamic mintempF;
  final dynamic avgtempC;
  final dynamic avgtempF;
  final dynamic maxwindMph;
  final dynamic maxwindKph;
  final dynamic totalprecipMm;
  final dynamic totalprecipIn;
  final dynamic avgvisKm;
  final dynamic avgvisMiles;
  final dynamic avghumidity;
  final Condition? condition;
  final dynamic uv;

  Day({
    this.maxtempC,
    this.maxtempF,
    this.mintempC,
    this.mintempF,
    this.avgtempC,
    this.avgtempF,
    this.maxwindMph,
    this.maxwindKph,
    this.totalprecipMm,
    this.totalprecipIn,
    this.avgvisKm,
    this.avgvisMiles,
    this.avghumidity,
    this.condition,
    this.uv,
  });

  factory Day.fromJson(String str) => Day.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory Day.fromMap(Map<String, dynamic> json) => Day(
    maxtempC: json["maxtemp_c"]?.toDouble(),
    maxtempF: json["maxtemp_f"]?.toDouble(),
    mintempC: json["mintemp_c"],
    mintempF: json["mintemp_f"],
    avgtempC: json["avgtemp_c"]?.toDouble(),
    avgtempF: json["avgtemp_f"]?.toDouble(),
    maxwindMph: json["maxwind_mph"]?.toDouble(),
    maxwindKph: json["maxwind_kph"]?.toDouble(),
    totalprecipMm: json["totalprecip_mm"]?.toDouble(),
    totalprecipIn: json["totalprecip_in"]?.toDouble(),
    avgvisKm: json["avgvis_km"]?.toDouble(),
    avgvisMiles: json["avgvis_miles"],
    avghumidity: json["avghumidity"],
    condition: json["condition"] == null ? null : Condition.fromMap(json["condition"]),
    uv: json["uv"],
  );

  Map<String, dynamic> toMap() => {
    "maxtemp_c": maxtempC,
    "maxtemp_f": maxtempF,
    "mintemp_c": mintempC,
    "mintemp_f": mintempF,
    "avgtemp_c": avgtempC,
    "avgtemp_f": avgtempF,
    "maxwind_mph": maxwindMph,
    "maxwind_kph": maxwindKph,
    "totalprecip_mm": totalprecipMm,
    "totalprecip_in": totalprecipIn,
    "avgvis_km": avgvisKm,
    "avgvis_miles": avgvisMiles,
    "avghumidity": avghumidity,
    "condition": condition?.toMap(),
    "uv": uv,
  };
}

class Condition {
  final String? text;
  final String? icon;
  final dynamic code;

  Condition({
    this.text,
    this.icon,
    this.code,
  });

  factory Condition.fromJson(String str) => Condition.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory Condition.fromMap(Map<String, dynamic> json) => Condition(
    text: json["text"],
    icon: json["icon"],
    code: json["code"],
  );

  Map<String, dynamic> toMap() => {
    "text": text,
    "icon": icon,
    "code": code,
  };
}

class Hour {
  final dynamic timeEpoch;
  final String? time;
  final dynamic tempC;
  final dynamic tempF;
  final dynamic isDay;
  final Condition? condition;
  final dynamic windMph;
  final dynamic windKph;
  final dynamic windDegree;
  final String? windDir;
  final dynamic pressureMb;
  final dynamic pressureIn;
  final dynamic precipMm;
  final dynamic precipIn;
  final dynamic humidity;
  final dynamic cloud;
  final dynamic feelslikeC;
  final dynamic feelslikeF;
  final dynamic windchillC;
  final dynamic windchillF;
  final dynamic heatindexC;
  final dynamic heatindexF;
  final dynamic dewpointC;
  final dynamic dewpointF;
  final dynamic willItRain;
  final dynamic chanceOfRain;
  final dynamic willItSnow;
  final dynamic chanceOfSnow;
  final dynamic visKm;
  final dynamic visMiles;
  final dynamic gustMph;
  final dynamic gustKph;

  Hour({
    this.timeEpoch,
    this.time,
    this.tempC,
    this.tempF,
    this.isDay,
    this.condition,
    this.windMph,
    this.windKph,
    this.windDegree,
    this.windDir,
    this.pressureMb,
    this.pressureIn,
    this.precipMm,
    this.precipIn,
    this.humidity,
    this.cloud,
    this.feelslikeC,
    this.feelslikeF,
    this.windchillC,
    this.windchillF,
    this.heatindexC,
    this.heatindexF,
    this.dewpointC,
    this.dewpointF,
    this.willItRain,
    this.chanceOfRain,
    this.willItSnow,
    this.chanceOfSnow,
    this.visKm,
    this.visMiles,
    this.gustMph,
    this.gustKph,
  });

  factory Hour.fromJson(String str) => Hour.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory Hour.fromMap(Map<String, dynamic> json) => Hour(
    timeEpoch: json["time_epoch"],
    time: json["time"],
    tempC: json["temp_c"]?.toDouble(),
    tempF: json["temp_f"]?.toDouble(),
    isDay: json["is_day"],
    condition: json["condition"] == null ? null : Condition.fromMap(json["condition"]),
    windMph: json["wind_mph"]?.toDouble(),
    windKph: json["wind_kph"]?.toDouble(),
    windDegree: json["wind_degree"],
    windDir: json["wind_dir"],
    pressureMb: json["pressure_mb"],
    pressureIn: json["pressure_in"]?.toDouble(),
    precipMm: json["precip_mm"]?.toDouble(),
    precipIn: json["precip_in"]?.toDouble(),
    humidity: json["humidity"],
    cloud: json["cloud"],
    feelslikeC: json["feelslike_c"]?.toDouble(),
    feelslikeF: json["feelslike_f"]?.toDouble(),
    windchillC: json["windchill_c"]?.toDouble(),
    windchillF: json["windchill_f"]?.toDouble(),
    heatindexC: json["heatindex_c"]?.toDouble(),
    heatindexF: json["heatindex_f"]?.toDouble(),
    dewpointC: json["dewpoint_c"]?.toDouble(),
    dewpointF: json["dewpoint_f"]?.toDouble(),
    willItRain: json["will_it_rain"],
    chanceOfRain: json["chance_of_rain"],
    willItSnow: json["will_it_snow"],
    chanceOfSnow: json["chance_of_snow"],
    visKm: json["vis_km"]?.toDouble(),
    visMiles: json["vis_miles"],
    gustMph: json["gust_mph"]?.toDouble(),
    gustKph: json["gust_kph"]?.toDouble(),
  );

  Map<String, dynamic> toMap() => {
    "time_epoch": timeEpoch,
    "time": time,
    "temp_c": tempC,
    "temp_f": tempF,
    "is_day": isDay,
    "condition": condition?.toMap(),
    "wind_mph": windMph,
    "wind_kph": windKph,
    "wind_degree": windDegree,
    "wind_dir": windDir,
    "pressure_mb": pressureMb,
    "pressure_in": pressureIn,
    "precip_mm": precipMm,
    "precip_in": precipIn,
    "humidity": humidity,
    "cloud": cloud,
    "feelslike_c": feelslikeC,
    "feelslike_f": feelslikeF,
    "windchill_c": windchillC,
    "windchill_f": windchillF,
    "heatindex_c": heatindexC,
    "heatindex_f": heatindexF,
    "dewpoint_c": dewpointC,
    "dewpoint_f": dewpointF,
    "will_it_rain": willItRain,
    "chance_of_rain": chanceOfRain,
    "will_it_snow": willItSnow,
    "chance_of_snow": chanceOfSnow,
    "vis_km": visKm,
    "vis_miles": visMiles,
    "gust_mph": gustMph,
    "gust_kph": gustKph,
  };
}

class Location {
  final String? name;
  final String? region;
  final String? country;
  final dynamic lat;
  final dynamic lon;
  final String? tzId;
  final dynamic localtimeEpoch;
  final String? localtime;

  Location({
    this.name,
    this.region,
    this.country,
    this.lat,
    this.lon,
    this.tzId,
    this.localtimeEpoch,
    this.localtime,
  });

  factory Location.fromJson(String str) => Location.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory Location.fromMap(Map<String, dynamic> json) => Location(
    name: json["name"],
    region: json["region"],
    country: json["country"],
    lat: json["lat"]?.toDouble(),
    lon: json["lon"]?.toDouble(),
    tzId: json["tz_id"],
    localtimeEpoch: json["localtime_epoch"],
    localtime: json["localtime"],
  );

  Map<String, dynamic> toMap() => {
    "name": name,
    "region": region,
    "country": country,
    "lat": lat,
    "lon": lon,
    "tz_id": tzId,
    "localtime_epoch": localtimeEpoch,
    "localtime": localtime,
  };
}
