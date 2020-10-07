import 'package:flutter/material.dart';
import 'package:tcc/screens/home/home.dart';
import 'package:tcc/services/auth.dart';
import 'package:flutter_facebook_login/flutter_facebook_login.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:firebase_auth/firebase_auth.dart';

final FirebaseAuth _auth = FirebaseAuth.instance;
final GoogleSignIn googleSignIn = GoogleSignIn();

Future<String> signInWithGoogle() async {
  final GoogleSignInAccount googleSignInAccount = await googleSignIn.signIn();
  final GoogleSignInAuthentication googleSignInAuthentication =
      await googleSignInAccount.authentication;

  final AuthCredential credential = GoogleAuthProvider.getCredential(
    accessToken: googleSignInAuthentication.accessToken,
    idToken: googleSignInAuthentication.idToken,
  );

  final AuthResult authResult = await _auth.signInWithCredential(credential);
  final FirebaseUser user = authResult.user;

  assert(!user.isAnonymous);
  assert(await user.getIdToken() != null);

  final FirebaseUser currentUser = await _auth.currentUser();
  assert(user.uid == currentUser.uid);

  return 'signInWithGoogle succeeded: $user';
}

void signOutGoogle() async {
  await googleSignIn.signOut();

  print("User Sign Out");
}

class SignIn extends StatefulWidget {
  final Function toggleView;
  SignIn({this.toggleView});

  @override
  _SignInState createState() => _SignInState();
}

class _SignInState extends State<SignIn> {
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
                image: AssetImage("lib/img/Background-Login.png"),
                alignment: Alignment.topCenter,
                fit: BoxFit.cover)),
        padding: EdgeInsets.symmetric(vertical: 83.0, horizontal: 50.0),
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
                      hintStyle: TextStyle(color: Color(0xFF2B1D3D)),
                      labelStyle: TextStyle(
                        color: Color(0xFFF76041),
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
                    hintStyle: TextStyle(color: Color(0xFF2B1D3D)),
                  ),
                  obscureText: _passwordVisible,
                  onChanged: (val) {
                    setState(() => password = val);
                  }),
              SizedBox(height: 5.0),
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
                          '  Logar',
                          style: TextStyle(color: Colors.white),
                        ),
                      ],
                    ),
                    onPressed: () async {
                      print(email);
                      print(password);
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => Home()),
                      );
                    }),
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
              SizedBox(height: 0.0),
              InkWell(
                child: Align(
                  alignment: Alignment.topCenter,
                  child: Padding(
                    padding: const EdgeInsets.all(10.0),
                    child: Text('Entrar com:',
                        style: TextStyle(
                            fontWeight: FontWeight.w500,
                            color: Color(0xFF8b8b8b))),
                  ),
                ),
              ),

              Container(
                child: RaisedButton(
                  color: Color(0xFFEB3128),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Container(
                        child: Image.asset("lib/img/Gmail-Logo.png"),
                        height: 20,
                      ),
                      Text(
                        '  Gmail',
                        style: TextStyle(color: Colors.white),
                      ),
                    ],
                  ),
                  onPressed: () {
                    signInWithGoogle().whenComplete(() {
                      Navigator.of(context).push(
                        MaterialPageRoute(
                          builder: (context) {
                            return Home();
                          },
                        ),
                      );
                    });
                  },
                ),
              ),
              RaisedButton(
                  color: Color(0xFF3374b9),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Container(
                        child: Image.asset("lib/img/Facebook-Logo.png"),
                        height: 20,
                      ),
                      Text(
                        '  Facebook',
                        style: TextStyle(color: Colors.white),
                      ),
                    ],
                  ),
                  onPressed: () async {
                    print(email);
                    print(password);
                  }),
              InkWell(
                onTap: () async {
                  widget.toggleView();
                },
                child: Align(
                  alignment: Alignment.topCenter,
                  child: Padding(
                    padding: const EdgeInsets.all(10.0),
                    child: Text('Ainda não tenho cadastro',
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
