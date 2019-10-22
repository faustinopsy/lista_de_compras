import 'package:flutter/material.dart';

class ListaDeCompras extends StatefulWidget {
  @override
  _ListaDeComprasState createState() => _ListaDeComprasState();
}

class _ListaDeComprasState extends State<ListaDeCompras> {
  bool modeDeEdicao =false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Lista de Compras'),
        actions: <Widget>[
          IconButton(
            iconSize: 28,
            icon: Icon(Icons.add, color: Colors.black),
            onPressed: (){},
          ),
          IconButton(
            iconSize: 28,
            icon: Icon(modeDeEdicao ? Icons.delete: Icons.edit, color:  Colors.black),
            onPressed: (){
              setState(() =>modeDeEdicao =!modeDeEdicao);
            },
          ),
        ],
      ),
    );
  }
}
