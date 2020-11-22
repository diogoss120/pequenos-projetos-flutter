import 'package:flutter/material.dart';
import 'valores.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      home: Scaffold(
        appBar: AppBar(
          title: Text("Selecione"),
        ),
        body: MyHomePage(),
      ),
    );
  }
}

class MyHomePage extends StatefulWidget {
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int qtdDias = 1;
  String moeda = 'USD-BRL';

  @override
  Widget build(BuildContext context) {
    //SingleChildScrollView() faz com que o conteudo não estoure
    return SingleChildScrollView(
      child: Container(
        alignment: Alignment.center,
        padding: EdgeInsets.all(15.0),
        child: Column(
          children: [
            Container(
              margin: EdgeInsets.all(25),
              child: Column(
                children: [
                  Text(
                    'Informe a Moeda: ',
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  DropdownButton(
                    value: moeda,
                    items: [
                      DropdownMenuItem(
                        child: Text("USD-BRL (Dólar Comercial)"),
                        value: "USD-BRL",
                      ),
                      DropdownMenuItem(
                        child: Text("CAD-BRL (Dólar Canadense)"),
                        value: "CAD-BRL",
                      ),
                      DropdownMenuItem(
                          child: Text("EUR-BRL (Euro)"), value: "EUR-BRL"),
                      DropdownMenuItem(
                          child: Text("GBP-BRL (Libra Esterlina)"),
                          value: "GBP-BRL"),
                      DropdownMenuItem(
                          child: Text("ARS-BRL (Peso Argentino)"),
                          value: "ARS-BRL"),
                      DropdownMenuItem(
                          child: Text("CHF-BRL (Franco Suíço)"),
                          value: "CHF-BRL"),
                      DropdownMenuItem(
                          child: Text("BTC-BRL (Bitcoin)"), value: "BTC-BRL")
                    ],
                    onChanged: (value) {
                      setState(
                        () {
                          moeda = value;
                        },
                      );
                    },
                  ),
                ],
              ),
            ),
            Container(
              margin: EdgeInsets.all(25),
              child: Column(
                children: [
                  Text(
                    'Até quantos dias deseja ',
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  DropdownButton(
                    value: qtdDias,
                    items: <int>[1, 2, 3, 4, 5, 6, 7, 8, 9, 10]
                        .map<DropdownMenuItem<int>>(
                      (int item) {
                        return DropdownMenuItem<int>(
                          child: Text(item.toString()),
                          value: item,
                        );
                      },
                    ).toList(),
                    onChanged: (int newValue) {
                      setState(() {
                        qtdDias = newValue;
                      });
                    },
                  ),
                ],
              ),
            ),
            RaisedButton(
              child: Text('Buscar dados'),
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => Valores(moeda, qtdDias),
                  ),
                );
              },
            )
          ],
        ),
      ),
    );
  }
}
