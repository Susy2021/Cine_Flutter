import 'package:flutter/material.dart';
import 'package:peliculas/providers/movies_provider.dart';

import 'package:peliculas/widgets/widgets.dart';
import 'package:provider/provider.dart';

class HomeScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final moviesProvider = Provider.of<MoviesProvider>(context);

    return Scaffold(
        appBar: AppBar(
          leading: IconButton(
            icon: const Icon(Icons.menu),
            onPressed:
                () {}, //TODO: ESTO ES PARA IR A LA PAGINA DE PERSONAL!!!!
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
              CardSwiper(movies: moviesProvider.onDisplayMovies),
              // SLIDER DE PELÍCULAS
              MovieSlider(
                movies: moviesProvider.popularMovies,
                title: 'Populares',
                onNextPage: () => moviesProvider.getPopularMovies() ,
              ),
            ],
          ),
        ));
  }
}
