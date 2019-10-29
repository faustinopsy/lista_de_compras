import 'package:flutter/material.dart';
import 'package:lista_de_compras/telas/lista_de_compras.dart';
import 'package:lista_de_compras/telas/seleciona_cores.dart';
import 'package:lista_de_compras/widget/cor.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

void main() async  {
  var prefs = await SharedPreferences.getInstance();
  runApp(
    ChangeNotifierProvider<CorNotifier>(
      builder: (_) => CorNotifier(prefs),
      child: MainApp(),
    )
  );
}

class MainApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final notificadorDeCor = Provider.of<CorNotifier>(context);
    return MaterialApp(
      theme: notificadorDeCor.corAtual.tema,
      initialRoute: '/',
      routes: {
        '/' : (context) => ListaDeCompras(),
        '/cores' : (context) => SelecionaCores()
      },
    );
  }
}
