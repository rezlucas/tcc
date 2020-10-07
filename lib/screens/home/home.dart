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
      body: Column(
        children: [
          RaisedButton(
              onPressed: () => Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => TiposPage()),
                  ),
              elevation: 3.0,
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [Icon(Icons.access_alarm), Text("Categorias")],
              ),

              // child: const Text('Change me'),
              textColor: Colors.black),
          RaisedButton(
              onPressed: () => Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => ContaPage()),
                  ),
              elevation: 3.0,
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [Icon(Icons.accessibility_new), Text("Contas")],
              ),

              // child: const Text('Change me'),
              textColor: Colors.black),
          RaisedButton(
              onPressed: () => Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => OperacaoPage()),
                  ),
              elevation: 3.0,
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [Icon(Icons.arrow_downward), Text("Operações")],
              ),

              // child: const Text('Change me'),
              textColor: Colors.black),
        ],
      ),
    );
  }
}
