import 'package:flutter/material.dart';
import 'package:peliculas/providers/db_providers.dart';

class PersonalScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    //TODO temporal leer la base de datos
    DBProvider.db.database;
    return const Scaffold(
        body: Center(
      child: Text('Personal Screen'),
    ));
  }
}
