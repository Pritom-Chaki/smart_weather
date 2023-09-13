import 'dart:convert';

class WeatherForecastModel {
  final Location? location;
  final Current? current;
  final Forecast? forecast;
  final Alerts? alerts;

  WeatherForecastModel({
    this.location,
    this.current,
    this.forecast,
    this.alerts,
  });

  factory WeatherForecastModel.fromJson(String str) => WeatherForecastModel.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory WeatherForecastModel.fromMap(Map<String, dynamic> json) => WeatherForecastModel(
    location: json["location"] == null ? null : Location.fromMap(json["location"]),
    current: json["current"] == null ? null : Current.fromMap(json["current"]),
    forecast: json["forecast"] == null ? null : Forecast.fromMap(json["forecast"]),
    alerts: json["alerts"] == null ? null : Alerts.fromMap(json["alerts"]),
  );

  Map<String, dynamic> toMap() => {
    "location": location?.toMap(),
    "current": current?.toMap(),
    "forecast": forecast?.toMap(),
    "alerts": alerts?.toMap(),
  };
}

class Alerts {
  final List<Alert>? alert;

  Alerts({
    this.alert,
  });

  factory Alerts.fromJson(String str) => Alerts.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory Alerts.fromMap(Map<String, dynamic> json) => Alerts(
    alert: json["alert"] == null ? [] : List<Alert>.from(json["alert"]!.map((x) => Alert.fromMap(x))),
  );

  Map<String, dynamic> toMap() => {
    "alert": alert == null ? [] : List<dynamic>.from(alert!.map((x) => x.toMap())),
  };
}

class Alert {
  final String? headline;
  final String? msgtype;
  final String? severity;
  final String? urgency;
  final String? areas;
  final String? category;
  final String? certainty;
  final String? event;
  final String? note;
  final DateTime? effective;
  final DateTime? expires;
  final String? desc;
  final String? instruction;

  Alert({
    this.headline,
    this.msgtype,
    this.severity,
    this.urgency,
    this.areas,
    this.category,
    this.certainty,
    this.event,
    this.note,
    this.effective,
    this.expires,
    this.desc,
    this.instruction,
  });

  factory Alert.fromJson(String str) => Alert.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory Alert.fromMap(Map<String, dynamic> json) => Alert(
    headline: json["headline"],
    msgtype: json["msgtype"],
    severity: json["severity"],
    urgency: json["urgency"],
    areas: json["areas"],
    category: json["category"],
    certainty: json["certainty"],
    event: json["event"],
    note: json["note"],
    effective: json["effective"] == null ? null : DateTime.parse(json["effective"]),
    expires: json["expires"] == null ? null : DateTime.parse(json["expires"]),
    desc: json["desc"],
    instruction: json["instruction"],
  );

  Map<String, dynamic> toMap() => {
    "headline": headline,
    "msgtype": msgtype,
    "severity": severity,
    "urgency": urgency,
    "areas": areas,
    "category": category,
    "certainty": certainty,
    "event": event,
    "note": note,
    "effective": effective?.toIso8601String(),
    "expires": expires?.toIso8601String(),
    "desc": desc,
    "instruction": instruction,
  };
}

class Current {
  final dynamic lastUpdatedEpoch;
  final String? lastUpdated;
  final dynamic tempC;
  final double? tempF;
  final dynamic isDay;
  final Condition? condition;
  final double? windMph;
  final double? windKph;
  final dynamic windDegree;
  final String? windDir;
  final dynamic pressureMb;
  final double? pressureIn;
  final dynamic precipMm;
  final dynamic precipIn;
  final dynamic humidity;
  final dynamic cloud;
  final double? feelslikeC;
  final double? feelslikeF;
  final dynamic visKm;
  final dynamic visMiles;
  final dynamic uv;
  final double? gustMph;
  final double? gustKph;
  final AirQuality? airQuality;

  Current({
    this.lastUpdatedEpoch,
    this.lastUpdated,
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
    this.visKm,
    this.visMiles,
    this.uv,
    this.gustMph,
    this.gustKph,
    this.airQuality,
  });

