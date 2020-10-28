import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:intl/intl.dart';
import 'package:tcc/models/contamodel.dart';
import 'package:tcc/models/operacaomodel.dart';
import 'package:tcc/models/tipomodel.dart';
import 'package:tcc/repositories/contarepository.dart';
import 'package:tcc/repositories/operacaorepository.dart';
import 'package:tcc/repositories/tiporepository.dart';
import 'package:tcc/screens/cadastros/operacaoform.dart';
import 'package:tcc/screens/cadastros/operacaoform.dart';
import 'package:tcc/screens/template.dart';
import 'package:popup_menu/popup_menu.dart';

class OperacaoPage extends StatefulWidget {
  OperacaoPage({Key key}) : super(key: key);

  @override
  _OperacaoPageState createState() => _OperacaoPageState();
}

class _OperacaoPageState extends State<OperacaoPage> {
  OperacaoRepository _operacaoRepository = OperacaoRepository();
  ContaRepository _contaRepository = ContaRepository();
  TipoRepository _tipoRepository = TipoRepository();

  // var operacao = _operacaoRepository.listarConta();

  @override
  Widget build(BuildContext context) {
    final ScrollController scrollController = ScrollController();
    PopupMenu.context = context;

    final baseTextStyle = const TextStyle(fontFamily: 'Poppins');

    final headerTextStyle = baseTextStyle.copyWith(
        color: Colors.white, fontSize: 18.0, fontWeight: FontWeight.w600);

    final regularTextStyle = baseTextStyle.copyWith(
      color: const Color(0xffb6b2df),
      fontSize: 9.0,
      fontWeight: FontWeight.w400,
    );

    final subHeaderTextStyle = regularTextStyle.copyWith(fontSize: 12.0);
    return Template(
      mostrarAcao: true,
      titulo: "Operações",
      floatAcaoPressionada: () => Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => CadastrarOperacao()),
      ),
      body: Container(
        decoration: BoxDecoration(
            image: DecorationImage(
                image: AssetImage("lib/img/background-full.png"),
                alignment: Alignment.topCenter,
                fit: BoxFit.cover)),
        child: StreamBuilder(
            stream: _operacaoRepository.listarOperacoes(),
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
                              var operacao =
                                  (snapshot.data[index] as OperacaoModel);
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
                                                Text(operacao.descricao,
                                                    style:
                                                        Style.titleTextStyle),
                                                GestureDetector(
                                                  onTapUp:
                                                      (TapUpDetails details) {
                                                    showPopup(
                                                        details.globalPosition,
                                                        operacao);
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
                                            new Text(
                                                "R\$ " +
                                                    formatarDinheiro(
                                                        operacao.saldoInicial),
                                                style: Style.titleTextStyle
                                                    .copyWith(
                                                  fontSize: 18,
                                                )),
                                            new Container(height: 6.0),
                                            FutureBuilder(
                                              future: _contaRepository
                                                  .findById(operacao.conta),
                                              builder: (context, snp) {
                                                if (snp.data == null) {
                                                  print("aqui");
                                                }
                                                if (snp.hasData &&
                                                    snp.data != null) {
                                                  return Column(
                                                    mainAxisAlignment:
                                                        MainAxisAlignment.start,
                                                    crossAxisAlignment:
                                                        CrossAxisAlignment
                                                            .start,
                                                    children: [
                                                      Text(snp.data.descricao,
                                                          style: Style
                                                              .commonTextStyle),
                                                      Container(
                                                        margin: new EdgeInsets
                                                                .symmetric(
                                                            vertical: 8.0),
                                                        height: 2.0,
                                                        width: 18.0,
                                                        color: new Color(
                                                            int.parse("0xFF" +
                                                                snp.data.cor)),
                                                      ),
                                                    ],
                                                  );
                                                }
                                                return Text("Carregando",
                                                    style:
                                                        Style.commonTextStyle);
                                              },
                                            ),
                                            new Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.center,
                                              children: <Widget>[
                                                new Expanded(
                                                  flex: true ? 1 : 0,
                                                  child: _planetValue(
                                                    hora: operacao.data +
                                                        " " +
                                                        operacao.hora,
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ],
                                        ),
                                      ),
                                      height: true ? 140.0 : 154.0,
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
                                          vertical: 25.0),
                                      alignment: true
                                          ? FractionalOffset.centerLeft
                                          : FractionalOffset.center,
                                      child: new Hero(
                                        tag:
                                            "planet-hero-${operacao.documentId()}",
                                        child: FutureBuilder(
                                          future: _contaRepository
                                              .findById(operacao.conta),
                                          builder: (context, snp) {
                                            if (snp.hasData &&
                                                snp.data != null) {
                                              if (snp.data == null) {
                                                print("aqui");
                                              }
                                              return FutureBuilder(
                                                future:
                                                    _tipoRepository.findById(
                                                        operacao.categoria),
                                                builder: (context, snpo) {
                                                  if (snpo.data == null) {
                                                    print("aqui");
                                                  }
                                                  if (snpo.hasData &&
                                                      snpo.data != null) {
                                                    return Container(
                                                      decoration: BoxDecoration(
                                                          color: Color(
                                                              int.parse("0xFF" +
                                                                  snp.data
                                                                      .cor)),
                                                          borderRadius:
                                                              BorderRadius
                                                                  .circular(
                                                                      100)),
                                                      height: 92.0,
                                                      width: 92.0,
                                                      child: Icon(
                                                          IconData(
                                                              (snpo.data
                                                                      as TipoModel)
                                                                  .getIdIcon,
                                                              fontFamily: (snpo
                                                                          .data
                                                                      as TipoModel)
                                                                  .getfontfamilyIcon),
                                                          color: eLight(
                                                              snp.data.cor)),
                                                    );
                                                  }
                                                  return Container(
                                                    child:
                                                        CircularProgressIndicator(),
                                                    height: 92,
                                                    width: 92,
                                                  );
                                                },
                                              );
                                            }
                                            return Container(
                                              child:
                                                  CircularProgressIndicator(),
                                              height: 92,
                                              width: 92,
                                            );
                                          },
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

  void showPopup(Offset offset, OperacaoModel operacao) {
    PopupMenu menu = PopupMenu(
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
        onClickMenu: (item) => onClickMenu(item, operacao),
        stateChanged: stateChanged,
        onDismiss: onDismiss);
    menu.show(rect: Rect.fromPoints(offset, offset));
  }

  void stateChanged(bool isShow) {
    // print('menu is ${isShow ? 'showing' : 'closed'}');
  }

  void onClickMenu(MenuItemProvider item, OperacaoModel operacaoModel) {
    if (item.menuTitle == 'Editar') {
      Navigator.push(
        context,
        MaterialPageRoute(
            builder: (context) => CadastrarOperacao.editar(operacaoModel)),
      );
    }
    if (item.menuTitle == 'Excluir') {
      print('Excluindo ${operacaoModel.descricao}');
      _operacaoRepository.delete(operacaoModel.documentId());
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
