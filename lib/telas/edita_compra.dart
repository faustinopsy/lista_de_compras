import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:lista_de_compras/dados/compra.dart';
import 'package:lista_de_compras/dados/compras_dao.dart';


class EditaCompra extends StatefulWidget {
  final String titulo;
  final int compraId;

  EditaCompra({Key key, this.titulo, this.compraId=-1}) :super(key:key);

  @override
  _EditaCompraState createState() => _EditaCompraState();
}

class _EditaCompraState extends State<EditaCompra> {
  final _produtoCtrl = TextEditingController();
  final _produtoFocus = FocusNode();
  final _quantidadeCtrl = TextEditingController();
  final _quantidadeFocus = FocusNode();
  final _precoCtrl = TextEditingController();
  final _precoFocus = FocusNode();
  final _unidadeFocus = FocusNode();

  final _ftmValor = NumberFormat('#,##0.00','pt_BR');
  final _ftmQtd = NumberFormat('#,##0.##','pt_BR');
  final _formkey = GlobalKey<FormState>();
  final _borderPadding =16.0;
  final _unidadesMedida =['und.','l','ml','kg','gr','dz','m','pct','cx'];

  Compra _compraEditada;
  String _unidadeDeMedida;

  @override
  void initState() {
    super.initState();

    _compraEditada = Compra();
    _unidadeDeMedida = _unidadesMedida[0];

    _quantidadeFocus.addListener(() {
      if(_quantidadeFocus.hasFocus){
        _quantidadeCtrl.selection = TextSelection(
          baseOffset: 0,
          extentOffset: _quantidadeCtrl.text.length
        );
      }
    });

    _precoFocus.addListener((){
      if(_precoFocus.hasFocus){
        _precoCtrl.selection =TextSelection(
          baseOffset: 0,
          extentOffset: _precoCtrl.text.length
        );
      }
    });

    if(widget.compraId!=-1){
      ComprasDao.localizar(widget.compraId, (compra) async{
        setState(() {
          _compraEditada=compra;
          _produtoCtrl.text=compra.produto;
          _unidadeDeMedida =compra.medida;
          _quantidadeCtrl.text=_ftmQtd.format(compra.quantidade);
          _precoCtrl.text=_ftmValor.format(compra.preco);
        });
      });
    }

  }

  @override
  Widget build(BuildContext context) {
    return Container();
  }
}
