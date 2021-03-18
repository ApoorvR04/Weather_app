
import 'package:flutter/material.dart';
import 'package:flutter_app/dataservice.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';


void main() {
  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  final _cityTextController = TextEditingController();
  final _dataService = DataService();

  WeatherResponse _response;

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        home: Scaffold(

          body: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,

              children: [

                Column(


                  children:[
                    Padding(padding: EdgeInsets.only(bottom: 20.0)),
                    SizedBox(
                    width: 280,
                    child: TextField(
                        controller: _cityTextController,
                        decoration: InputDecoration(labelText: 'City', hintText: "Enter City name"),
                        textAlign: TextAlign.center),
                  ),
                  Padding(padding: EdgeInsets.only(bottom: 3.0)),
                  ElevatedButton(onPressed: _search, child: Text('Search')),
                    Padding(padding: EdgeInsets.only(bottom: 20.0)),
            ]

                ),


                if (_response != null)
                  Column(
                    children: [
                      Text(
                        '${_cityTextController.text}',
                        style: TextStyle(fontSize: 25),
                      ),
                      Text(
                        '${_response.tempInfo.temperature}° C',
                        style: TextStyle(fontSize: 40),
                      ),
                      Image.network(_response.iconUrl),

                      Text(_response.weatherInfo.description, style: TextStyle(
                        fontSize: 30.0
                      ),),
                      Padding(padding: EdgeInsets.only(bottom: 35.0)),
                      ListTile(
                        leading: FaIcon(FontAwesomeIcons.tachometerAlt),
                        title: Text("Humidity", style: TextStyle(fontSize: 20),),
                         trailing: Text(
                            '${_response.tempInfo.humidity} %',
                          style: TextStyle(fontSize: 20),

                      ),
                      ),
                      ListTile(
                        leading: FaIcon(FontAwesomeIcons.prescriptionBottle),
                        title: Text("Pressure", style: TextStyle(fontSize: 20.0),),
                            trailing: Text(
                          '${_response.tempInfo.pressure} mb',
                           style: TextStyle(fontSize: 20),

                      ),
                      ),
                    ],
                  ),





              ],

            ),
          ),
        ));
  }

  void _search() async {
    final response = await _dataService.getWeather(_cityTextController.text);
    setState(() => _response = response);
  }
}
