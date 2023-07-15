import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:weather_app/models/weather_model.dart';
import 'package:weather_app/provider/weather_provider.dart';
import 'package:weather_app/services/weather_services.dart';

class SearchPage extends StatelessWidget {
  String? cityName ;
  // SearchPage({this.updateUi});
  // VoidCallback? updateUi ;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Search a City',
        style: TextStyle(
            fontSize: 19,
          fontWeight:FontWeight.w300,

        ),
        ),

      ),
          body: Center(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 13),
              child: TextField(
                onChanged: (data){
                  cityName=data ;
                },
                onSubmitted: (data) async
                {
                  cityName =data;
                  //search data from api
                  WeatherService  service =WeatherService();
                 WeatherModel? weather= await  service.getweather(cityName: cityName!);
                 Provider.of<WeatherProvider>(context , listen: false).weatherData=weather;
                             Provider.of<WeatherProvider>(context , listen:false).cityName=cityName;
                 Navigator.pop(context);
                },
                decoration: InputDecoration(
                  label:Text('Search'),
                  contentPadding: EdgeInsets.symmetric(vertical: 28,horizontal: 18),
                  hintText: 'Enter a City',
                  border: OutlineInputBorder(),
                  suffixIcon: GestureDetector(
                      onTap: () async {
                        WeatherService  service =WeatherService();
                        WeatherModel? weather= await  service.getweather(cityName: cityName!);
                        // ignore: use_build_context_synchronously
                        Provider.of<WeatherProvider>(context , listen: false).weatherData=weather;
                        // ignore: use_build_context_synchronously
                        Provider.of<WeatherProvider>(context , listen:false).cityName=cityName;
                        Navigator.pop(context);
                      },
                      child: Icon(Icons.search)),
                ),
              ),
            ),
          ),

    );
  }
}
