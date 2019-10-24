import 'package:flutter/material.dart';
import 'package:lista_de_compras/telas/edita_compra.dart';
import 'package:lista_de_compras/telas/lista_de_compras.dart';

void main() => runApp(MaterialApp(
 home: ListaDeCompras(),
  //home: EditaCompra(titulo:'Compras'),
  theme: ThemeData(
    //vvvv
    primaryColor: Colors.amberAccent,
    primarySwatch: Colors.amber,
    accentColor: Colors.yellow[100],
  ),
));


