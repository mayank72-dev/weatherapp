import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:weatherapp/src/Widget/custom_button.dart';
import 'package:weatherapp/src/bloc/bloc.dart';
import 'bloc/bloc_event.dart';
import 'bloc_state.dart';


class HomeScreen extends StatefulWidget {
  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final TextEditingController city = TextEditingController();

  final TextEditingController search = TextEditingController();

  String searchQuery = '';


  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(title: Text('Weather App')),
        body: Padding(
          padding: EdgeInsets.all(16.0),
          child: Column(
            children: [
              TextFormField(
                controller: city,
                decoration: InputDecoration(
                    hintText: "Enter City",
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(12))),),
              Padding(padding: EdgeInsets.only(top: 20)),

              Row(
                children: [
                  customButton(() {
                    BlocProvider.of<WeatherBloc>(context).add(
                        FetchWeather(cityName: city.text));
                  },  "Fetch Data"),
                  Padding(padding: EdgeInsets.only(left: 20)),
                  customButton(() {

                    final weatherState = BlocProvider
                        .of<WeatherBloc>(context)
                        .state;
                    if (weatherState is WeatherLoaded) {
                      BlocProvider.of<WeatherBloc>(context).add(
                        SaveWeather(weather: weatherState.weather),
                      );
                    }}, "Save Data"),
                ]),


                Padding(padding: EdgeInsets.only(top: 20)),
              BlocBuilder<WeatherBloc, WeatherState>(
                builder: (context, state) {
                  if (state is WeatherLoading) {
                    return CircularProgressIndicator();
                  } else if (state is WeatherLoaded) {
                    return Column(
                      children: [
                        Text('City: ${state.weather.cityName}'),
                        Text('Temperature: ${state.weather.temperature}'),

                      ],
                    );

                  } else if (state is WeatherError) {
                    return Text(
                      'Error: ${state.message}',
                      style: TextStyle(color: Colors.red),
                    );
                  } else if (state is WeatherSaved) {
                    return Text('Weather data saved successfully!');
                  }
                  return Container();
                },
              ),

              Padding(padding: EdgeInsets.only(top: 30)),
              TextFormField(
                controller: search,
                decoration: InputDecoration(
                    hintText: "Search",
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(12))),
              onChanged: (value){
                  setState(() {
                    searchQuery = value.toLowerCase();
                  });},),

    Padding(padding: EdgeInsets.only(top: 30)),
    Expanded(
    child: StreamBuilder<QuerySnapshot>(
    stream: FirebaseFirestore.instance.collection('weather').snapshots(),
    builder: (context, snapshot) {
    if (!snapshot.hasData) {
    return Center(child: CircularProgressIndicator());
    }

    final weatherDocs = snapshot.data!.docs.where((doc) {
    final data = doc.data() as Map<String, dynamic>;
    return  data['cityName'].toString().toLowerCase().contains(searchQuery);
    }).toList();

    return
    ListView.builder(
    itemCount: weatherDocs.length,
    itemBuilder: (context, index) {
    final data = weatherDocs[index].data() as Map<String, dynamic>;
    return

      ListTile(title:Text(data['cityName']),subtitle: Text('Temp: ${data['temperature'].toString()}°C,'),);
      Column(
      children: [


      Padding(padding: EdgeInsets.only(top: 10)),

        Padding(padding: EdgeInsets.only(top: 10)),
      ],
    );
    },
    );
    },
    )

    )]),
        ));

  }
}
