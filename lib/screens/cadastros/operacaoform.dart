import 'dart:ffi';
import 'package:flutter/material.dart';
import 'package:tcc/models/contamodel.dart';
import 'package:tcc/models/operacaomodel.dart';
import 'package:tcc/models/tipomodel.dart';
import 'package:tcc/repositories/contarepository.dart';
import 'package:tcc/repositories/operacaorepository.dart';
import 'package:tcc/repositories/tiporepository.dart';
import 'package:tcc/screens/cadastros/operacao.dart';
import 'package:tcc/screens/template.dart';
import 'package:flutter_colorpicker/flutter_colorpicker.dart';
import 'package:tcc/services/colorpicker.dart';

class CadastrarOperacao extends StatefulWidget {
  @override
  _CadastrarOperacaoState createState() => _CadastrarOperacaoState();
}

class _CadastrarOperacaoState extends State<CadastrarOperacao> {
  Color currentColor = Colors.limeAccent;
  OperacaoRepository _operacaoRepository = OperacaoRepository();
  TextEditingController _controlerDescricao = TextEditingController();
  TextEditingController _controlerSaldo = TextEditingController();
  void changeColor(Color color) => setState(() => currentColor = color);
  ContaRepository conta = ContaRepository();
  TipoRepository tipo = TipoRepository();
  ContaModel contaSelecionada;
  TipoModel categoriaSelecionada;
  String tipoOperacao;

  String toHex(Color cor) => '${cor.alpha.toRadixString(16).padLeft(2, '0')}'
      '${cor.red.toRadixString(16).padLeft(2, '0')}'
      '${cor.green.toRadixString(16).padLeft(2, '0')}'
      '${cor.blue.toRadixString(16).padLeft(2, '0')}';

