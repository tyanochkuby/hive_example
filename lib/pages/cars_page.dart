import 'package:flutter/material.dart';
// import 'package:flutter_bloc/flutter_bloc.dart';
// import 'package:hive_example/cubits/cubit/cars_cubit.dart';
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

                return Table(
                  border: TableBorder.all(color: Colors.black),
                  children: List<TableRow>.generate(cars.length, (index) {
                    final car = cars.elementAt(index);
                    return TableRow(children: [
                      //     Padding(
                      //     padding: EdgeInsets.all(5.0),
                      //     child: Text(car.vin, textAlign: TextAlign.center),
                      // ),
                      // Padding(
                      //     padding: EdgeInsets.all(5.0),
                      //     child: Text(car.year.toString(), textAlign: TextAlign.center),
                      // ),
                      // Padding(
                      //     padding: EdgeInsets.all(5.0),
                      //     child: Text(car.model, textAlign: TextAlign.center),
                      // ),
                      // Padding(
                      //     padding: EdgeInsets.all(5.0),
                      //     child: Text('${car.price}\$', textAlign: TextAlign.center),
                      // ),
                      // if(car.isDamaged)
                      //   const Padding(padding: EdgeInsets.all(5.0),
                      //   child: Text('Damaged', textAlign: TextAlign.center,),
                      //   )
                      const Spacer(),
                      SizedBox(
                        width: MediaQuery.of(context).size.width * 0.3,
                        child: Text(car.vin),
                      ),
                      SizedBox(
                        width: MediaQuery.of(context).size.width * 0.1,
                        child: Text(car.year.toString()),
                      ),
                      SizedBox(
                        width: MediaQuery.of(context).size.width * 0.3,
                        child: Text(car.model),
                      ),
                      SizedBox(
                        width: MediaQuery.of(context).size.width * 0.1,
                        child: Text(car.price.toString()),
                      ),
                      SizedBox(
                        width: MediaQuery.of(context).size.width * 0.1,
                        child: Text(car.isDamaged ? 'yes' : 'no'),
                      ),
                      SizedBox(
                        width: MediaQuery.of(context).size.width * 0.05,
                        child: GestureDetector(
                          onTap: () {
                            deleteCar(car);
                          },
                          child: const Icon(Icons.delete),
                        ),
                      ),
                      const Spacer(),
                    ]);
                  }),
                );

                // return ListView.builder(itemBuilder: (context, index) {
                //   return Row(
                //     children: [
                //       const Spacer(),
                //       SizedBox(
                //         width: MediaQuery.of(context).size.width * 0.3,
                //         child: Text(cars.elementAt(index).vin),
                //       ),
                //       SizedBox(
                //         width: MediaQuery.of(context).size.width * 0.1,
                //         child: Text(cars.elementAt(index).year.toString()),
                //       ),
                //       SizedBox(
                //         width: MediaQuery.of(context).size.width * 0.3,
                //         child: Text(cars.elementAt(index).model),
                //       ),
                //       SizedBox(
                //         width: MediaQuery.of(context).size.width * 0.1,
                //         child: Text(cars.elementAt(index).price.toString()),
                //       ),
                //       SizedBox(
                //         width: MediaQuery.of(context).size.width * 0.1,
                //         child: Text(
                //             cars.elementAt(index).isDamaged ? 'yes' : 'no'),
                //       ),
                //       SizedBox(
                //         width: MediaQuery.of(context).size.width * 0.05,
                //         child: GestureDetector(
                //           onTap: () {
                //             deleteCar(cars.elementAt(index));
                //           },
                //           child: const Icon(Icons.delete),
                //         ),
                //       ),
                //       const Spacer(),
                //     ],
                //   );
                // });
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
          child: const Icon(Icons.add),
          onPressed: () => showDialog(
              context: context, builder: (context) => CarCreateDialog())),
    );
  }

  // ignore: non_constant_identifier_names
}

class CarCreateDialog extends StatefulWidget {
  @override
  State<CarCreateDialog> createState() => _CarCreateDialogState();
}

class _CarCreateDialogState extends State<CarCreateDialog> {
  final TextEditingController vinController = TextEditingController();

  final TextEditingController yearController = TextEditingController();

  final TextEditingController modelController = TextEditingController();

  final TextEditingController priceController = TextEditingController();

  String errorMessage = '';

  bool isDamaged = false;

  @override
  Widget build(BuildContext context) {
    return Dialog(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 30),
        child: Column(children: [
          TextFormField(
            decoration: const InputDecoration(hintText: 'vin'),
            controller: vinController,
            keyboardType: TextInputType.text,
          ),
          TextFormField(
            decoration: const InputDecoration(hintText: 'year'),
            controller: yearController,
            keyboardType: TextInputType.number,
          ),
          TextFormField(
            decoration: const InputDecoration(hintText: 'model'),
            controller: modelController,
            keyboardType: TextInputType.text,
          ),
          TextFormField(
            decoration: const InputDecoration(hintText: 'price'),
            controller: priceController,
            keyboardType: TextInputType.number,
          ),
          Row(
            children: [
              const Text('Is car damaged?'),
              Checkbox(
                  value: isDamaged,
                  onChanged: ((newValue) => setState(() {
                        isDamaged = newValue!;
                      }))),
            ],
          ),
          errorMessage == ''
              ? const SizedBox(
                  height: 15,
                )
              : SizedBox(
                  height: 15,
                  child: Text(
                    errorMessage,
                    style: const TextTheme()
                        .bodyMedium!
                        .copyWith(color: Colors.red),
                  )),
          ElevatedButton(
              onPressed: () {
                errorMessage =
                    (vinController.text.isEmpty ? 'Enter VIN\n' : '') +
                        (yearController.text.isEmpty ? 'Enter year\n' : '') +
                        (modelController.text.isEmpty ? 'Enter model\n' : '') +
                        (priceController.text.isEmpty ? 'Enter price\n' : '');
                if (errorMessage == '') {
                  addCar(
                      vinController.text,
                      int.parse(yearController.text),
                      modelController.text,
                      double.parse(priceController.text),
                      isDamaged);
                }
              },
              child: const Text('Submit'))
        ]),
      ),
    );
  }
}

void addCar(String vin, int year, String model, double price, bool isDamaged) {
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
