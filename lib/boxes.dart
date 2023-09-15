import 'package:hive/hive.dart';
import 'package:hive_example/model/car.dart';

class Boxes {
  static Box<Car> getCars() => Hive.box<Car>('cars');
}
