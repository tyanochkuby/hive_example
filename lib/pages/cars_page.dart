import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:hive_example/model/car.dart';

class CarsPage extends StatefulWidget {
  const CarsPage({super.key});

  @override
  State<CarsPage> createState() => _CarsPageState();
}

class _CarsPageState extends State<CarsPage> {
  final List<Car> cars = [];

  @override
  void dispose() {
    Hive.close();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container();
  }
}
