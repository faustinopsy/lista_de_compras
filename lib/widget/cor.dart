import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Cor {
  final String nome;
  final ThemeData tema;

  Cor({@required this.nome, @required this.tema});
}

class CorNotifier with ChangeNotifier {
  final SharedPreferences _prefs;

  CorNotifier(this._prefs);

  Cor get corAtual {
    var nomeDaCor = _prefs.getString('cor');
    Cor cor = cores.firstWhere((cor) => cor.nome == nomeDaCor, orElse: () => null);
    return cor != null ? cor : cores[0];
  }

  setCorAtual(String nomeDaCor) async {
    await _prefs.setString('cor', nomeDaCor);
    notifyListeners();
  }
}

final cores = [
  Cor(
    nome: 'Amarelo',
    tema: ThemeData(
      primaryColor: Colors.amberAccent,
      primarySwatch: Colors.amber,
      accentColor: Colors.yellow[100],
      primaryColorLight: Colors.yellow[200]
    )
  ),
  Cor(
      nome: 'Verde',
      tema: ThemeData(
          primaryColor: Colors.lightGreenAccent,
          primarySwatch: Colors.lightGreen,
          accentColor: Colors.green[100],
          primaryColorLight: Colors.green[200]
      )
  ),
  Cor(
      nome: 'Azul',
      tema: ThemeData(
          primaryColor: Colors.lightBlueAccent,
          primarySwatch: Colors.lightBlue,
          accentColor: Colors.blue[100],
          primaryColorLight: Colors.blue[200]
      )
  ),
  Cor(
      nome: 'Rosa',
      tema: ThemeData(
          primaryColor: Colors.pinkAccent,
          primarySwatch: Colors.pink,
          accentColor: Colors.pink[100],
          primaryColorLight: Colors.pink[200]
      )
  ),
];