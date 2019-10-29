import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

Widget buildDrawer(BuildContext context) {
  return Drawer(
    child: ListView(
      padding: EdgeInsets.zero,
      children: <Widget>[
        DrawerHeader(
          child: Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: <Widget>[
              Column(
                mainAxisAlignment: MainAxisAlignment.end,
                children: <Widget>[
                  Text('Lista de Compras',
                    style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.w600,
                      fontSize: 20,
                      shadows: [
                        BoxShadow(color: Colors.grey[900], offset: Offset(2, 2))
                      ]
                    ),
                  ),
                ],
              )
            ],
          ),
          decoration: BoxDecoration(
            image: DecorationImage(
              fit: BoxFit.fill,
              image: AssetImage('imagens/drawer.png')
            )
          ),
        ),
        ListTile(
          title: Text("Cores"),
          leading: Icon(FontAwesomeIcons.palette),
          onTap: () =>Navigator.popAndPushNamed(context, '/cores'),
        )
      ],
    ),
  );
}


