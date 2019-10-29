import 'package:flutter/material.dart';
import 'package:lista_de_compras/widget/cor.dart' show cores, CorNotifier;
import 'package:provider/provider.dart';

class SelecionaCores extends StatefulWidget {
  @override
  _SelecionaCoresState createState() => _SelecionaCoresState();
}

class _SelecionaCoresState extends State<SelecionaCores> {
  var cor;
  var nomeDaCorAtual;
  @override
  Widget build(BuildContext context) {
    cor = Provider.of<CorNotifier>(context);
    nomeDaCorAtual = cor.corAtual.nome;
    return Scaffold(
      appBar: AppBar(
        title: Text('Cores'),
      ),
      body: Padding(
        padding: EdgeInsets.all(16),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            ListView.builder(
                itemBuilder: (context,i) => montaRadio(i),
              scrollDirection: Axis.vertical,
              shrinkWrap: true,
              itemCount: cores.length,
            )
          ],
        ),
      ),
    );
  }

  Widget montaRadio(int i){
    return RadioListTile(
      activeColor: Colors.blue,
      title: Text(cores[i].nome,style: TextStyle(fontSize: 20)),
      value: cores[i].nome,
      groupValue: nomeDaCorAtual,
      onChanged: (nomeDaCor) => cor.setCorAtual(nomeDaCor),
    );
  }

}
