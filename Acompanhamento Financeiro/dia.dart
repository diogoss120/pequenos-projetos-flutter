import 'package:flutter/material.dart';

class ValoresAoDia extends StatelessWidget {
  var min;
  var max;
  ValoresAoDia({
    this.min,
    this.max,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.all(15),
      child: Column(
        children: [
          Text(
            'Minimo: ' + this.min.toString(),
            style: TextStyle(fontSize: 24),
          ),
          Text(
            'Maximo: ' + this.max.toString(),
            style: TextStyle(fontSize: 24),
          )
        ],
      ),
    );
  }
}
