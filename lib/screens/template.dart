import 'package:flutter/material.dart';
import 'package:tcc/services/auth.dart';

class Template extends StatelessWidget {
  final AuthService _auth = AuthService();

  Template(
      {this.body,
      this.titulo,
      this.mostrarAcao = false,
      this.floatAcaoPressionada});
  final Widget body;
  final String titulo;
  final bool mostrarAcao;
  final Function floatAcaoPressionada;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        //backgroundColor: Color(0xFFDDDDDD),
        floatingActionButton: !mostrarAcao
            ? null
            : FloatingActionButton(
                child: Icon(Icons.add),
                backgroundColor: Color(0xFFF76041),
                onPressed: floatAcaoPressionada,
              ),
        floatingActionButtonLocation: FloatingActionButtonLocation.endFloat,
        appBar: AppBar(
          title: Text(titulo),
          centerTitle: true,
          backgroundColor: Color(0xFFF76041),
          elevation: 0.0,
          actions: <Widget>[
            IconButton(
              icon: Icon(Icons.exit_to_app),
              onPressed: () async {
                await _auth.signOut();
              },
            )
          ],
        ),
        body: this.body);
  }
}
