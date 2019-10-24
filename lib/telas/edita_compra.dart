import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:image_cropper/image_cropper.dart';
import 'package:image_picker/image_picker.dart';
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
obtemImagem() =>  _compraEditada.imagem!= null 
    ? Image.memory(Base64Decoder().convert(_compraEditada.imagem),
height: 180,
  width: MediaQuery.of(context).size.width - _borderPadding *2,
  fit: BoxFit.cover,
)
    : Image.asset('imagens/produtos.png',
height: 180,
  width: MediaQuery.of(context).size.width - _borderPadding *2,
  fit: BoxFit.cover,
);

  mudaFoco(BuildContext context, FocusNode atual, FocusNode proximo){
    atual.unfocus();
    FocusScope.of(context).requestFocus(proximo);
  }

  String _valida(String valor, String mensagem, NumberFormat fmt, {bool opcional = false}){
    try{
      if(valor.isNotEmpty){
        final qtd = fmt.parse(valor);
        if(qtd <0) return mensagem;
      }else {
        return opcional ? null : mensagem;
      }
      return null;
    }on Exception{
      return mensagem;
    }
  }



  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: ()=> FocusScope.of(context).requestFocus(FocusNode()),
      child: Scaffold(
        backgroundColor: Theme.of(context).accentColor,
        appBar: AppBar(
          title: Text(widget.titulo),
          actions: <Widget>[
            IconButton(
              iconSize: 28,
              icon: Icon(Icons.save, color: Colors.black54,),
              onPressed: (){
                if(_formkey.currentState.validate()){
                  _compraEditada
                    ..produto = _produtoCtrl.text
                    ..quantidade = _ftmQtd.parse(_quantidadeCtrl.text)
                    ..medida =_unidadeDeMedida
                    ..comprado=false
                    ..preco =_precoCtrl.text.isNotEmpty ? _ftmValor.parse(_precoCtrl.text) : 0
                    ..del = false;

                  ComprasDao.salvar(_compraEditada);

                  Navigator.pop(context);
                }
              },
            )
          ],
        ),
        body:  SafeArea(
          top: false,
          bottom: false,
          child: Form(
            key: _formkey,
            child: SingleChildScrollView(
              padding: EdgeInsets.all(_borderPadding),
              child: Column(
                children: <Widget>[

                  Padding(
                    padding: EdgeInsets.only(bottom: _borderPadding),
                    child: FlatButton(
                      padding: EdgeInsets.all(0),
                      child: obtemImagem(),
                      onPressed: (){
                        ImagePicker.pickImage(source: ImageSource.camera)
                        .then((arquivo){
                        if(arquivo == null) return;
                        //edita e recorta a foto
                        ImageCropper.cropImage(
                            sourcePath: arquivo.path,
                        maxHeight: 180,
                          maxWidth: 180
                        ).then((novoArquivo) async{
                          //salvva a foto
                          final bytes = await novoArquivo.readAsBytes();
                          setState(() {
                            _compraEditada.imagem = Base64Encoder().convert(bytes);
                          });
                        });
                        });
                      },
                    ),
                  ),
                  Column(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: <Widget>[
                      TextFormField(
                      controller: _produtoCtrl,
                        focusNode: _produtoFocus,
                        style: TextStyle(fontSize: 20),
                        decoration: InputDecoration(
                          labelText: 'Produto',
                          labelStyle: TextStyle(color: Colors.black45),
                          border: OutlineInputBorder()
                        ),
                        validator: (texto)=> texto.isEmpty ? 'Porduto Invalido' : null,
                          textInputAction: TextInputAction.next,
                        onFieldSubmitted: (_)=> mudaFoco(context, _produtoFocus, _quantidadeFocus),
                      ),
                      SizedBox(height: _borderPadding),
                      Row(
                        children: <Widget>[
                          Expanded(
                            child: TextFormField(
                              controller: _quantidadeCtrl,
                              focusNode: _quantidadeFocus,
                              style: TextStyle(fontSize: 20,color: Colors.black),
                              keyboardType: TextInputType.numberWithOptions(decimal: true),
                              decoration: InputDecoration(
                                labelText: 'Quantidade',
                                labelStyle: TextStyle(color: Colors.black54),
                                border: OutlineInputBorder()
                              ),
                              validator: (valor) => _valida(valor, 'Quantidade Invalida', _ftmQtd),
                              textInputAction: TextInputAction.next,
                              onFieldSubmitted: (_)=> mudaFoco(context, _quantidadeFocus, _unidadeFocus),
                            ),
                          ),
                          SizedBox(width: _borderPadding),
                          Expanded(
                            child: DropdownButtonFormField(
                              decoration: InputDecoration(
                                labelText: 'Unidade de Medida',
                                labelStyle: TextStyle(color: Colors.black54),
                                border: OutlineInputBorder()
                              ),
                              items: _unidadesMedida.map((medida)=>
                              DropdownMenuItem<String>(
                                value: medida,
                                child: Text( medida,
                                    style: TextStyle(fontSize: 20,color: Colors.black),
                                ),
                              )
                              ).toList(),
                              value: _unidadeDeMedida,
                              onChanged: (selecionado){
                                setState(() {
                                  _unidadeDeMedida=selecionado;
                                });
                              },
                            ),
                          )
                        ],
                      ),
                      SizedBox(height: _borderPadding),
                      TextFormField(
                        controller: _produtoCtrl,
                        focusNode: _precoFocus,
                        style: TextStyle(fontSize: 20),
                        keyboardType: TextInputType.numberWithOptions(decimal: true),
                        decoration: InputDecoration(
                          labelText: 'Preço Unitário',
                          labelStyle: TextStyle(color: Colors.black54),
                          prefixText: 'R\$',
                          border: OutlineInputBorder()
                        ),
                        validator: (valor) => _valida(valor, 'Preço Inválido', _ftmValor, opcional: true),
                        textInputAction: TextInputAction.done,
                      )
                    ],
                  )
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
