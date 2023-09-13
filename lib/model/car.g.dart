// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'car.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class CarAdapter extends TypeAdapter<Car> {
  @override
  final int typeId = 0;

  @override
  Car read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return Car()
      ..vin = fields[0] as String
      ..year = fields[1] as int
      ..model = fields[2] as String
      ..price = fields[3] as double
      ..isDamaged = fields[4] as bool;
  }

  @override
  void write(BinaryWriter writer, Car obj) {
    writer
      ..writeByte(5)
      ..writeByte(0)
      ..write(obj.vin)
      ..writeByte(1)
      ..write(obj.year)
      ..writeByte(2)
      ..write(obj.model)
      ..writeByte(3)
      ..write(obj.price)
      ..writeByte(4)
      ..write(obj.isDamaged);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is CarAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
