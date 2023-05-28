import 'package:flutter/material.dart';

class ListViewScrollTest extends StatelessWidget {
  const ListViewScrollTest({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 10.0),
        child: ListWheelScrollView.useDelegate(
            squeeze: 1,
            perspective: 0.001,
            physics: const ClampingScrollPhysics(),

            // diameterRatio: 1.7,
            // offAxisFraction: -2,
            itemExtent: 300,
            childDelegate: ListWheelChildBuilderDelegate(
              childCount: 10,
              builder: (context, index) {
                return Center(
                  child: Card(
                    elevation: 50,
                    child: Container(
                      height: 400,
                      // width: 300,
                      color: index % 2 == 0 ? Colors.orange : Colors.black,
                      child: Center(
                          child: Text(
                        index.toString(),
                        style: const TextStyle(color: Colors.white),
                      )),
                    ),
                  ),
                );
              },
            )),
      ),
    );
  }
}