  factory Current.fromJson(String str) => Current.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory Current.fromMap(Map<String, dynamic> json) => Current(
    lastUpdatedEpoch: json["last_updated_epoch"],
    lastUpdated: json["last_updated"],
    tempC: json["temp_c"],
    tempF: json["temp_f"]?.toDouble(),
    isDay: json["is_day"],
    condition: json["condition"] == null ? null : Condition.fromMap(json["condition"]),
    windMph: json["wind_mph"]?.toDouble(),
    windKph: json["wind_kph"]?.toDouble(),
    windDegree: json["wind_degree"],
    windDir: json["wind_dir"],
    pressureMb: json["pressure_mb"],
    pressureIn: json["pressure_in"]?.toDouble(),
    precipMm: json["precip_mm"],
    precipIn: json["precip_in"],
    humidity: json["humidity"],
    cloud: json["cloud"],
    feelslikeC: json["feelslike_c"]?.toDouble(),
    feelslikeF: json["feelslike_f"]?.toDouble(),
    visKm: json["vis_km"],
    visMiles: json["vis_miles"],
    uv: json["uv"],
    gustMph: json["gust_mph"]?.toDouble(),
    gustKph: json["gust_kph"]?.toDouble(),
    airQuality: json["air_quality"] == null ? null : AirQuality.fromMap(json["air_quality"]),
  );

  Map<String, dynamic> toMap() => {
    "last_updated_epoch": lastUpdatedEpoch,
    "last_updated": lastUpdated,
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
    "vis_km": visKm,
    "vis_miles": visMiles,
    "uv": uv,
    "gust_mph": gustMph,
    "gust_kph": gustKph,
    "air_quality": airQuality?.toMap(),
  };
}

class AirQuality {
  final double? co;
  final double? no2;
  final double? o3;
  final double? so2;
  final double? pm25;
  final double? pm10;
  final dynamic usEpaIndex;
  final dynamic gbDefraIndex;
  final String? aqiData;

  AirQuality({
    this.co,
    this.no2,
    this.o3,
    this.so2,
    this.pm25,
    this.pm10,
    this.usEpaIndex,
    this.gbDefraIndex,
    this.aqiData,
  });

  factory AirQuality.fromJson(String str) => AirQuality.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory AirQuality.fromMap(Map<String, dynamic> json) => AirQuality(
    co: json["co"]?.toDouble(),
    no2: json["no2"]?.toDouble(),
    o3: json["o3"]?.toDouble(),
    so2: json["so2"]?.toDouble(),
    pm25: json["pm2_5"]?.toDouble(),
    pm10: json["pm10"]?.toDouble(),
    usEpaIndex: json["us-epa-index"],
    gbDefraIndex: json["gb-defra-index"],
    aqiData: json["aqi_data"],
  );

  Map<String, dynamic> toMap() => {
    "co": co,
    "no2": no2,
    "o3": o3,
    "so2": so2,
    "pm2_5": pm25,
    "pm10": pm10,
    "us-epa-index": usEpaIndex,
    "gb-defra-index": gbDefraIndex,
    "aqi_data": aqiData,
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
  final dynamic isMoonUp;
  final dynamic isSunUp;

  Astro({
    this.sunrise,
    this.sunset,
    this.moonrise,
    this.moonset,
    this.moonPhase,
    this.moonIllumination,
    this.isMoonUp,
    this.isSunUp,
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
    isMoonUp: json["is_moon_up"],
    isSunUp: json["is_sun_up"],
  );

  Map<String, dynamic> toMap() => {
    "sunrise": sunrise,
    "sunset": sunset,
    "moonrise": moonrise,
    "moonset": moonset,
    "moon_phase": moonPhase,
    "moon_illumination": moonIllumination,
    "is_moon_up": isMoonUp,
    "is_sun_up": isSunUp,
  };
}

class Day {
  final double? maxtempC;
  final double? maxtempF;
  final double? mintempC;
  final double? mintempF;
  final double? avgtempC;
  final double? avgtempF;
  final double? maxwindMph;
  final double? maxwindKph;
  final dynamic totalprecipMm;
  final dynamic totalprecipIn;
  final dynamic totalsnowCm;
  final dynamic avgvisKm;
  final dynamic avgvisMiles;
  final dynamic avghumidity;
  final dynamic dailyWillItRain;
  final dynamic dailyChanceOfRain;
  final dynamic dailyWillItSnow;
  final dynamic dailyChanceOfSnow;
  final Condition? condition;
  final dynamic uv;
  final AirQuality? airQuality;

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
    this.totalsnowCm,
    this.avgvisKm,
    this.avgvisMiles,
    this.avghumidity,
    this.dailyWillItRain,
    this.dailyChanceOfRain,
    this.dailyWillItSnow,
    this.dailyChanceOfSnow,
    this.condition,
    this.uv,
    this.airQuality,
  });

