import 'package:flutter/material.dart';
import 'package:tcc/services/auth.dart';

class Template extends StatelessWidget {
  final AuthService _auth = AuthService();

  Template({this.body, this.titulo});
  final Widget body;
  final String titulo;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Color(0xFFDDDDDD),
        appBar: AppBar(
          title: Text(titulo),
          backgroundColor: Color(0xFF6c68ad),
          elevation: 0.0,
          actions: <Widget>[
            FlatButton.icon(
              icon: Icon(Icons.person),
              label: Text('logout'),
              onPressed: () async {
                await _auth.signOut();
              },
            )
          ],
        ),
        body: this.body);
  }
}
