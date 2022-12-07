import 'package:flutter/material.dart';

const pFonte = TextStyle(
  color: Colors.white,
  fontWeight: FontWeight.bold,
  fontFamily: 'OpenSans',
);

Container pContainer(Widget child) {
  return Container(
    decoration: pDecoration,
    child: child,
  );
}

const pShadow = BoxShadow(
  color: Colors.grey,
  offset: Offset(5, 5),
  blurRadius: 7,
  spreadRadius: 2,
);

final pDecoration = BoxDecoration(
  color: Colors.white,
  borderRadius: BorderRadius.circular(10.0),
  boxShadow: const [
    BoxShadow(
      color: Colors.black12,
      blurRadius: 3.0,
      offset: Offset(5, 5),
    ),
  ],
);

const pTitulo = TextStyle(
  color: Colors.black54,
  fontSize: 17.0,
  fontWeight: FontWeight.w500,
);