  factory Day.fromJson(String str) => Day.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory Day.fromMap(Map<String, dynamic> json) => Day(
    maxtempC: json["maxtemp_c"]?.toDouble(),
    maxtempF: json["maxtemp_f"]?.toDouble(),
    mintempC: json["mintemp_c"]?.toDouble(),
    mintempF: json["mintemp_f"]?.toDouble(),
    avgtempC: json["avgtemp_c"]?.toDouble(),
    avgtempF: json["avgtemp_f"]?.toDouble(),
    maxwindMph: json["maxwind_mph"]?.toDouble(),
    maxwindKph: json["maxwind_kph"]?.toDouble(),
    totalprecipMm: json["totalprecip_mm"],
    totalprecipIn: json["totalprecip_in"],
    totalsnowCm: json["totalsnow_cm"],
    avgvisKm: json["avgvis_km"],
    avgvisMiles: json["avgvis_miles"],
    avghumidity: json["avghumidity"],
    dailyWillItRain: json["daily_will_it_rain"],
    dailyChanceOfRain: json["daily_chance_of_rain"],
    dailyWillItSnow: json["daily_will_it_snow"],
    dailyChanceOfSnow: json["daily_chance_of_snow"],
    condition: json["condition"] == null ? null : Condition.fromMap(json["condition"]),
    uv: json["uv"],
    airQuality: json["air_quality"] == null ? null : AirQuality.fromMap(json["air_quality"]),
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
    "totalsnow_cm": totalsnowCm,
    "avgvis_km": avgvisKm,
    "avgvis_miles": avgvisMiles,
    "avghumidity": avghumidity,
    "daily_will_it_rain": dailyWillItRain,
    "daily_chance_of_rain": dailyChanceOfRain,
    "daily_will_it_snow": dailyWillItSnow,
    "daily_chance_of_snow": dailyChanceOfSnow,
    "condition": condition?.toMap(),
    "uv": uv,
    "air_quality": airQuality?.toMap(),
  };
}

class Hour {
  final dynamic timeEpoch;
  final String? time;
  final double? tempC;
  final double? tempF;
  final dynamic isDay;
  final Condition? condition;
  final double? windMph;
  final double? windKph;
  final dynamic windDegree;
  final String? windDir;
  final dynamic pressureMb;
  final double? pressureIn;
  final dynamic precipMm;
  final dynamic precipIn;
  final dynamic humidity;
  final dynamic cloud;
  final double? feelslikeC;
  final double? feelslikeF;
  final double? windchillC;
  final double? windchillF;
  final double? heatindexC;
  final double? heatindexF;
  final double? dewpointC;
  final double? dewpointF;
  final dynamic willItRain;
  final dynamic chanceOfRain;
  final dynamic willItSnow;
  final dynamic chanceOfSnow;
  final dynamic visKm;
  final dynamic visMiles;
  final double? gustMph;
  final double? gustKph;
  final dynamic uv;
  final AirQuality? airQuality;

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
    this.uv,
    this.airQuality,
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
    precipMm: json["precip_mm"],
    precipIn: json["precip_in"],
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
    visKm: json["vis_km"],
    visMiles: json["vis_miles"],
    gustMph: json["gust_mph"]?.toDouble(),
    gustKph: json["gust_kph"]?.toDouble(),
    uv: json["uv"],
    airQuality: json["air_quality"] == null ? null : AirQuality.fromMap(json["air_quality"]),
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
    "uv": uv,
    "air_quality": airQuality?.toMap(),
  };
}

class Location {
  final String? name;
  final String? region;
  final String? country;
  final double? lat;
  final double? lon;
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
