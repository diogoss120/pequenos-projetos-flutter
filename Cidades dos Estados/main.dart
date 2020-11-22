//import 'package:app_cidade/municipio.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'municipio.dart';

void main() {
  runApp(MyApp());
}

Future<http.Response> buscaEstados() async {
  String url = "https://servicodados.ibge.gov.br/api/v1/localidades/estados";
  http.Response response = await http.get(url);

  if (response.statusCode == 200) {
    return response;
  } else {
    throw Exception("ocorreu um erro ao recuperar os estados do servidor!");
  }
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: MyHomePage(title: 'Estados'),
    );
  }
}

class CartaoEstado extends StatelessWidget {
  int codigo = 0;
  String sigla = "";
  String nome = "";

  CartaoEstado({this.codigo, this.sigla, this.nome});

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
              title: Text(this.sigla),
              subtitle: Text(this.nome),
            ),
          ),
          Flexible(
              fit: FlexFit.loose,
              flex: 2,
              child: FlatButton.icon(
                  onPressed: () {
                    Navigator.push(context, MaterialPageRoute(
                      builder: (context) {
                        return Municipio(codigoUF: this.codigo);
                      },
                    ));
                  },
                  icon: Icon(Icons.details),
                  label: Text("Detalhar")))
        ],
      ),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  List<CartaoEstado> listaCartoes = List();

/*
  @override
  void initState() {
    buscaEstados().then((response) {
      var estados = jsonDecode(response.body);

      for (int i = 0; i < estados.length; i++) {
        var estado = estados[i];
        print(estado);
        CartaoEstado cartao =
            CartaoEstado(sigla: estado['sigla'], nome: estado['nome']);

        listaCartoes.add(cartao);
      }
    });

    super.initState();
  }
*/

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: FutureBuilder(
          future: buscaEstados(),
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              var estados = jsonDecode(snapshot.data.body);
              for (int i = 0; i < estados.length; i++) {
                var estado = estados[i];
                print(estado);
                CartaoEstado cartao = CartaoEstado(
                    codigo: estado['id'],
                    sigla: estado['sigla'],
                    nome: estado['nome']);

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
          }),
    );
  }
}
