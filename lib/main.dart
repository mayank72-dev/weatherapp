import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:weatherapp/src/ApiService.dart';
import 'package:weatherapp/src/bloc/bloc.dart';
import 'package:weatherapp/src/hom_screen.dart';

void main() async{
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp( MyApp());
}

class MyApp extends StatelessWidget {

   MyApp({super.key});
  final ApiService apiService = ApiService();
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return  MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
      ),
      home:  BlocProvider(
      create: (context) => WeatherBloc(apiService),
         child:HomeScreen(),
    ));
  }
}




