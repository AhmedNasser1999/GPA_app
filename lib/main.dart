import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gpa/Data/dataHelper.dart';
import 'package:gpa/Screens/home.dart';
import 'package:gpa/bloc/gpa_cubit.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await DataHelper.init();
  
  runApp(
    BlocProvider(
      create: (context) => GpaAppCubit(),
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.indigo,
      ),
      home: const GBAHome(),
    );
  }
}
