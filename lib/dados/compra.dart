import 'package:jaguar_orm/jaguar_orm.dart';

part 'compra.jorm.dart';

//
// Sempre que esta classe for modificada o comando abaixo deve ser executado:
//
//  flutter packages pub run build_runner build --delete-conflicting-outputs
//

class Compra {
  @PrimaryKey(auto: true)
  int id;
  String produto;
  double quantidade;
  String medida;
  double preco;
  @Column(name: 'imagem', isNullable: true)
  String imagem;
  bool comprado;
  bool del;
}

@GenBean()
class CompraConnection extends Bean<Compra> with _CompraConnection {
  CompraConnection(Adapter adapter) : super(adapter);

  @override
  String get tableName => 'compras';
}