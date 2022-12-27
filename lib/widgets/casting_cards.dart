
import 'package:flutter/material.dart';

class CastingCards extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 30),
      width: double.infinity,
      height: 180,
      color: Colors.deepOrangeAccent.shade400,
      child: ListView.builder(
        itemCount: 10,
        scrollDirection: Axis.horizontal,
        itemBuilder: ( _ , int index) => _CastCards()
        ),
    );
  }
}


class _CastCards extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 10),
      width: 150,
      height: 190,
      color: Colors.cyanAccent.shade400,
      child: Column(
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(20),
            child:const FadeInImage(
              placeholder: AssetImage('assets/no-image.jpg') ,
              image: NetworkImage('https://via.placeholder.com/150x300'),
              height: 150,
              width: 190,
              fit: BoxFit.cover,
            ),
          ),
          const SizedBox(width: 2),
          
          const Text(
            'actor.name jgahdgafhgajsgfbc bjahdhgaj',
            maxLines: 2,
            overflow: TextOverflow.ellipsis,
            textAlign: TextAlign.center,

            )
        ],
      ),
    );
  }
}