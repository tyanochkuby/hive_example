import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hive/hive.dart';
import 'package:hive_example/cubits/cubit/cars_cubit.dart';
import 'package:hive_example/model/car.dart';
import 'package:hive_flutter/hive_flutter.dart';

import '../boxes.dart';

class CarsPage extends StatefulWidget {
  const CarsPage({super.key});

  @override
  State<CarsPage> createState() => _CarsPageState();
}

class _CarsPageState extends State<CarsPage> {
  @override
  void dispose() {
    Hive.close();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          Text(
            'Car list',
            style: Theme.of(context)
                .textTheme
                .displayLarge!
                .copyWith(color: Colors.black54),
          ),
          ValueListenableBuilder<Box<Car>>(
              valueListenable: Boxes.getCars().listenable(),
              builder: (context, box, _) {
                final cars = box.values.toList().cast<Car>();

                return ListView.builder(itemBuilder: (context, index) {
                  Row(
                    children: [
                      const Spacer(),
                      SizedBox(
                        width: MediaQuery.of(context).size.width * 0.3,
                        child: Text(cars.elementAt(index).vin),
                      ),
                      SizedBox(
                        width: MediaQuery.of(context).size.width * 0.1,
                        child: Text(cars.elementAt(index).year.toString()),
                      ),
                      SizedBox(
                        width: MediaQuery.of(context).size.width * 0.3,
                        child: Text(cars.elementAt(index).model),
                      ),
                      SizedBox(
                        width: MediaQuery.of(context).size.width * 0.1,
                        child: Text(cars.elementAt(index).price.toString()),
                      ),
                      SizedBox(
                        width: MediaQuery.of(context).size.width * 0.1,
                        child: Text(
                            cars.elementAt(index).isDamaged ? 'yes' : 'no'),
                      ),
                      SizedBox(
                        width: MediaQuery.of(context).size.width * 0.05,
                        child: GestureDetector(
                          onTap: () {
                            deleteCar(cars.elementAt(index));
                          },
                          child: Icon(Icons.delete),
                        ),
                      ),
                      const Spacer(),
                    ],
                  );
                });
              }),
          // BlocBuilder<CarsCubit, CarsState>(builder: (context, state) {
          //   return ListView.builder(itemBuilder: (context, index) {
          //     Row(
          //       children: [
          //         const Spacer(),
          //         SizedBox(
          //           width: MediaQuery.of(context).size.width * 0.3,
          //           child: Text(state.cars.elementAt(index).vin),
          //         ),
          //         SizedBox(
          //           width: MediaQuery.of(context).size.width * 0.1,
          //           child: Text(state.cars.elementAt(index).year.toString()),
          //         ),
          //         SizedBox(
          //           width: MediaQuery.of(context).size.width * 0.3,
          //           child: Text(state.cars.elementAt(index).model),
          //         ),
          //         SizedBox(
          //           width: MediaQuery.of(context).size.width * 0.1,
          //           child: Text(state.cars.elementAt(index).price.toString()),
          //         ),
          //         SizedBox(
          //           width: MediaQuery.of(context).size.width * 0.1,
          //           child: Text(state.cars.elementAt(index).isDamaged ? 'yes' : 'no'),
          //         ),
          //         const Spacer(),
          //       ],
          //     );
          //   });
          // }),
        ],
      ),
      floatingActionButton: FloatingActionButton(
          child: Icon(Icons.add),
          onPressed: () =>
              showDialog(context: context, builder: (context) => CarDialog())),
    );
  }

  void addCar(
      String vin, int year, String model, double price, bool isDamaged) {
    final car = Car()
      ..vin = vin
      ..year = year
      ..model = model
      ..price = price
      ..isDamaged = isDamaged;
    final box = Boxes.getCars();
    box.add(car);
  }

  void deleteCar(Car car) {
    car.delete();
  }
}
