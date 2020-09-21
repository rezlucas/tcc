import 'package:flutter/material.dart';
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
          IconButton(
              icon: Icon(
                Icons.new_releases,
                color: Colors.white12,
              ),
              onPressed: () => Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => TiposPage()),
                  ))
        ],
      ),
    );
  }
}
