import 'package:flutter/material.dart';
import 'package:news_app/provider/news_provider.dart';
import 'package:news_app/screens/home/home.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (ctx) => NewsProvider()),
      ],
      child: MaterialApp(
          title: 'News App',

          debugShowCheckedModeBanner: false,
          theme: ThemeData(
            primarySwatch: Colors.blue,
            textTheme: const TextTheme(
              headline1: TextStyle(fontSize: 20,),
              headline2: TextStyle(fontSize: 18,),
              headline3: TextStyle(fontSize: 16,),
              headline4: TextStyle(fontSize: 14,fontWeight: FontWeight.bold,color: Colors.black),
              headline5: TextStyle(fontSize: 13),
            ),
          ),
          home: const HomePage()),
    );
  }
}
