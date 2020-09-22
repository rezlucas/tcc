import 'package:flutter/material.dart';
import 'package:tcc/screens/cadastros/tipos.dart';
import 'package:tcc/screens/template.dart';

class CadastrarCategoria extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Template(
      titulo: "Cadastrar novo Categoria",
      body: Container(
        padding: EdgeInsets.symmetric(vertical: 20.0, horizontal: 50.0),
        child: Form(
          child: ListView(
            children: <Widget>[
              SizedBox(height: MediaQuery.of(context).size.height * 0.3),
              TextFormField(
                decoration: InputDecoration(
                    hintText: 'Descrição',
                    hintStyle: TextStyle(color: Colors.black),
                    labelStyle: TextStyle(
                      color: Colors.white,
                    )),
              ),
              SizedBox(height: MediaQuery.of(context).size.height * 0.02),
              TextFormField(
                decoration: InputDecoration(
                  hintText: 'Senha',
                  hintStyle: TextStyle(color: Colors.black),
                ),
                obscureText: true,
              ),
              SizedBox(height: 20.0),
              Container(
                child: RaisedButton(
                  color: Color(0xFF3EBDEB),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Container(
                        child: Image.asset("lib/img/Logar-Logo.png"),
                        height: 20,
                      ),
                      Text(
                        '  Logar',
                        style: TextStyle(color: Colors.white),
                      ),
                    ],
                  ),
                ),
              ),
              // RaisedButton(
              //     color: Color(0xFF6b65ac),
              //     child: Text(
              //       'Logar',
              //       style: TextStyle(color: Color(0xFFffffff)),
              //     ),
              //     onPressed: () async {
              //       print(email);
              //       print(password);
              //     }),
              InkWell(
                child: Align(
                  alignment: Alignment.topCenter,
                  child: Padding(
                    padding: const EdgeInsets.all(10.0),
                    child: Text('Esqueci minha senha!',
                        style: TextStyle(
                            fontWeight: FontWeight.w500, color: Colors.black)),
                  ),
                ),
              ),
              SizedBox(height: 10.0),

              // Divider(
              //   height: 64,
              //   thickness: 0.6,
              //   color: Colors.black,
              // ),
              SizedBox(height: 20.0),
            ],
          ),
        ),
      ),
    );
  }
}