  @override
  Widget build(BuildContext context) {
    return Template(
      titulo: "Incluir nova Operação",
      body: Container(
        decoration: BoxDecoration(
            image: DecorationImage(
                image: AssetImage("lib/img/Background-Form-Conta.png"),
                alignment: Alignment.topCenter,
                fit: BoxFit.cover)),
        padding: EdgeInsets.symmetric(vertical: 80.0, horizontal: 50.0),
        child: Form(
          child: ListView(
            children: <Widget>[
              SizedBox(height: MediaQuery.of(context).size.height * 0.3),
              TextFormField(
                style: TextStyle(color: Color(0xFF2B1D3D)),
                controller: _controlerDescricao,
                decoration: InputDecoration(
                    hintText: 'Descrição',
                    enabledBorder: UnderlineInputBorder(
                      borderSide: BorderSide(color: Color(0xFFF76041)),
                    ),
                    focusedBorder: UnderlineInputBorder(
                      borderSide: BorderSide(color: Color(0xFF2B1D3D)),
                    ),
                    hintStyle: TextStyle(color: Color(0xFF2B1D3D)),
                    labelStyle: TextStyle(
                      color: Color(0xFFF76041),
                    )),
              ),
              TextFormField(
                style: TextStyle(color: Color(0xFF2B1D3D)),
                controller: _controlerSaldo,
                keyboardType: TextInputType.number,
                decoration: InputDecoration(
                    hintText: 'Valor',
                    enabledBorder: UnderlineInputBorder(
                      borderSide: BorderSide(color: Color(0xFFF76041)),
                    ),
                    focusedBorder: UnderlineInputBorder(
                      borderSide: BorderSide(color: Color(0xFF2B1D3D)),
                    ),
                    hintStyle: TextStyle(color: Color(0xFF2B1D3D)),
                    labelStyle: TextStyle(
                      color: Color(0xFFF76041),
                    )),
              ),
              SizedBox(height: MediaQuery.of(context).size.height * 0.02),
              Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: <Widget>[
                      Text(
                        "Selecione um tipo de operação:",
                        style: TextStyle(color: Colors.black),
                      ),
                      DropdownButton<String>(
                        value: tipoOperacao,
                        focusColor: Colors.blue,
                        icon: Icon(Icons.arrow_drop_down),
                        iconEnabledColor: Color(0xFF2B1D3D),
                        iconSize: 24,
                        elevation: 16,
                        dropdownColor: Color(0xFF2B1D3D),
                        style: TextStyle(color: Color(0xFFF76041)),
                        underline: Container(
                          height: 1,
                          color: Color(0xFFF76041),
                        ),
                        onChanged: (String newValue) {
                          setState(() {
                            tipoOperacao = newValue;
                          });
                        },
                        items: <String>['Receita', 'Despesa']
                            .map<DropdownMenuItem<String>>((String value) {
                          return DropdownMenuItem<String>(
                            value: value,
                            child: Text(value),
                          );
                        }).toList(),
                      ),
                    ],
                  ),
                ],
              ),
              SizedBox(height: 10.0),
              Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: <Widget>[
                      Text(
                        "Selecione uma conta:",
                        style: TextStyle(color: Colors.black),
                      ),
                      StreamBuilder(
                        stream: conta.listarContas(),
                        builder: (context, snapshot) {
                          return !snapshot.hasData
                              ? Text("Carregando")
                              : DropdownButton<ContaModel>(
                                  isDense: true,
                                  value: contaSelecionada,
                                  focusColor: Colors.blue,
                                  icon: Icon(Icons.arrow_drop_down),
                                  iconEnabledColor: Color(0xFF2B1D3D),
                                  iconSize: 24,
                                  elevation: 16,
                                  dropdownColor: Color(0xFF2B1D3D),
                                  style: TextStyle(color: Color(0xFFF76041)),
                                  underline: Container(
                                    height: 1,
                                    color: Color(0xFFF76041),
                                  ),
                                  onChanged: (ContaModel newValue) {
                                    setState(() {
                                      contaSelecionada = newValue;
                                    });
                                  },
                                  items: snapshot.data
                                      .map<DropdownMenuItem<ContaModel>>(
                                          (ContaModel item) {
                                    return DropdownMenuItem<ContaModel>(
                                      child: Text(item.descricao),
                                      value: item,
                                    );
                                  }).toList(),
                                );
                        },
                      ),
                    ],
                  ),
                ],
              ),
              SizedBox(height: 25.0),
              Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: <Widget>[
                      Text(
                        "Selecione uma categoria:",
                        style: TextStyle(color: Colors.black),
                      ),
                      StreamBuilder(
                        stream: tipo.listarTipos(),
                        builder: (context, snapshot) {
                          return !snapshot.hasData
                              ? Text("Carregando")
                              : DropdownButton<TipoModel>(
                                  isDense: true,
                                  value: categoriaSelecionada,
                                  focusColor: Colors.blue,
                                  icon: Icon(Icons.arrow_drop_down),
                                  iconEnabledColor: Color(0xFF2B1D3D),
                                  iconSize: 24,
                                  elevation: 16,
                                  dropdownColor: Color(0xFF2B1D3D),
                                  style: TextStyle(color: Color(0xFFF76041)),
                                  underline: Container(
                                    height: 1,
                                    color: Color(0xFFF76041),
                                  ),
                                  onChanged: (TipoModel newValue) {
                                    setState(() {
                                      categoriaSelecionada = newValue;
                                      // dropdownValue = newValue;
                                      // var newDatabase = DatabaseModel();
                                      // newDatabase.host = "NOVO2";
                                      // newDatabase.name = newValue;
                                      // newDatabase.port = 1521;
                                      // newDatabase.user = "NOVO2";
                                      // newDatabase.serviceName = "NOVO2";

                                      // GlobalVariables.database = newDatabase;
                                      // GlobalVariables.storeState
                                      //     .dispatch(gv.Actions.SwitchDatabase);
                                    });
                                  },
                                  items: snapshot.data
                                      .map<DropdownMenuItem<TipoModel>>(
                                          (TipoModel item) {
                                    return DropdownMenuItem<TipoModel>(
                                      child: Text(item.descricao),
                                      value: item,
                                    );
                                  }).toList(),
                                );
                        },
                      ),
                    ],
                  ),
                ],
              ),
              SizedBox(height: 20.0),
              Container(
                child: RaisedButton(
                  // color: Color(int.parse("0x" + toHex(currentColor))),
                  color: Color(int.parse("0xFFF76041")),
                  onPressed: () => {salvarNoBanco()},
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Container(
                        child:
                            Image.asset("lib/img/Incluir-Categoria-Logo.png"),
                        height: 20,
                      ),
                      Text(
                        '  Incluir',
                        style: TextStyle(color: Color(0xFF2B1D3D)),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  salvarNoBanco() {
    OperacaoModel operacao = OperacaoModel();
    operacao.descricao = _controlerDescricao.text.toString();
    operacao.tipoOperacao = tipoOperacao;
    operacao.conta = contaSelecionada.documentId();
    operacao.categoria = categoriaSelecionada.documentId();
    operacao.saldoInicial = double.parse(_controlerSaldo.text.toString());
    _operacaoRepository.add(operacao);
    Navigator.of(context).pop();
  }
}
