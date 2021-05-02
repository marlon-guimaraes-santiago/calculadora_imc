import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(MaterialApp(
    home: Home(),
    debugShowCheckedModeBanner: false,
  ));
}

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  /// DECLARANDO OS CONTROLES DOS CAMPOS DE TEXTO
  TextEditingController PesotController = TextEditingController();
  TextEditingController AlturaController = TextEditingController();

  /// criando uma verificação de formulario preenchido

  GlobalKey<FormState> _formkey = GlobalKey<FormState>();

  /// declarando o texto
  String _infoText = "Informe seus dados";

  /// criando a função de reset
  void _resetField(){
    PesotController.text = "";
    AlturaController.text = "";
    setState(() {
      _infoText = "Informe seus dados";
    });

  }
/// criando a função de calcular

  void _calcular(){
    setState(() {
      double peso =  double.parse(PesotController.text);
      double altura =  double.parse(AlturaController.text) / 100;
      double imc = peso / (altura * altura);
      if(imc < 18.6){
        _infoText = "Abaixo do Peso (${imc.toStringAsPrecision(3)})";
      } else if(imc >= 18.6 && imc < 24.9){
        _infoText = "Peso Ideal (${imc.toStringAsPrecision(3)})";
      } else if(imc >= 24.6 && imc < 29.9){
        _infoText = "Levemente Acima do Peso (${imc.toStringAsPrecision(3)})";
      } else if( imc >= 29.9 && imc <34.9){
        _infoText = "Obesidade Grau 1 (${imc.toStringAsPrecision(3)})";
      } else if( imc >= 34.9 && imc <39.9){
        _infoText = "Obesidade Grau 2 (${imc.toStringAsPrecision(3)})";
      } else if( imc >=40){
        _infoText = "Obesidade Grau 3 (${imc.toStringAsPrecision(3)})";
      }
    });

  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Calculadora de Imc"),
        centerTitle: true,
        backgroundColor: Colors.indigo,
        actions: <Widget>[
          IconButton(icon: Icon(Icons.refresh), onPressed: _resetField)
        ],
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.fromLTRB(10, 0, 10, 0),
        child: Form(
          key: _formkey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: <Widget>[
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Image.asset("assets/images/tabela_imc.png"),
              ),
              TextFormField(
                keyboardType: TextInputType.number,
                decoration: InputDecoration(
                    labelText: "Peso (Kg)",
                    labelStyle: TextStyle(color: Colors.indigo)),
                textAlign: TextAlign.center,
                style: TextStyle(color: Colors.indigo, fontSize: 25),
                controller: PesotController,
                validator: (value){
                  if(value.isEmpty){
                    return "Insira seu Peso";
                  }
                },
              ),
              TextFormField(
                keyboardType: TextInputType.number,
                decoration: InputDecoration(
                    labelText: "Altura (cm)",
                    labelStyle: TextStyle(color: Colors.indigo)),
                textAlign: TextAlign.center,
                style: TextStyle(color: Colors.indigo, fontSize: 25),
                controller: AlturaController,
                validator: (value){
                  if(value.isEmpty){
                    return "Insira sua Altura";
                  }
                },
              ),
              Padding(
                padding: const EdgeInsets.only(top: 10, bottom: 10),
                child: Container(
                  height: 50,
                  child: RaisedButton(
                    onPressed: () {
                      if(_formkey.currentState.validate()){
                        _calcular();
                      }
                    },

                    child: Text(
                      "Calcular",
                      style: TextStyle(color: Colors.white, fontSize: 25.0),
                    ),
                    color: Colors.indigo,
                  ),
                ),
              ),
              Text(
                _infoText,
                textAlign: TextAlign.center,
                style: TextStyle(color: Colors.indigo, fontSize: 25),
              )
            ],
          ),
        ),
      ),
    );
  }
}
