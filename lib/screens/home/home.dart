import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:tcc/screens/cadastros/cartao.dart';
import 'package:tcc/screens/cadastros/conta.dart';
import 'package:tcc/screens/cadastros/operacao.dart';
import 'package:tcc/repositories/operacaorepository.dart';
import 'package:tcc/screens/cadastros/tipos.dart';
import 'package:tcc/screens/template.dart';
import 'package:tcc/services/auth.dart';
import 'package:tcc/services/auth.dart';

class Home extends StatelessWidget {
  OperacaoRepository _operacaoRepository = OperacaoRepository();

  @override
  Widget build(BuildContext context) {
    return Template(
      titulo: "Home",
      body: Container(
        width: MediaQuery.of(context).size.width,
        decoration: BoxDecoration(
            image: DecorationImage(
                image: AssetImage("lib/img/Background-Home.png"),
                alignment: Alignment.topCenter,
                fit: BoxFit.cover)),
        child: Column(
          children: [
            Container(
              margin: EdgeInsets.only(top: 63, bottom: 65),
              alignment: Alignment.center,
              // color: Colors.black,
              height: 130,
              width: 180,
              child: StreamBuilder<Object>(
                  stream: _operacaoRepository.somarValor(),
                  builder: (context, snapshot) {
                    if (snapshot.hasData) {
                      return Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Text(
                            'R\$',
                            maxLines: 2,
                            overflow: TextOverflow.ellipsis,
                            style: TextStyle(
                              fontSize: 45,
                              fontFamily: "Dosis",
                              fontWeight: FontWeight.bold,
                              color: Color(0xFFF76041),
                            ),
                          ),
                          Text(
                            '${formatarDinheiro(snapshot.data)}',
                            maxLines: 2,
                            overflow: TextOverflow.ellipsis,
                            style: TextStyle(
                              fontSize: 35 -
                                  snapshot.data.toString().length.toDouble(),
                              fontFamily: "Dosis",
                              fontWeight: FontWeight.bold,
                              color: Color(0xFF2B1D3D),
                            ),
                          ),
                        ],
                      );
                    }
                    return Text(
                      'R\$ 0,00',
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                      style: TextStyle(
                        fontSize: 30,
                        fontFamily: "Dosis",
                        fontWeight: FontWeight.bold,
                        color: Colors.black,
                      ),
                    );
                  }),
            ),
            buildCard(
              context: context,
              imagem: "lib/img/Card-Operacao.png",
              nomeCard: "Operações",
              pagina: OperacaoPage(),
            ),
            buildCard(
              context: context,
              imagem: "lib/img/Card-Conta.png",
              nomeCard: "Contas",
              pagina: ContaPage(),
            ),
            buildCard(
              context: context,
              imagem: "lib/img/Card-Categoria.png",
              nomeCard: "Categorias",
              pagina: TiposPage(),
            ),
            // buildCard(
            //   context: context,
            //   imagem: "lib/img/Card-Cartao.png",
            //   nomeCard: "Cartão",
            //   pagina: Cartao(),
            // ),
          ],
        ),
      ),
    );
  }

  Widget buildCard(
      {String imagem, context, String nomeCard, StatefulWidget pagina}) {
    return GestureDetector(
      onTap: () => Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => pagina),
      ),
      child: Container(
        padding: EdgeInsets.symmetric(vertical: 10.0, horizontal: 20.0),
        child: Stack(
          children: <Widget>[
            Container(
              child: Container(
                margin: new EdgeInsets.fromLTRB(
                    true ? 76.0 : 16.0, true ? 06.0 : 42.0, 16.0, 16.0),
                // constraints: new BoxConstraints.expand(),
                child: new Column(
                  crossAxisAlignment: true
                      ? CrossAxisAlignment.center
                      : CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    new Container(height: 4.0),
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          nomeCard,
                          style: TextStyle(
                            fontSize: 24.0,
                            fontWeight: FontWeight.w300,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              height: true ? 100.0 : 154.0,
              margin: true
                  ? new EdgeInsets.only(left: 40.0)
                  : new EdgeInsets.only(top: 72.0),
              decoration: new BoxDecoration(
                color: new Color(0xFF2B1D3D),
                shape: BoxShape.rectangle,
                borderRadius: new BorderRadius.circular(8.0),
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
              margin: new EdgeInsets.symmetric(vertical: 5.0),
              alignment:
                  true ? FractionalOffset.centerLeft : FractionalOffset.center,
              child: new Hero(
                tag: nomeCard,
                child: Container(
                  child: ClipOval(
                    child: Image(
                      fit: BoxFit.fill,
                      alignment: Alignment.topRight,
                      image: AssetImage(imagem),
                    ),
                  ),
                  decoration: BoxDecoration(
                      color: Color(0xFFF76041),
                      borderRadius: BorderRadius.circular(100)),
                  height: 92.0,
                  width: 92.0,
                ),
              ),
            ),
          ],
        ),
      ),
    );

    Padding(
      padding: EdgeInsets.symmetric(vertical: 5.0, horizontal: 10),
      child: GestureDetector(
        onTap: () => Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => pagina),
        ),
        child: Container(
          child: new FittedBox(
            child: Material(
                color: Color(0xFF2B1D3D),
                elevation: 14.0,
                borderRadius: BorderRadius.circular(24.0),
                shadowColor: Color(0x802196F3),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    Container(
                      width: 350,
                      height: 100,
                      child: ClipRRect(
                        borderRadius: new BorderRadius.circular(24.0),
                        child: Row(
                          children: [
                            Container(
                              alignment: Alignment.center,
                              width: 250,
                              child: Text(
                                nomeCard,
                                style: TextStyle(
                                    fontSize: 20,
                                    fontFamily: "Dosis",
                                    // fontWeight: FontWeight.bold,
                                    color: Colors.white),
                              ),
                            ),
                            Image(
                              fit: BoxFit.contain,
                              alignment: Alignment.topRight,
                              image: AssetImage(imagem),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                )),
          ),
        ),
      ),
    );
  }
}

String formatarDinheiro(double preco) {
  var formato = NumberFormat("#,##0.00", "pt_BR");
  return formato.format(preco);
}
