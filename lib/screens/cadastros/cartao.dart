import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_credit_card/credit_card_form.dart';
import 'package:flutter_credit_card/credit_card_model.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:intl/intl.dart';
import 'package:tcc/models/contamodel.dart';
import 'package:tcc/repositories/contarepository.dart';
import 'package:tcc/repositories/operacaorepository.dart';
import 'package:tcc/screens/cadastros/contaform.dart';
import 'package:tcc/screens/template.dart';
import 'package:flutter_credit_card/credit_card_widget.dart';

class Cartao extends StatefulWidget {
  Cartao({Key key}) : super(key: key);

  @override
  _CartaoState createState() => _CartaoState();
}

class _CartaoState extends State<Cartao> {
  String cardNumber = '';
  String expiryDate = '';
  String cardHolderName = '';
  String cvvCode = '';
  bool isCvvFocused = false;

  @override
  Widget build(BuildContext context) {
    return Template(
      titulo: "Cadastrar Cartão",
      body: SafeArea(
        child: Container(
          decoration: BoxDecoration(
              image: DecorationImage(
                  image: AssetImage("lib/img/Background-Form-Cartao.png"),
                  alignment: Alignment.topCenter,
                  fit: BoxFit.cover)),
          child: Column(
            children: <Widget>[
              CreditCardWidget(
                cardBgColor: Color(0xFFF76041).withOpacity(0),
                cardNumber: cardNumber,
                expiryDate: expiryDate,
                cardHolderName: cardHolderName,
                cvvCode: cvvCode,
                showBackView: isCvvFocused,
              ),
              Expanded(
                child: SingleChildScrollView(
                  child: CreditCardForm(
                    cursorColor: Color(0xFFF76041),
                    themeColor: Color(0xFFF76041),
                    textColor: Color(0xFFF76041),
                    onCreditCardModelChange: onCreditCardModelChange,
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }

  void onCreditCardModelChange(CreditCardModel creditCardModel) {
    setState(() {
      cardNumber = creditCardModel.cardNumber;
      expiryDate = creditCardModel.expiryDate;
      cardHolderName = creditCardModel.cardHolderName;
      cvvCode = creditCardModel.cvvCode;
      isCvvFocused = creditCardModel.isCvvFocused;
    });
  }
}
