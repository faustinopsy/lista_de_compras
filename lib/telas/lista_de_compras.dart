import 'dart:collection';
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import 'package:lista_de_compras/dados/compra.dart';
import 'package:lista_de_compras/dados/compras_dao.dart';
import 'package:lista_de_compras/widget/drawer.dart';

import 'edita_compra.dart';

class ListaDeCompras extends StatefulWidget {
  @override
  _ListaDeComprasState createState() => _ListaDeComprasState();
}

class _ListaDeComprasState extends State<ListaDeCompras> {
  bool modoDeEdicao = false;

  _mostraDialogo({ @required Function onTrue,  @required Function onFalse }) {
    return showDialog<bool>(
      context: context,
      barrierDismissible: false,
      builder: (context) {
        return AlertDialog(
          title: Text('Atenção'),
          content: Text('Confirma a exclusão da(s) Compra(s)?'),
          actions: <Widget>[
            RaisedButton(
              child: Text('Sim'),
              textColor: Colors.white,
              color: Colors.red,
              onPressed: onTrue,
            ),
            RaisedButton(
              child: Text('Não'),
              textColor: Colors.white,
              color: Colors.green,
              onPressed: onFalse,
            ),
          ],
        );
      }
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Lista de Compras'),
        actions: <Widget>[
          IconButton(
            iconSize: 28,
            icon: Icon(Icons.add, color: Colors.black),                          // <====
            onPressed: () async {
              await Navigator.push(context,
                MaterialPageRoute(builder: (context) => EditaCompra(titulo: 'Compra'))
              );
            },
          ),
          IconButton(
            iconSize: 28,
            icon: Icon(modoDeEdicao ? Icons.delete : Icons.edit, color: Colors.black),          // <====
            onPressed: () {
              if(modoDeEdicao) {
                ComprasDao.verificaMarcados(() =>
                  _mostraDialogo(
                    onTrue: () {
                      ComprasDao.removeMarcados();
                      Navigator.of(context).pop();
                    },
                    onFalse: () {
                      ComprasDao.desmarcaTodos();
                      Navigator.of(context).pop();
                    }
                  )
                );
              }
              setState(() => modoDeEdicao = !modoDeEdicao);
            },
          ),
        ],
      ),
      body: Container(
        padding: EdgeInsets.only(top: 4),
        color: Colors.yellow[200],                                                   // <====
        child: RefreshIndicator(
          onRefresh: () => ComprasDao().reloadStream(),
          child: StreamBuilder<UnmodifiableListView<Compra>>(
            stream: ComprasDao().compras,
            initialData: UnmodifiableListView<Compra>([]),
            builder: (context, snapshot) => ListView(
              children: snapshot.data.map(constroiItens).toList(),
            ),
          ),
        ),
      ),
      drawer: buildDrawer(context),
    );
  }

  Widget constroiItens(Compra compra) {
    final fmtValor = NumberFormat('#,##0.00', 'pt_BR');
    final fmtQtd = NumberFormat('#,##0.##', 'pt_BR');

    return InkWell(
      key: Key('${compra.id}'),
      onLongPress: () {
        ComprasDao.salvar(compra..comprado = !compra.comprado);
      },
      child: Padding(
        padding: EdgeInsets.fromLTRB(4, 2, 4, 2),
        child: GestureDetector(
          onTap: () async {
            await Navigator.push(context,
                MaterialPageRoute(builder: (context) =>
                    EditaCompra(titulo: 'Modificar a Compra', compraId: compra.id)
                )
            );
          },
          child: Card(
            margin: EdgeInsets.all(0),
            elevation: 1,
            color: compra.comprado ? Colors.lime : Theme.of(context).accentColor,
            child: Row(
              children: <Widget>[
                compra.imagem != null
                  ? Image.memory(Base64Decoder().convert(compra.imagem), height: 80, width: 80)
                  : Image.asset('imagens/produtos.png', height: 80, width: 80, fit: BoxFit.cover),
                SizedBox(width: 8),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Text(compra.produto,
                      style: Theme.of(context).textTheme.title),
                    Text('${fmtQtd.format(compra.quantidade)} ${compra.medida}',
                      style: Theme.of(context).textTheme.subtitle),
                    Text(compra.preco > 0 ? 'R\$ ${fmtValor.format(compra.preco)}' : '',
                      style: Theme.of(context).textTheme.body1)
                  ],
                ),
                Spacer(),
                modoDeEdicao
                  ? Checkbox(
                      value: compra.del,
                      activeColor: Colors.lightGreen,
                      checkColor: Colors.yellow,
                      onChanged: (selecionado) {
                        ComprasDao.salvar(compra..del = selecionado);
                      },
                    )
                  : Container()
              ],
            ),
          ),
        ),
      ),
    );
  }
}
