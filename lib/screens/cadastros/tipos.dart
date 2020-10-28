import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:popup_menu/popup_menu.dart';
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
            builder: (context, snapshot) {
              return !snapshot.hasData
                  ? Text("Carregando")
                  : ListView(
                      scrollDirection: Axis.vertical,
                      children: <Widget>[
                        Container(
                          padding: EdgeInsets.symmetric(
                              vertical: 20.0, horizontal: 20),
                          height: MediaQuery.of(context).size.height * .85,
                          child: ListView.builder(
                            itemCount: snapshot.data.length,
                            shrinkWrap: true,
                            itemBuilder: (ctx, index) {
                              var tipo = (snapshot.data[index] as TipoModel);
                              return Container(
                                padding: EdgeInsets.symmetric(vertical: 10.0),
                                child: Stack(
                                  children: <Widget>[
                                    Container(
                                      child: Container(
                                        margin: new EdgeInsets.fromLTRB(
                                            true ? 76.0 : 16.0,
                                            true ? 16.0 : 42.0,
                                            16.0,
                                            16.0),
                                        constraints:
                                            new BoxConstraints.expand(),
                                        child: new Column(
                                          crossAxisAlignment: true
                                              ? CrossAxisAlignment.start
                                              : CrossAxisAlignment.center,
                                          children: <Widget>[
                                            new Container(height: 4.0),
                                            Row(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              mainAxisAlignment:
                                                  MainAxisAlignment
                                                      .spaceBetween,
                                              children: [
                                                Text(tipo.descricao,
                                                    style:
                                                        Style.titleTextStyle),
                                                GestureDetector(
                                                  onTapUp:
                                                      (TapUpDetails details) {
                                                    showPopup(
                                                        details.globalPosition,
                                                        tipo,
                                                        context);
                                                  },
                                                  child: Icon(
                                                    Icons.more_vert,
                                                    size: 20,
                                                    color: Colors.grey[100],
                                                  ),
                                                )
                                              ],
                                            ),
                                            new Container(height: 6.0),
                                            Container(
                                              margin: new EdgeInsets.symmetric(
                                                  vertical: 8.0),
                                              height: 2.0,
                                              width: 18.0,
                                              color: Color(0xFFF76041),
                                            ),
                                          ],
                                        ),
                                      ),
                                      height: true ? 120.0 : 154.0,
                                      margin: true
                                          ? new EdgeInsets.only(left: 46.0)
                                          : new EdgeInsets.only(top: 72.0),
                                      decoration: new BoxDecoration(
                                        color: new Color(0xFF2B1D3D),
                                        shape: BoxShape.rectangle,
                                        borderRadius:
                                            new BorderRadius.circular(8.0),
                                        boxShadow: <BoxShadow>[
                                          new BoxShadow(
                                            color: Colors.black12,
                                            blurRadius: 10.0,
                                            offset: new Offset(0.0, 10.0),
                                          ),
                                        ],
                                      ),
                                    ),
                                    Container(
                                      margin: new EdgeInsets.symmetric(
                                          vertical: 15.0),
                                      alignment: true
                                          ? FractionalOffset.centerLeft
                                          : FractionalOffset.center,
                                      child: new Hero(
                                        tag: "planet-hero-${tipo.documentId()}",
                                        child: Container(
                                          decoration: BoxDecoration(
                                              color: Color(0xFFF76041),
                                              borderRadius:
                                                  BorderRadius.circular(100)),
                                          height: 92.0,
                                          width: 92.0,
                                          child: Icon(
                                              IconData(tipo.getIdIcon,
                                                  fontFamily:
                                                      (tipo).getfontfamilyIcon),
                                              color: Colors.white),
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              );
                            },
                          ),
                        ),
                      ],
                    );
            }),
        // Card(
        //   shape: RoundedRectangleBorder(
        //       borderRadius: BorderRadius.circular(18)),
        //   color: Color(0xFFFFFFFF),
        //   child: Container(
        //     padding: EdgeInsets.all(0),
        //     child: Row(
        //       crossAxisAlignment: CrossAxisAlignment.center,
        //       mainAxisAlignment: MainAxisAlignment.center,
        //       children: [
        //         Container(
        //           alignment: Alignment.center,
        //           width:
        //               MediaQuery.of(context).size.width * .7,
        //           // height: 91,
        //           child: Text(
        //             (snapshot.data[index] as TipoModel)
        //                 .descricao,
        //             maxLines: 2,
        //             overflow: TextOverflow.ellipsis,
        //             style: TextStyle(
        //                 fontSize: 20,
        //                 fontFamily: "Dosis",
        //                 // fontWeight: FontWeight.bold,
        //                 color: Color(0xFF2B1D3D)),
        //           ),
        //         ),
        //         Container(
        //           decoration: BoxDecoration(
        //               color: Color(0xFFF76041),
        //               borderRadius: BorderRadius.only(
        //                   topRight: Radius.circular(18),
        //                   bottomRight: Radius.circular(18))),
        //           child: Row(
        //             crossAxisAlignment:
        //                 CrossAxisAlignment.center,
        //             mainAxisAlignment:
        //                 MainAxisAlignment.center,
        //             // textColor: Color(0xFF2B1D3D),
        //             children: [
        //               Icon(IconData(
        //                   (snapshot.data[index] as TipoModel)
        //                       .getIdIcon,
        //                   fontFamily: (snapshot.data[index]
        //                           as TipoModel)
        //                       .getfontfamilyIcon)),
        //             ],
        //           ),
        //           height: 90,
        //           width: 69.5,
        //         ),
        //       ],
        //     ),
        //   ),
        // );
      ),
    );
  }

  void showPopup(Offset offset, TipoModel tipo, context) {
    PopupMenu menu = PopupMenu(
        context: context,
        backgroundColor: Color(0xFF2B1D3D),
        // lineColor: Colors.tealAccent,
        maxColumn: 2,
        items: [
          MenuItem(
              title: 'Editar',
              image: Icon(Icons.edit, color: Color(0xFFF76041))),
          MenuItem(
              title: 'Excluir',
              image: Icon(
                Icons.delete_forever,
                color: Color(0xFFF76041),
              )),
        ],
        onClickMenu: (item) => onClickMenu(item, tipo),
        stateChanged: stateChanged,
        onDismiss: onDismiss);
    menu.show(rect: Rect.fromPoints(offset, offset));
  }

  void stateChanged(bool isShow) {
    // print('menu is ${isShow ? 'showing' : 'closed'}');
  }

  void onClickMenu(MenuItemProvider item, TipoModel tipoModel) {
    if (item.menuTitle == 'Editar') {
      Navigator.push(
        context,
        MaterialPageRoute(
            builder: (context) => CadastrarCategoria.editar(tipoModel)),
      );
    }
    if (item.menuTitle == 'Excluir') {
      _tipoRepository.delete(tipoModel.documentId());
    }
  }

  void onDismiss() {
    // print('Menu is dismiss');
  }
}

class Style {
  static final baseTextStyle = const TextStyle(fontFamily: 'Poppins');
  static final smallTextStyle = commonTextStyle.copyWith(
    fontSize: 9.0,
  );
  static final commonTextStyle = baseTextStyle.copyWith(
    color: const Color(0xffb6b2df),
    fontSize: 14.0,
    fontWeight: FontWeight.w400,
  );
  static final titleTextStyle = baseTextStyle.copyWith(
    color: Colors.white,
    fontSize: 18.0,
    fontWeight: FontWeight.w600,
  );
  static final headerTextStyle = baseTextStyle.copyWith(
    color: Colors.white,
    fontSize: 20.0,
    fontWeight: FontWeight.w400,
  );
}
