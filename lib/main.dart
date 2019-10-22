import 'package:flutter/material.dart';
import 'package:lista_de_compras/telas/lista_de_compras.dart';

void main() => runApp(MaterialApp(
  home: ListaDeCompras(),
  theme: ThemeData(
    primaryColor: Colors.amberAccent,
    primarySwatch: Colors.amber,
    accentColor: Colors.yellow[100],
  ),
));


