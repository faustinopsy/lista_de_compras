// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'compra.dart';

// **************************************************************************
// BeanGenerator
// **************************************************************************

abstract class _CompraConnection implements Bean<Compra> {
  final id = IntField('id');
  final produto = StrField('produto');
  final quantidade = DoubleField('quantidade');
  final medida = StrField('medida');
  final preco = DoubleField('preco');
  final imagem = StrField('imagem');
  final comprado = BoolField('comprado');
  final del = BoolField('del');
  Map<String, Field> _fields;
  Map<String, Field> get fields => _fields ??= {
        id.name: id,
        produto.name: produto,
        quantidade.name: quantidade,
        medida.name: medida,
        preco.name: preco,
        imagem.name: imagem,
        comprado.name: comprado,
        del.name: del,
      };
  Compra fromMap(Map map) {
    Compra model = Compra();
    model.id = adapter.parseValue(map['id']);
    model.produto = adapter.parseValue(map['produto']);
    model.quantidade = adapter.parseValue(map['quantidade']);
    model.medida = adapter.parseValue(map['medida']);
    model.preco = adapter.parseValue(map['preco']);
    model.imagem = adapter.parseValue(map['imagem']);
    model.comprado = adapter.parseValue(map['comprado']);
    model.del = adapter.parseValue(map['del']);

    return model;
  }

  List<SetColumn> toSetColumns(Compra model,
      {bool update = false, Set<String> only, bool onlyNonNull = false}) {
    List<SetColumn> ret = [];

    if (only == null && !onlyNonNull) {
      if (model.id != null) {
        ret.add(id.set(model.id));
      }
      ret.add(produto.set(model.produto));
      ret.add(quantidade.set(model.quantidade));
      ret.add(medida.set(model.medida));
      ret.add(preco.set(model.preco));
      ret.add(imagem.set(model.imagem));
      ret.add(comprado.set(model.comprado));
      ret.add(del.set(model.del));
    } else if (only != null) {
      if (model.id != null) {
        if (only.contains(id.name)) ret.add(id.set(model.id));
      }
      if (only.contains(produto.name)) ret.add(produto.set(model.produto));
      if (only.contains(quantidade.name))
        ret.add(quantidade.set(model.quantidade));
      if (only.contains(medida.name)) ret.add(medida.set(model.medida));
      if (only.contains(preco.name)) ret.add(preco.set(model.preco));
      if (only.contains(imagem.name)) ret.add(imagem.set(model.imagem));
      if (only.contains(comprado.name)) ret.add(comprado.set(model.comprado));
      if (only.contains(del.name)) ret.add(del.set(model.del));
    } else /* if (onlyNonNull) */ {
      if (model.id != null) {
        ret.add(id.set(model.id));
      }
      if (model.produto != null) {
        ret.add(produto.set(model.produto));
      }
      if (model.quantidade != null) {
        ret.add(quantidade.set(model.quantidade));
      }
      if (model.medida != null) {
        ret.add(medida.set(model.medida));
      }
      if (model.preco != null) {
        ret.add(preco.set(model.preco));
      }
      if (model.imagem != null) {
        ret.add(imagem.set(model.imagem));
      }
      if (model.comprado != null) {
        ret.add(comprado.set(model.comprado));
      }
      if (model.del != null) {
        ret.add(del.set(model.del));
      }
    }

    return ret;
  }

  Future<void> createTable({bool ifNotExists = false}) async {
    final st = Sql.create(tableName, ifNotExists: ifNotExists);
    st.addInt(id.name, primary: true, autoIncrement: true, isNullable: false);
    st.addStr(produto.name, isNullable: false);
    st.addDouble(quantidade.name, isNullable: false);
    st.addStr(medida.name, isNullable: false);
    st.addDouble(preco.name, isNullable: false);
    st.addStr(imagem.name, isNullable: true);
    st.addBool(comprado.name, isNullable: false);
    st.addBool(del.name, isNullable: false);
    return adapter.createTable(st);
  }

  Future<dynamic> insert(Compra model,
      {bool cascade = false,
      bool onlyNonNull = false,
      Set<String> only}) async {
    final Insert insert = inserter
        .setMany(toSetColumns(model, only: only, onlyNonNull: onlyNonNull))
        .id(id.name);
    var retId = await adapter.insert(insert);
//    if (cascade) {
//      Compra newModel;
//    }
    return retId;
  }

  Future<void> insertMany(List<Compra> models,
      {bool onlyNonNull = false, Set<String> only}) async {
    final List<List<SetColumn>> data = models
        .map((model) =>
            toSetColumns(model, only: only, onlyNonNull: onlyNonNull))
        .toList();
    final InsertMany insert = inserters.addAll(data);
    await adapter.insertMany(insert);
    return;
  }

  Future<dynamic> upsert(Compra model,
      {bool cascade = false,
      Set<String> only,
      bool onlyNonNull = false}) async {
    final Upsert upsert = upserter
        .setMany(toSetColumns(model, only: only, onlyNonNull: onlyNonNull))
        .id(id.name);
    var retId = await adapter.upsert(upsert);
//    if (cascade) {
//      Compra newModel;
//    }
    return retId;
  }

  Future<void> upsertMany(List<Compra> models,
      {bool onlyNonNull = false, Set<String> only}) async {
    final List<List<SetColumn>> data = [];
    for (var i = 0; i < models.length; ++i) {
      var model = models[i];
      data.add(
          toSetColumns(model, only: only, onlyNonNull: onlyNonNull).toList());
    }
    final UpsertMany upsert = upserters.addAll(data);
    await adapter.upsertMany(upsert);
    return;
  }

  Future<int> update(Compra model,
      {bool cascade = false,
      bool associate = false,
      Set<String> only,
      bool onlyNonNull = false}) async {
    final Update update = updater
        .where(this.id.eq(model.id))
        .setMany(toSetColumns(model, only: only, onlyNonNull: onlyNonNull));
    return adapter.update(update);
  }

  Future<void> updateMany(List<Compra> models,
      {bool onlyNonNull = false, Set<String> only}) async {
    final List<List<SetColumn>> data = [];
    final List<Expression> where = [];
    for (var i = 0; i < models.length; ++i) {
      var model = models[i];
      data.add(
          toSetColumns(model, only: only, onlyNonNull: onlyNonNull).toList());
      where.add(this.id.eq(model.id));
    }
    final UpdateMany update = updaters.addAll(data, where);
    await adapter.updateMany(update);
    return;
  }

  Future<Compra> find(int id,
      {bool preload = false, bool cascade = false}) async {
    final Find find = finder.where(this.id.eq(id));
    return await findOne(find);
  }

  Future<int> remove(int id) async {
    final Remove remove = remover.where(this.id.eq(id));
    return adapter.remove(remove);
  }

  Future<int> removeMany(List<Compra> models) async {
// Return if models is empty. If this is not done, all records will be removed!
    if (models == null || models.isEmpty) return 0;
    final Remove remove = remover;
    for (final model in models) {
      remove.or(this.id.eq(model.id));
    }
    return adapter.remove(remove);
  }
}
