import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:intl/intl.dart';
import 'package:popup_menu/popup_menu.dart';
import 'package:tcc/models/contamodel.dart';
import 'package:tcc/models/operacaomodel.dart';
import 'package:tcc/repositories/contarepository.dart';
import 'package:tcc/repositories/operacaorepository.dart';
import 'package:tcc/screens/cadastros/contaform.dart';
import 'package:tcc/screens/template.dart';

class ContaPage extends StatefulWidget {
  ContaPage({Key key}) : super(key: key);

  @override
  _ContaPageState createState() => _ContaPageState();
}

class _ContaPageState extends State<ContaPage> {
  ContaRepository _contaRepository = ContaRepository();
  OperacaoRepository _operacaoRepository = OperacaoRepository();

  // var conta = _contaRepository.listarConta();

  @override
  Widget build(BuildContext context) {
    final ScrollController scrollController = ScrollController();
    return Template(
      mostrarAcao: true,
      titulo: "Contas",
      floatAcaoPressionada: () => Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => CadastrarConta()),
      ),
      body: Container(
        decoration: BoxDecoration(
            image: DecorationImage(
                image: AssetImage("lib/img/background-full.png"),
                alignment: Alignment.topCenter,
                fit: BoxFit.cover)),
        child: StreamBuilder(
            stream: _contaRepository.listarContas(),
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
                              var conta = (snapshot.data[index] as ContaModel);
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
                                                Text(conta.descricao,
                                                    style:
                                                        Style.titleTextStyle),
                                                GestureDetector(
                                                  onTapUp:
                                                      (TapUpDetails details) {
                                                    showPopup(
                                                        details.globalPosition,
                                                        conta,
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
                                            StreamBuilder(
                                                stream: _operacaoRepository
                                                    .somarValor(
                                                        saldoInicial:
                                                            conta.saldoInicial,
                                                        idConta:
                                                            conta.documentId()),
                                                builder: (context, snapshot) {
                                                  if (snapshot.hasData) {
                                                    return Text(
                                                        'R\$ ${formatarDinheiro(snapshot.data)}',
                                                        maxLines: 2,
                                                        overflow: TextOverflow
                                                            .ellipsis,
                                                        style: Style
                                                            .titleTextStyle
                                                            .copyWith(
                                                          fontSize: 18,
                                                        ));
                                                  }
                                                  return Text("Carregando",
                                                      style: Style
                                                          .titleTextStyle
                                                          .copyWith(
                                                        fontSize: 18,
                                                      ));
                                                }),
                                            Container(
                                              margin: new EdgeInsets.symmetric(
                                                  vertical: 8.0),
                                              height: 2.0,
                                              width: 18.0,
                                              color: new Color(int.parse(
                                                  "0xFF" + conta.cor)),
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
                                        tag:
                                            "planet-hero-${conta.documentId()}",
                                        child: Container(
                                          decoration: BoxDecoration(
                                              color: Color(int.parse(
                                                  "0xFF" + conta.cor)),
                                              borderRadius:
                                                  BorderRadius.circular(100)),
                                          height: 92.0,
                                          width: 92.0,
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              );
                              // Card(
                              //   shape: RoundedRectangleBorder(
                              //       borderRadius: BorderRadius.circular(18)),
                              //   color: Color(0xFFFFFFFF),
                              //   child: Container(
                              //     padding: EdgeInsets.all(0),
                              //     child: Row(
                              //       crossAxisAlignment:
                              //           CrossAxisAlignment.center,
                              //       // mainAxisAlignment: MainAxisAlignment.center,
                              //       children: [
                              //         Container(
                              //           alignment: Alignment.center,
                              //           width:
                              //               MediaQuery.of(context).size.width *
                              //                   .5,
                              //           // height: 91,
                              //           child: Text(
                              //             conta.descricao,
                              //             maxLines: 2,
                              //             overflow: TextOverflow.ellipsis,
                              //             style: TextStyle(
                              //                 fontSize: 20,
                              //                 fontFamily: "Dosis",
                              //                 fontWeight: FontWeight.bold,
                              //                 color: Color(0xFF2B1D3D)),
                              //           ),
                              //         ),
                              //         Container(
                              //           alignment: Alignment.center,
                              //           height: 90,
                              //           width: 148.3,
                              //           decoration: BoxDecoration(
                              //               color: Color(
                              //                   int.parse("0x" + conta.cor)),
                              //               borderRadius: BorderRadius.only(
                              //                   topRight: Radius.circular(18),
                              //                   bottomRight:
                              //                       Radius.circular(18))),
                              // child: StreamBuilder(
                              //     stream:
                              //         _operacaoRepository.somarValor(
                              //             saldoInicial:
                              //                 conta.saldoInicial,
                              //             idConta:
                              //                 conta.documentId()),
                              //     builder: (context, snapshot) {
                              //       if (snapshot.hasData) {
                              //         return Text(
                              //           'R\$ ${formatarDinheiro(snapshot.data)}',
                              //           maxLines: 2,
                              //           overflow:
                              //               TextOverflow.ellipsis,
                              //           style: TextStyle(
                              //             fontSize: 30 -
                              //                 snapshot.data
                              //                     .toString()
                              //                     .length
                              //                     .toDouble(),
                              //             fontFamily: "Dosis",
                              //             fontWeight: FontWeight.bold,
                              //             color: eLight(conta.cor),
                              //           ),
                              //         );
                              //       }
                              //       return Text(
                              //         'R\$ 0,00',
                              //         maxLines: 2,
                              //         overflow: TextOverflow.ellipsis,
                              //         style: TextStyle(
                              //           fontSize: 30,
                              //           fontFamily: "Dosis",
                              //           fontWeight: FontWeight.bold,
                              //           color: eLight(conta.cor),
                              //         ),
                              //       );
                              //     }),
                              //         )
                              //       ],
                              //     ),
                              //   ),
                              // );
                            },
                          ),
                        ),
                      ],
                    );
            }),
      ),
    );
  }

  String formatarDinheiro(double preco) {
    var formato = NumberFormat("#,##0.00", "pt_BR");
    return formato.format(preco);
  }

  Color eLight(String hex) {
    Color color = Color(int.parse("0xFF" + hex));
    final double relativeLuminance = color.computeLuminance();
    const double kThreshold = 0.15;
    if ((relativeLuminance + 0.05) * (relativeLuminance + 0.05) > kThreshold)
      return Colors.black;
    return Colors.white;
  }

  void showPopup(Offset offset, ContaModel conta, context) {
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
        onClickMenu: (item) => onClickMenu(item, conta),
        stateChanged: stateChanged,
        onDismiss: onDismiss);
    menu.show(rect: Rect.fromPoints(offset, offset));
  }

  void stateChanged(bool isShow) {
    // print('menu is ${isShow ? 'showing' : 'closed'}');
  }

  void onClickMenu(MenuItemProvider item, ContaModel contaModel) {
    if (item.menuTitle == 'Editar') {
      print('Editando ${contaModel.descricao}');
    }
    if (item.menuTitle == 'Excluir') {
      print('Excluindo ${contaModel.descricao}');
      _contaRepository.delete(contaModel.documentId());
    }
  }

  void onDismiss() {
    // print('Menu is dismiss');
  }

  Widget _planetValue({String hora}) {
    return new Container(
      child: new Row(mainAxisSize: MainAxisSize.min, children: <Widget>[
        new Icon(
          Icons.timer,
          size: 12,
        ),
        new Container(width: 8.0),
        new Text(hora, style: Style.smallTextStyle),
      ]),
    );
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
