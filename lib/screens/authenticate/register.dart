import 'package:flutter/material.dart';
import 'package:tcc/services/auth.dart';

class Register extends StatefulWidget {
  final Function toggleView;
  Register({this.toggleView});

  @override
  _RegisterState createState() => _RegisterState();
}

class _RegisterState extends State<Register> {
  final AuthService _auth = AuthService();

  String email = '';
  String password = '';

  bool _passwordVisible = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: Container(
        decoration: BoxDecoration(
            image: DecorationImage(
                image: AssetImage("lib/img/Background-Registrar.png"),
                alignment: Alignment.topCenter,
                fit: BoxFit.cover)),
        padding: EdgeInsets.symmetric(vertical: 100.0, horizontal: 50.0),
        child: Form(
          child: ListView(
            children: <Widget>[
              SizedBox(height: MediaQuery.of(context).size.height * 0.3),
              TextFormField(
                  style: TextStyle(color: Color(0xFF2B1D3D)),
                  decoration: InputDecoration(
                      hintText: 'Email',
                      enabledBorder: UnderlineInputBorder(
                        borderSide: BorderSide(color: Color(0xFFF76041)),
                      ),
                      focusedBorder: UnderlineInputBorder(
                        borderSide: BorderSide(color: Color(0xFF2B1D3D)),
                      ),
                      hintStyle: TextStyle(color: Colors.black),
                      labelStyle: TextStyle(
                        color: Colors.white,
                      )),
                  onChanged: (val) {
                    setState(() => email = val);
                  }),
              SizedBox(height: MediaQuery.of(context).size.height * 0.02),
              TextFormField(
                  style: TextStyle(color: Color(0xFF2B1D3D)),
                  decoration: InputDecoration(
                    suffixIcon: IconButton(
                      icon: Icon(
                        // Based on passwordVisible state choose the icon
                        _passwordVisible
                            ? Icons.visibility
                            : Icons.visibility_off,
                        color: Theme.of(context).primaryColorDark,
                      ),
                      onPressed: () {
                        // Update the state i.e. toogle the state of passwordVisible variable
                        setState(() {
                          _passwordVisible = !_passwordVisible;
                        });
                      },
                    ),
                    hintText: 'Senha',
                    enabledBorder: UnderlineInputBorder(
                      borderSide: BorderSide(color: Color(0xFFF76041)),
                    ),
                    focusedBorder: UnderlineInputBorder(
                      borderSide: BorderSide(color: Color(0xFF2B1D3D)),
                    ),
                    hintStyle: TextStyle(color: Colors.black),
                  ),
                  obscureText: _passwordVisible,
                  onChanged: (val) {
                    setState(() => password = val);
                  }),
              SizedBox(height: 20.0),
              TextFormField(
                  style: TextStyle(color: Color(0xFF2B1D3D)),
                  decoration: InputDecoration(
                    suffixIcon: IconButton(
                      icon: Icon(
                        // Based on passwordVisible state choose the icon
                        _passwordVisible
                            ? Icons.visibility
                            : Icons.visibility_off,
                        color: Theme.of(context).primaryColorDark,
                      ),
                      onPressed: () {
                        // Update the state i.e. toogle the state of passwordVisible variable
                        setState(() {
                          _passwordVisible = !_passwordVisible;
                        });
                      },
                    ),
                    hintText: 'Digite a senha novamente',
                    enabledBorder: UnderlineInputBorder(
                      borderSide: BorderSide(color: Color(0xFFF76041)),
                    ),
                    focusedBorder: UnderlineInputBorder(
                      borderSide: BorderSide(color: Color(0xFF2B1D3D)),
                    ),
                    hintStyle: TextStyle(color: Colors.black),
                  ),
                  obscureText: _passwordVisible,
                  onChanged: (val) {
                    // setState(() => password = val);
                  }),
              SizedBox(height: 20.0),
              Container(
                child: RaisedButton(
                    color: Color(0xFFF76041),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Container(
                          child: Image.asset("lib/img/Logar-Logo.png"),
                          height: 20,
                        ),
                        Text(
                          '  Cadastrar',
                          style: TextStyle(color: Colors.white),
                        ),
                      ],
                    ),
                    onPressed: () async {
                      print(email);
                      print(password);
                    }),
              ),
              InkWell(
                onTap: () async {
                  widget.toggleView();
                },
                child: Align(
                  alignment: Alignment.topCenter,
                  child: Padding(
                    padding: const EdgeInsets.all(10.0),
                    child: Text('Já sou Cadastrado!',
                        style: TextStyle(
                            fontWeight: FontWeight.w500, color: Colors.black)),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
