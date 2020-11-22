import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

Future<http.Response> buscaMunicipio(int codigoUF) async {
  String url =
      "https://servicodados.ibge.gov.br/api/v1/localidades/estados/$codigoUF/municipios";
  http.Response response = await http.get(url);

  if (response.statusCode == 200) {
    return response;
  } else {
    throw Exception("ocorreu um erro ao recuperar os municipios do servidor!");
  }
}

class CartaoMunicipio extends StatelessWidget {
  int codigo = 0;
  String nome = "";

  CartaoMunicipio({this.codigo, this.nome});

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Flexible(
            fit: FlexFit.tight,
            flex: 4,
            child: ListTile(
              title: Text(this.codigo.toString()),
              subtitle: Text(this.nome),
            ),
          ),
        ],
      ),
    );
  }
}

class Municipio extends StatefulWidget {
  int codigoUF = 0;

  Municipio({this.codigoUF});

  @override
  State createState() {
    return MunicipioState();
  }
}

class MunicipioState extends State<Municipio> {
  List<CartaoMunicipio> listaCartoes = List();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text("Municipio"),
        ),
        body: FutureBuilder(
            future: buscaMunicipio(widget.codigoUF),
            builder: (context, snapshot) {
              if (snapshot.hasData) {
                var municipios = jsonDecode(snapshot.data.body);
                for (int i = 0; i < municipios.length; i++) {
                  var municipio = municipios[i];

                  CartaoMunicipio cartao = CartaoMunicipio(
                      codigo: municipio['id'], nome: municipio['nome']);

                  listaCartoes.add(cartao);
                }

                return ListView.builder(
                  itemCount: listaCartoes.length,
                  itemBuilder: (context, index) {
                    return listaCartoes[index];
                  },
                );
              } else {
                return Center(child: CircularProgressIndicator());
              }
            }));
  }
}
