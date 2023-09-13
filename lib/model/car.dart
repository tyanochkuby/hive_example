import 'package:hive/hive.dart';

part 'car.g.dart';

@HiveType(typeId: 0)
class Car extends HiveObject {
  @HiveField(0)
  late String vin;

  @HiveField(1)
  late int year;

  @HiveField(2)
  late String model;

  @HiveField(3)
  late double price;

  @HiveField(4)
  late bool isDamaged;
}
