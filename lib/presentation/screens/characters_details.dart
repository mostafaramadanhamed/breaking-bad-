import 'dart:math';

import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movie/bussnies_logic/cubit/movie_cubit.dart';
import 'package:movie/bussnies_logic/cubit/movie_state.dart';
import 'package:movie/data/models/characters.dart';

import '../widgets/details_screen_widget.dart';

class CharacterDetailsScreen extends StatelessWidget {
  final Character character;
  const CharacterDetailsScreen({Key? key, required this.character}) : super(key: key);
 Widget buildSliverAppBar(){
   return SliverAppBar(
     elevation: 0,
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
Widget checkIfQuotesAreLoaded(CharactersState state){
   if(state is QuotesLoaded){
     return displayRandomQuoteOrEmptySpace(state);
   }
   else{
     return const Center(child: CircularProgressIndicator(color: Colors.tealAccent,),);
   }
}
  Widget displayRandomQuoteOrEmptySpace(state){
   var quotes=(state).quotes;
   if(quotes.lenght > 0){
     int randomQuoteIndex=Random().nextInt(quotes.lenght-1);
     return  SizedBox(
       width: 250.0,
       child: DefaultTextStyle(
         textAlign: TextAlign.center,
         style: const TextStyle(
           fontSize: 20.0,
           color: Colors.tealAccent,
           shadows: [
             Shadow(
               blurRadius: 7,
               color: Colors.tealAccent,
               offset: Offset(0, 0),
             )
           ],
         ),
         child: AnimatedTextKit(

           animatedTexts: [
             TyperAnimatedText(quotes[randomQuoteIndex].qoute),
           ],
         ),
       ),
     );
   }
   else{
     return Container();
   }

  }
  @override
  Widget build(BuildContext context) {
   BlocProvider.of<CharactersCubit>(context).getCharactersQuotes(character.name);
    return Scaffold(
      backgroundColor: Colors.blueGrey.shade800,
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
                    buildCharacterInfo(title: "Actor name", val: character.name),
                    buildDivider(endIndent: MediaQuery.of(context).size.width/1.43,),
                    buildCharacterInfo(title: "Job", val: character.occupation.join('/')),
                    buildDivider(endIndent: MediaQuery.of(context).size.width/1.21,),
                    buildCharacterInfo(title: "Appeared in ", val: character.category),
                    buildDivider(endIndent: MediaQuery.of(context).size.width/1.46,),
                    buildCharacterInfo(title: "Seasons", val: character.appearance.join('/')),
                    buildDivider(endIndent: MediaQuery.of(context).size.width/1.338,),
                    buildCharacterInfo(title: "Portrayed", val: character.portrayed),
                    buildDivider(endIndent: MediaQuery.of(context).size.width/1.369,),
                    buildCharacterInfo(title: "Status", val: character.status),
                    buildDivider(endIndent: MediaQuery.of(context).size.width/1.28,),
                    if(character.betterCallSaulAppearance.isNotEmpty)
                      buildCharacterInfo(title: "betterCallSaulAppearance", val: character.betterCallSaulAppearance.join('/')),
                    if(character.betterCallSaulAppearance.isNotEmpty)
                      buildDivider(endIndent: MediaQuery.of(context).size.width/2.1,),
                    const SizedBox(
                      height: 20,
                    ),
                    BlocBuilder<CharactersCubit,CharactersState>(
                        builder: (context,state){
                          return checkIfQuotesAreLoaded(state);
                        },
                    ),
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
