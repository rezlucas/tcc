import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:intl/intl.dart';
import 'package:tcc/repositories/cartaorepository.dart';
import 'package:tcc/screens/template.dart';

class Cartao extends StatefulWidget {
  Cartao({Key key}) : super(key: key);

  @override
  _CartaoState createState() => _CartaoState();
}

class _CartaoState extends State<Cartao> {
  TextEditingController _controlerDescricao = TextEditingController();
  CartaoRepository _cartaoRepository = CartaoRepository();
  DateTime _dateTime;
  final f = new DateFormat('dd/MM/yyyy');
  TimeOfDay _time;

  @override
  Widget build(BuildContext context) {
    return Template(
      titulo: "Cadastrar Cartão",
      body: SafeArea(
        child: Container(
          decoration: BoxDecoration(
              image: DecorationImage(
                  image:
                      AssetImage("lib/img/Background-Form-CartaoDeCredito.png"),
                  alignment: Alignment.topCenter,
                  fit: BoxFit.cover)),
          padding: EdgeInsets.symmetric(vertical: 100.0, horizontal: 50.0),
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
                SizedBox(height: 10.0),
                Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: <Widget>[
                        Text(
                          "Selecione uma data:",
                          style: TextStyle(color: Colors.black),
                        ),
                        GestureDetector(
                          onTap: () {
                            showDatePicker(
                                    context: context,
                                    initialDate: _dateTime == null
                                        ? DateTime.now()
                                        : _dateTime,
                                    firstDate: DateTime(2001),
                                    lastDate: DateTime(2021))
                                .then((date) {
                              setState(() {
                                _dateTime = date;
                              });
                            });
                          },
                          child: Container(
                            padding: EdgeInsets.all(8.0),
                            decoration: BoxDecoration(
                              border: Border(
                                bottom: BorderSide(
                                    width: 1.0, color: Color(0xFFF76041)),
                              ),
                            ),
                            child: Text(
                                _dateTime == null ? "" : f.format(_dateTime),
                                style: TextStyle(color: Colors.red),
                                textAlign: TextAlign.center),
                          ),
                        )
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
      ),
    );
  }

  salvarNoBanco() {
    // CartaoModel cartao = CartaoModel();
    // cartao.data = f.format(_dateTime);
    // cartao.descricao = _cartaoRepository.text.toString();
    // _cartaoRepository.add(operacao);
  }
}
