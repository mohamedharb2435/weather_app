import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:weather_app/models/weather_model.dart';
import 'package:weather_app/pages/search_page.dart';
import 'package:weather_app/provider/weather_provider.dart';

class HomePage extends StatefulWidget {
   HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
   WeatherModel? weatherData;
   // void updateUi(){
   //   setState(() {
   //
   //   });
   // }

  @override
  Widget build(BuildContext context) {
    weatherData = Provider.of<WeatherProvider>(context).weatherData;
    return Scaffold(
      appBar: AppBar(
        actions: [
          IconButton(
              onPressed: ()
              {
                Navigator.push(context , MaterialPageRoute(builder:(context)
                {
                  return SearchPage(
                    //updateUi:updateUi,
                  );
                }));
              },
               icon: Icon(Icons.search),
    ),
        ],
        title: Text('Weather App'),
      ),
      body:Provider.of<WeatherProvider>(context , listen: true).weatherData == null ?  Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              'there is no weather 😔 start',
              style: TextStyle(
                fontSize: 25,
                fontWeight: FontWeight.w400,
              ),
            ),
            Text(
              'searching now 🔍',
              style: TextStyle(
                fontWeight: FontWeight.w400,
                fontSize: 25,
              ),
            )
          ],
        ),
      ) :Container(
       decoration: BoxDecoration(
         gradient:LinearGradient(
           colors:[
             weatherData!.getThemeColor(),
             weatherData!.getThemeColor()[300]!,
             weatherData!.getThemeColor()[100]!,

           ],
               begin: Alignment.topCenter,
               end: Alignment.bottomCenter,
         )
       ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
          Spacer(flex: 2,),
            Text(
              Provider.of<WeatherProvider>(context).cityName!,
            style: const TextStyle(
              fontSize: 32 ,
              fontWeight: FontWeight.bold,
            ),
            ),
            Text('Update at:${weatherData!.date.hour.toString()}:${weatherData!.date.minute.toString()}',
              style: const TextStyle(
                fontSize: 20 ,
                fontWeight: FontWeight.w100,
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Image(image: AssetImage(weatherData!.getImage())),
                Text(weatherData!.temp.toInt().toString(),
                  style: const TextStyle(
                    fontSize: 20 ,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Column(
                  children: [
                    Text('maxtemp:${weatherData!.maxTemp.toInt()}',),
                    Text('mintemp:${weatherData!.minTemp.toInt()}',),
                  ],
                ),
              ],
            ),
            Spacer(),
            Text(weatherData!.weatherStateName,
            style: TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 32
            ),
            ),
            Spacer(flex: 5,),
          ],
        ),
      ),
    );
  }
}
