import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:todo_example/bloc_observer.dart';
import 'package:todo_example/layout/home_layout.dart';

void main() {
  Bloc.observer = MyBlocObserver();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Todo App',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: HomeLayout(),
    );
  }
}