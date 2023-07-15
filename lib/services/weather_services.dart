import 'dart:convert';

import 'package:http/http.dart' as http ;
import 'package:weather_app/models/weather_model.dart';
class WeatherService
{
  Future<WeatherModel?> getweather({ required String cityName}) async
  {
    WeatherModel? weather ;
    try{
      String baseUrl ='http://api.weatherapi.com/v1';
      String apiKey ='776937ebe991413c8fe214855231107';
      Uri url = Uri.parse(
          '$baseUrl/forecast.json?key=$apiKey&q=$cityName&days=1');
      http.Response response =await http.get(url);
      Map <String , dynamic> data =jsonDecode(response.body);

      // return data from api
       weather=WeatherModel.fromJson(data);

  } catch(e){
      print(e);
    }
    return weather ;
  }
}