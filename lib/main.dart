import 'package:flutter/material.dart';
import 'package:flutter_workshop/features/workshop01_my_portfolio/myportfolio_view.dart';
import 'package:flutter_workshop/features/workshop02_number_counter/number_counter_view.dart';
import 'package:flutter_workshop/features/workshop_03_todo_app/create_todo_app_view.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: .fromSeed(seedColor: Colors.deepPurple),
      ),
      home: CreateTodoAppView(),
    );
  }
}


