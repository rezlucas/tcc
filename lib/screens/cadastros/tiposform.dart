import 'package:flutter/material.dart';
import 'package:tcc/screens/cadastros/tipos.dart';
import 'package:tcc/screens/template.dart';
import 'package:flutter_colorpicker/flutter_colorpicker.dart';
import 'package:tcc/services/colorpicker.dart';

class CadastrarCategoria extends StatefulWidget {
  @override
  _CadastrarCategoriaState createState() => _CadastrarCategoriaState();
}

class _CadastrarCategoriaState extends State<CadastrarCategoria> {
  Color currentColor = Colors.limeAccent;

  void changeColor(Color color) => setState(() => currentColor = color);

  String toHex(Color cor) => '${cor.alpha.toRadixString(16).padLeft(2, '0')}'
      '${cor.red.toRadixString(16).padLeft(2, '0')}'
      '${cor.green.toRadixString(16).padLeft(2, '0')}'
      '${cor.blue.toRadixString(16).padLeft(2, '0')}';

  @override
  Widget build(BuildContext context) {
    return Template(
      titulo: "Incluir nova Categoria",
      body: Container(
        decoration: BoxDecoration(
            image: DecorationImage(
                image: AssetImage("lib/img/Background-Form-Categoria.png"),
                alignment: Alignment.topCenter,
                fit: BoxFit.cover)),
        padding: EdgeInsets.symmetric(vertical: 20.0, horizontal: 50.0),
        child: Form(
          child: ListView(
            children: <Widget>[
              SizedBox(height: MediaQuery.of(context).size.height * 0.3),
              TextFormField(
                decoration: InputDecoration(
                    hintText: 'Descrição',
                    hintStyle: TextStyle(color: Colors.black),
                    labelStyle: TextStyle(
                      color: Colors.white,
                    )),
              ),
              SizedBox(height: MediaQuery.of(context).size.height * 0.02),
              Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
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
                        child: Image.asset("lib/img/Select-Color.png"),
                        // child: const Text('Change me'),
                        color: currentColor,
                        textColor: Colors.black54),
                  ],
                ),
              ),
              SizedBox(height: 20.0),
              Container(
                child: RaisedButton(
                  // color: Color(int.parse("0x" + toHex(currentColor))),
                  color: Color(int.parse("0xFFA5E31B")),
                  onPressed: () => {print(toHex(currentColor))},
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
                        style: TextStyle(color: Colors.black),
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
}
