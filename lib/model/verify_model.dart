import 'package:flutter/material.dart';

class VerifyModel{
  String _type;
  String _email;


  String get type => _type;
  String get email => _email;

  set email(String value) {
    _email = value;
  }

  set type(String value) {
    _type = value;
  }

  VerifyModel(this._type,this._email);
}