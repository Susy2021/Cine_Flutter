import 'package:flutter/material.dart';



import 'package:peliculas/widgets/widgets.dart';

class HomeScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          leading: IconButton(
            icon: const Icon(Icons.menu),
            onPressed:
                () {}, //TODO: ESTO ES PARA IR A LA PAGUINA DE PERSONAL!!!!
          ),
          centerTitle: true,
          title: const Text('Cine'),
          elevation: 10.0,
          actions: [
            IconButton(
                onPressed: () {}, icon: const Icon(Icons.search_outlined))
          ],
        ),
        body: SingleChildScrollView(
          child: Column(
            children: [
              // TARJETAS PRINCIPALES
              CardSwiper(),
              // SLIDER DE PELÍCULAS
              MovieSlider(),
            ],
          ),
        ));
  }
}
