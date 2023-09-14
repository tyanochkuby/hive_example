import 'package:bloc/bloc.dart';
import 'package:hive_example/model/car.dart';
import 'package:meta/meta.dart';

part 'cars_state.dart';

class CarsCubit extends Cubit<CarsState> {
  CarsCubit() : super(CarsState(cars: []));

  void addCar(String vin, int year, String model, double price, bool isDamaged) =>
  
}
