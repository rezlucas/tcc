import 'dart:ffi';

import 'package:flutter/material.dart';
import 'package:tcc/models/contamodel.dart';
import 'package:tcc/repositories/contarepository.dart';
import 'package:tcc/screens/cadastros/conta.dart';
import 'package:tcc/screens/template.dart';
import 'package:flutter_colorpicker/flutter_colorpicker.dart';
import 'package:tcc/services/colorpicker.dart';

class CadastrarConta extends StatefulWidget {
  @override
  _CadastrarContaState createState() {
    return conta == null
        ? _CadastrarContaState()
        : _CadastrarContaState.editar(conta);
  }

  ContaModel conta;
  CadastrarConta();
  CadastrarConta.editar(this.conta);
}

class _CadastrarContaState extends State<CadastrarConta> {
  Color currentColor = Color(0xFFF76041);
  ContaRepository _contaRepository = ContaRepository();
  TextEditingController _controlerDescricao = TextEditingController();
  TextEditingController _controlerSaldo = TextEditingController();
  void changeColor(Color color) => setState(() => currentColor = color);

  String toHex(Color cor) => '${cor.alpha.toRadixString(16).padLeft(2, '0')}'
      '${cor.red.toRadixString(16).padLeft(2, '0')}'
      '${cor.green.toRadixString(16).padLeft(2, '0')}'
      '${cor.blue.toRadixString(16).padLeft(2, '0')}';

  _CadastrarContaState();

  _CadastrarContaState.editar(this._contaEditar) {}

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      preencherDados(_contaEditar);
    });

    // preencherDados(_operacaoEditar);
  }

  void preencherDados(ContaModel operacao) async {
    setState(() {
      _controlerDescricao.text = _contaEditar.descricao;
      _controlerSaldo.text = _contaEditar.saldoInicial.toString();
      currentColor = Color(int.parse("0xFF" + _contaEditar.cor));
    });
  }

  ContaModel _contaEditar;
  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Template(
      titulo: "Incluir nova Conta",
      body: Container(
        decoration: BoxDecoration(
            image: DecorationImage(
                image: AssetImage("lib/img/Background-Form-Conta.png"),
                alignment: Alignment.topCenter,
                fit: BoxFit.cover)),
        padding: EdgeInsets.symmetric(vertical: 100.0, horizontal: 50.0),
        child: Form(
          key: _formKey,
          child: ListView(
            children: <Widget>[
              SizedBox(height: MediaQuery.of(context).size.height * 0.3),
              TextFormField(
                style: TextStyle(color: Color(0xFF2B1D3D)),
                controller: _controlerDescricao,
                validator: (value) {
                  if (value.isEmpty) {
                    return "Preencha o nome da conta";
                  }
                  return null;
                },
                decoration: InputDecoration(
                    hintText: 'Conta',
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
                validator: (value) {
                  if (value.isEmpty) {
                    return "Preencha o saldo";
                  }
                  return null;
                },
                keyboardType: TextInputType.number,
                decoration: InputDecoration(
                    hintText: 'Saldo Inicial',
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
                  RaisedButton(
                      elevation: 3.0,
                      onPressed: () {
                        showDialog(
                          context: context,
                          builder: (BuildContext context) {
                            return AlertDialog(
                              titlePadding: const EdgeInsets.all(0.0),
                              contentPadding: const EdgeInsets.all(0.0),
                              content: SingleChildScrollView(
                                child: ColorPicker(
                                  pickerColor: currentColor,
                                  onColorChanged: changeColor,
                                  colorPickerWidth: 300.0,
                                  pickerAreaHeightPercent: 0.7,
                                  enableAlpha: true,
                                  displayThumbColor: true,
                                  showLabel: true,
                                  paletteType: PaletteType.hsv,
                                  pickerAreaBorderRadius:
                                      const BorderRadius.only(
                                    topLeft: const Radius.circular(2.0),
                                    topRight: const Radius.circular(2.0),
                                  ),
                                ),
                              ),
                            );
                          },
                        );
                      },
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [Icon(Icons.colorize), Text(" Cor")],
                      ),

                      // child: const Text('Change me'),
                      color: currentColor,
                      textColor: Color(0xFF2B1D3D)),
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
                        _contaEditar == null ? '  Incluir' : '  Editar',
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
    if (_formKey.currentState.validate()) {
      if (_contaEditar == null) {
        ContaModel conta = ContaModel();
        conta.descricao = _controlerDescricao.text.toString();
        conta.cor = toHex(currentColor);
        conta.saldoInicial = double.parse(_controlerSaldo.text.toString());
        _contaRepository.add(conta);
        Navigator.of(context).pop();
      } else {
        _contaEditar.descricao = _controlerDescricao.text.toString();
        _contaEditar.cor = toHex(currentColor);
        _contaEditar.saldoInicial =
            double.parse(_controlerSaldo.text.toString());
        _contaRepository.update(_contaEditar.documentId(), _contaEditar);
        Navigator.of(context).pop();
      }
    }
  }
}
