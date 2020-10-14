import 'package:flutter/material.dart';
import 'package:tcc/screens/cadastros/conta.dart';
import 'package:tcc/screens/cadastros/operacao.dart';
import 'package:tcc/screens/cadastros/tipos.dart';
import 'package:tcc/screens/template.dart';
import 'package:tcc/services/auth.dart';
import 'package:tcc/services/auth.dart';

class Home extends StatelessWidget {
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
            buildCard(
              context: context,
              imagem: "lib/img/Card-Operacao.png",
              nomeCard: "Registrar nova Operação",
              pagina: OperacaoPage(),
            ),
            buildCard(
              context: context,
              imagem: "lib/img/Card-Conta.png",
              nomeCard: "Registrar nova Conta",
              pagina: ContaPage(),
            ),
            buildCard(
              context: context,
              imagem: "lib/img/Card-Categoria.png",
              nomeCard: "Registrar nova Categoria",
              pagina: TiposPage(),
            ),
            buildCard(
              context: context,
              imagem: "lib/img/Card-Cartao.png",
              nomeCard: "Registrar novo Cartão",
            ),
          ],
        ),
      ),
    );
  }

  Widget buildCard(
      {String imagem, context, String nomeCard, StatefulWidget pagina}) {
    return Padding(
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
