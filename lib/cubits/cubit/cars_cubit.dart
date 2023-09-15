import 'dart:math';

import 'package:bloc/bloc.dart';
import 'package:hive_example/boxes.dart';
import 'package:hive_example/model/car.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:meta/meta.dart';

part 'cars_state.dart';

class CarsCubit extends Cubit<CarsState> {
  CarsCubit()
      : super(CarsState(cars: Boxes.getCars().values.toList().cast<Car>()));

  void addCar(
      String vin, int year, String model, double price, bool isDamaged) {
    if (state.cars.contains(Car()..vin = vin)) {
      throw Error();
    }
    List<Car> newCars = state.cars;
    final car = Car()
      ..vin = vin
      ..year = year
      ..model = model
      ..price = price
      ..isDamaged = isDamaged;
    newCars.add(car);

    Boxes.getCars().add(car); //adding to hive box

    emit(CarsState(cars: newCars));
  }

  bool deleteCar(String vin) {
    if (!state.cars.contains(Car()..vin = vin)) {
      print('Car doesn\'t exist');
      return false;
    }
    List<Car> newCars = state.cars;
    newCars.firstWhere((element) => element.vin == vin).delete();
    emit(CarsState(cars: newCars));
    return true;
  }
}
