import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hive_example/cubits/cubit/cars_cubit.dart';
import 'package:hive_example/pages/cars_page.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:hive_example/model/car.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await Hive.initFlutter();

  Hive.registerAdapter(CarAdapter());
  await Hive.openBox<Car>('cars');

  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => CarsCubit(),
      child: MaterialApp(
        theme: ThemeData(primarySwatch: Colors.amber),
        home: const CarsPage(),
      ),
    );
  }
}
