import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:intl/intl.dart';
import 'package:tcc/models/operacaomodel.dart';
import 'package:tcc/repositories/operacaorepository.dart';
import 'package:tcc/screens/cadastros/operacaoform.dart';
import 'package:tcc/screens/cadastros/operacaoform.dart';
import 'package:tcc/screens/template.dart';

class OperacaoPage extends StatefulWidget {
  OperacaoPage({Key key}) : super(key: key);

  @override
  _OperacaoPageState createState() => _OperacaoPageState();
}

class _OperacaoPageState extends State<OperacaoPage> {
  OperacaoRepository _operacaoRepository = OperacaoRepository();

  // var operacao = _operacaoRepository.listarConta();

  @override
  Widget build(BuildContext context) {
    final ScrollController scrollController = ScrollController();
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
                              return Card(
                                color: Color(0xFFFFFFFF),
                                child: Container(
                                  padding: EdgeInsets.all(0),
                                  child: Row(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.center,
                                    // mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Container(
                                        alignment: Alignment.center,
                                        width:
                                            MediaQuery.of(context).size.width *
                                                .5,
                                        // height: 91,
                                        child: Text(
                                          operacao.descricao,
                                          maxLines: 2,
                                          overflow: TextOverflow.ellipsis,
                                          style: TextStyle(
                                              fontSize: 20,
                                              fontFamily: "Dosis",
                                              fontWeight: FontWeight.bold,
                                              color: Color(0xFF2B1D3D)),
                                        ),
                                      ),
                                      Container(
                                        alignment: Alignment.center,
                                        height: 130,
                                        width: 148.3,
                                        color: Color(
                                            int.parse("0x" + operacao.cor)),
                                        child: Text(
                                          'R\$ ${formatarDinheiro(operacao.saldoInicial)}',
                                          maxLines: 2,
                                          overflow: TextOverflow.ellipsis,
                                          style: TextStyle(
                                            fontSize: 30 -
                                                operacao.saldoInicial
                                                    .toString()
                                                    .length
                                                    .toDouble(),
                                            fontFamily: "Dosis",
                                            fontWeight: FontWeight.bold,
                                            color: Color(int.parse("0xFF" +
                                                (int.parse("0x" +
                                                            operacao.cor) ^
                                                        0xFFFFFFFF)
                                                    .toRadixString(16)
                                                    .padLeft(6, "0"))),
                                          ),
                                        ),
                                      )
                                    ],
                                  ),
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
}
