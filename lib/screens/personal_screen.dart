import 'package:flutter/material.dart';
import 'package:peliculas/providers/db_providers.dart';
import 'package:peliculas/models/models.dart';
import 'package:peliculas/providers/personal_list_provider.dart';
import 'package:provider/provider.dart';

class PersonalScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final personalListProvider =
        Provider.of<PersonalListProvider>(context, listen: false);
    return Scaffold(
        appBar: AppBar(
      leading: IconButton(
        icon: const Icon(Icons.filter_list),
        onPressed: () {},
        //Navigator.pushNamed(context, 'personal');
      ),
      centerTitle: true,
      title: const Text('Personal'),
      elevation: 10.0,
      actions: [
        IconButton(
          icon: const Icon(Icons.density_small_outlined),
          onPressed: () => PersonalListProvider(),
          //showSearch( context: context, delegate: MovieSearchDelegate() ),
        )
      ],
    ));
  }
}
