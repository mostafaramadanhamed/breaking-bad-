import 'package:flutter/material.dart';
import 'package:movie/data/models/characters.dart';

import '../widgets/details_screen_widget.dart';

class CharacterDetailsScreen extends StatelessWidget {
  final Character character;
  const CharacterDetailsScreen({Key? key, required this.character}) : super(key: key);
 Widget buildSliverAppBar(){
   return SliverAppBar(
     expandedHeight: 600,
     pinned: true,
     stretch: true,
     flexibleSpace: FlexibleSpaceBar(
       centerTitle: true,
       title: Text(
         character.nickname,
       ),
       background: Hero(
         tag: character.charId,
         child: Image.network(character.img, fit: BoxFit.cover,)
       ),
     ),
   );
 }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.teal,
      body: CustomScrollView(
        physics:const BouncingScrollPhysics(),
        slivers: [
          buildSliverAppBar(),
          SliverList(delegate: SliverChildListDelegate(
            [
              Container(
                margin: const EdgeInsets.fromLTRB(14, 14, 14, 0),
                padding: const EdgeInsets.all(8.0),
                decoration:const BoxDecoration(),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    buildCharacterInfo(title: "Job", val: character.occupation.toString()),
                  ],
                ),
              ),
            ],
          ),)
        ],
      ),
    );
  }

}
