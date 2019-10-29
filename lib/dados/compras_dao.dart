import 'dart:collection';

import 'package:bloc_pattern/bloc_pattern.dart';
import 'package:jaguar_orm/jaguar_orm.dart';
import 'package:jaguar_query_sqflite/jaguar_query_sqflite.dart';
import 'package:rxdart/rxdart.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart' as Path;

import 'package:lista_de_compras/dados/compra.dart';

typedef FuncaoSql = void Function(CompraConnection conexao);

class ComprasDao extends BlocBase {
  static final ComprasDao _instancia = ComprasDao._();
  factory ComprasDao() => _instancia;
  CompraConnection _conn;
  final _compraObserver = BehaviorSubject<UnmodifiableListView<Compra>>();

  ComprasDao._() : super() {
    // Faz a inicialização do Stream de Dados
    db((_) async { });
  }

  Stream<UnmodifiableListView<Compra>> get compras => _compraObserver.stream;

  static salvar(Compra compra) => _instancia.db((conn) => conn.upsert(compra));

  static localizar(int id, Future carrega(Compra compra)) => _instancia.db((conn) =>
    conn.find(id).then((compra) => carrega(compra)));

  static verificaMarcados(Function apresentaAlerta) => _instancia.db((conn) => {
    conn.findOneWhere(BoolField('del').eq(true)).then((compra) => {
      if(compra != null)
        apresentaAlerta()
    })
  });

  static removeMarcados() => _instancia.db((conn) => conn.removeWhere(BoolField('del').eq(true)));

  static desmarcaTodos() => _instancia.db((conn) => conn.updateFields(BoolField('del').eq(true), {'del': false}));

  @override
  void dispose() {
    super.dispose();
    _compraObserver.close();
  }

  db(FuncaoSql executaSql) {
    if(_conn == null) {
      getDatabasesPath().then((path) => _criaDatabase(path, executaSql));
    } else {
      executaSql(_conn);
      reloadStream();
    }
  }

  _criaDatabase(String path, FuncaoSql executaSql) {
    String destino = Path.join(path, 'compras.dat');
    Adapter adapter = SqfliteAdapter(destino, version: 1);

    adapter.connect().then((_) => _conectaDatabase(adapter, executaSql));
  }

  _conectaDatabase(Adapter adapter, FuncaoSql executaSql) {
    CompraConnection conn = CompraConnection(adapter);
    conn.createTable(ifNotExists: true).then((_) {
      _conn = conn;
      executaSql(conn);
      reloadStream();
    });
  }

  Future<void> reloadStream() async {
    if(_conn != null) {
      _conn.getAll().then((compras) {
        compras.sort((a, b) {
          var aComprado = a.comprado ? 1 : 0;
          var bComprado = b.comprado ? 1 : 0;
          if(aComprado > bComprado)
            return 1;
          else if(aComprado < bComprado)
            return -1;
          else
            return a.produto.compareTo(b.produto);
        });
        _compraObserver.add(UnmodifiableListView(compras));
      });
    }
  }

}