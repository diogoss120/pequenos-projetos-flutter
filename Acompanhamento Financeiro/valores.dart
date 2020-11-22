import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

import 'dart:convert';
import 'dia.dart';

Future<http.Response> historicoDePrecos(String moeda, String dias) async {
  String endereco = "https://economia.awesomeapi.com.br/json/daily/" +
      moeda +
      "/" +
      dias +
      "";
  http.Response requisicao = await http.get(endereco);

  if (requisicao.statusCode == 200) {
    return requisicao;
  } else {
    throw Exception("Erro ao buscar moedas");
  }
}

class Valores extends StatefulWidget {
  var moeda;
  var dias;
  Valores(m, d) {
    this.moeda = m;
    this.dias = d;
  }

  ValoresState createState() => ValoresState(moeda, dias);
}

class ValoresState extends State<Valores> {
  var moeda;
  var qtdDias;
  var resp;
  List<ValoresAoDia> historico = List();

  ValoresState(m, d) {
    this.moeda = m;
    this.qtdDias = d + 1;
    buscarPrecos();
  }

  void buscarPrecos() {
    historicoDePrecos(moeda.toString(), qtdDias.toString()).then(
      (requisicao) {
        setState(() {
          resp = json.decode(requisicao.body);
          for (int i = 1; i < resp.length; i++) {
            var min = resp[i]['low'];
            var max = resp[i]['high'];
            historico.add(
              ValoresAoDia(min: min, max: max),
            );
          }
        });
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      home: Scaffold(
        appBar: AppBar(
            title: Text("Moedas estrangeiras"),
            leading: IconButton(
              icon: Icon(Icons.arrow_back),
              onPressed: () {
                Navigator.pop(context);
              },
            )),
        body: ListView.builder(
          itemCount: historico.length,
          itemBuilder: (BuildContext context, int index) {
            return historico[index];
          },
        ),
      ),
    );
  }
}
