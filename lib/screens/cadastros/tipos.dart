import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:tcc/models/tipomodel.dart';
import 'package:tcc/repositories/tiporepository.dart';
import 'package:tcc/screens/cadastros/tiposform.dart';
import 'package:tcc/screens/template.dart';

class TiposPage extends StatefulWidget {
  TiposPage({Key key}) : super(key: key);

  @override
  _TiposPageState createState() => _TiposPageState();
}

class _TiposPageState extends State<TiposPage> {
  TipoRepository _tipoRepository = TipoRepository();

  // var tipos = _tipoRepository.listarTipos();

  @override
  Widget build(BuildContext context) {
    final ScrollController scrollController = ScrollController();
    return Template(
      mostrarAcao: true,
      titulo: "Categorias",
      floatAcaoPressionada: () => Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => CadastrarCategoria()),
      ),
      body: Container(
        decoration: BoxDecoration(
            image: DecorationImage(
                image: AssetImage("lib/img/background-full.png"),
                alignment: Alignment.topCenter,
                fit: BoxFit.cover)),
        child: StreamBuilder(
          stream: _tipoRepository.listarTipos(),
          builder: (context, snapshot) => !snapshot.hasData
              ? Text("Carregando")
              : ListView(
                  scrollDirection: Axis.vertical,
                  children: <Widget>[
                    Container(
                      padding:
                          EdgeInsets.symmetric(vertical: 20.0, horizontal: 20),
                      height: MediaQuery.of(context).size.height * .85,
                      child: ListView.builder(
                        itemCount: snapshot.data.length,
                        shrinkWrap: true,
                        itemBuilder: (ctx, index) {
                          return Card(
                            color: Color(0xFFFFFFFF),
                            child: Container(
                              padding: EdgeInsets.all(0),
                              child: Row(
                                crossAxisAlignment: CrossAxisAlignment.center,
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Container(
                                    alignment: Alignment.center,
                                    width:
                                        MediaQuery.of(context).size.width * .7,
                                    // height: 91,
                                    child: Text(
                                      (snapshot.data[index] as TipoModel)
                                          .descricao,
                                      maxLines: 2,
                                      overflow: TextOverflow.ellipsis,
                                      style: TextStyle(
                                          fontSize: 20,
                                          fontFamily: "Dosis",
                                          // fontWeight: FontWeight.bold,
                                          color: Color(0xFF2B1D3D)),
                                    ),
                                  ),
                                  Container(
                                    height: 80,
                                    width: 69.5,
                                    color: Color(int.parse("0x" +
                                        (snapshot.data[index] as TipoModel)
                                            .cor)),
                                  )
                                ],
                              ),
                            ),
                          );
                        },
                      ),
                    ),
                  ],
                ),
        ),
      ),
    );
  }
}
