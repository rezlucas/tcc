import 'package:flutter/material.dart';
import 'package:flutter_iconpicker/flutter_iconpicker.dart';
import 'package:tcc/models/tipomodel.dart';
import 'package:tcc/repositories/tiporepository.dart';
import 'package:tcc/screens/cadastros/tipos.dart';
import 'package:tcc/screens/template.dart';
import 'package:flutter_colorpicker/flutter_colorpicker.dart';
import 'package:tcc/services/colorpicker.dart';
import 'package:flutter_iconpicker/IconPicker/icons.dart';

class CadastrarCategoria extends StatefulWidget {
  @override
  _CadastrarCategoriaState createState() => _CadastrarCategoriaState();
}

class _CadastrarCategoriaState extends State<CadastrarCategoria> {
  Color currentColor = Colors.limeAccent;
  TipoRepository _tipoRepository = TipoRepository();
  TextEditingController _controlerDescricao = TextEditingController();
  void changeColor(Color color) => setState(() => currentColor = color);
  Icon _icon = Icon(IconData(58430, fontFamily: "MaterialIcons"));

  _pickIcon() async {
    debugPrint(_icon.icon.codePoint.toString());
    debugPrint(_icon.icon.fontFamily);
    IconData icon = await FlutterIconPicker.showIconPicker(context,
        iconPackMode: IconPack.material);

    _icon = Icon(icon);
    setState(() {});

    debugPrint('Picked Icon:  $icon');
  }

  // String toHex(Color cor) => '${cor.alpha.toRadixString(16).padLeft(2, '0')}'
  //     '${cor.red.toRadixString(16).padLeft(2, '0')}'
  //     '${cor.green.toRadixString(16).padLeft(2, '0')}'
  //     '${cor.blue.toRadixString(16).padLeft(2, '0')}';

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
              SizedBox(height: MediaQuery.of(context).size.height * 0.02),
              Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  RaisedButton(
                      color: Color(0xFFF76041),
                      elevation: 3.0,
                      onPressed: () {
                        _pickIcon();
                      },
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [_icon, Text(" Escolha um icone")],
                      ),

                      // child: const Text('Change me'),
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
    TipoModel tipo = TipoModel();
    tipo.descricao = _controlerDescricao.text.toString();
    tipo.idIcon = _icon.icon.codePoint;
    tipo.fontfamilyIcon = _icon.icon.fontFamily;
    _tipoRepository.add(tipo);
    Navigator.of(context).pop();
  }
}
