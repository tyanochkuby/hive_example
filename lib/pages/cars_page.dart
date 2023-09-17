import 'package:flutter/material.dart';
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

  final TextEditingController vinController = TextEditingController();

  final TextEditingController yearController = TextEditingController();

  final TextEditingController modelController = TextEditingController();

  final TextEditingController priceController = TextEditingController();

  String errorMessage = '';

  bool isDamaged = false;

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
              }),
        ],
      ),
      floatingActionButton: FloatingActionButton(
          child: const Icon(Icons.add),
          onPressed: () => showModalBottomSheet(
              shape: const RoundedRectangleBorder(
                  borderRadius:
                      BorderRadius.vertical(top: Radius.circular(15))),
              context: context,
              builder: (context) {
                return StatefulBuilder(builder: (context, setModalState) {
                  return Padding(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 50, vertical: 15),
                    child: Column(children: [
                      TextField(
                        decoration: const InputDecoration(
                            border: OutlineInputBorder(), hintText: 'vin'),
                        controller: vinController,
                        keyboardType: TextInputType.text,
                      ),
                      TextField(
                        decoration: const InputDecoration(
                            border: OutlineInputBorder(), hintText: 'year'),
                        controller: yearController,
                        keyboardType: TextInputType.number,
                      ),
                      TextField(
                        decoration: const InputDecoration(
                            border: OutlineInputBorder(), hintText: 'model'),
                        controller: modelController,
                        keyboardType: TextInputType.text,
                      ),
                      TextField(
                        decoration: const InputDecoration(
                            border: OutlineInputBorder(), hintText: 'price'),
                        controller: priceController,
                        keyboardType: TextInputType.number,
                      ),
                      Row(
                        children: [
                          const Text('Is car damaged?'),
                          Checkbox(
                              value: isDamaged,
                              onChanged: ((newValue) => setModalState(() {
                                    isDamaged = newValue!;
                                  }))),
                        ],
                      ),
                      Text(
                        errorMessage,
                        style: const TextStyle(color: Colors.red),
                      ),
                      const Spacer(),
                      ElevatedButton(
                          onPressed: () {
                            setModalState(() {
                              errorMessage = (vinController.text.isEmpty
                                      ? 'Enter VIN '
                                      : '') +
                                  (yearController.text.isEmpty
                                      ? 'Enter year '
                                      : '') +
                                  (modelController.text.isEmpty
                                      ? 'Enter model '
                                      : '') +
                                  (priceController.text.isEmpty
                                      ? 'Enter price '
                                      : '');
                              print(errorMessage);
                            });

                            if (errorMessage == '') {
                              addCar(
                                  vinController.text,
                                  int.parse(yearController.text),
                                  modelController.text,
                                  double.parse(priceController.text),
                                  isDamaged);
                              Navigator.pop(context);
                            }
                          },
                          child: const Text('Submit'))
                    ]),
                  );
                });
              })),
    );
  }

  // ignore: non_constant_identifier_names
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
