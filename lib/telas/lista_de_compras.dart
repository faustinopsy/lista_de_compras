import 'dart:collection';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:lista_de_compras/dados/compra.dart';
import 'package:lista_de_compras/dados/compras_dao.dart';

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
      body: Container(
        padding: EdgeInsets.only(top: 4),
        color: Colors.yellow[200],
        child: RefreshIndicator(
          onRefresh: ()=> ComprasDao().reloadStream(),
          child: StreamBuilder<UnmodifiableListView<Compra>>(
            stream: ComprasDao().compras,
            initialData: UnmodifiableListView<Compra>([]),
            builder: (context, snapshot)=>ListView(
              children: snapshot.data.map(constroiItens).toList(),
            ),
          ),
        ),
      ),
    );
  }
  Widget controiItens(Compra compra)
}
