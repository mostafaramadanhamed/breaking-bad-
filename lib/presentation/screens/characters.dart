import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movie/bussnies_logic/cubit/movie_cubit.dart';
import 'package:movie/bussnies_logic/cubit/movie_state.dart';

import '../../data/models/characters.dart';

class CharactersScreen extends StatefulWidget {
  const CharactersScreen({Key? key}) : super(key: key);

  @override
  State<CharactersScreen> createState() => _CharactersScreenState();
}

class _CharactersScreenState extends State<CharactersScreen> {
  late List<Character>allCharacters;
  @override
  void initState() {
    super.initState();
    allCharacters=BlocProvider.of<CharactersCubit>(context).getAllCharacters();

  }
  Widget buildBlocWidget(){
    return BlocBuilder<CharactersCubit,CharactersState>(
      builder: (context,state){
        if(state is CharactersLoaded){
          allCharacters=state.characters;
          return buildLoadedListWidget();
        }else{
          return const Text('data');
        }
      },
    );
  }
  buildLoadedListWidget(){
   return SingleChildScrollView(
      child: Container(
        color: Colors.grey,
        child: Column(
          children: [
            buildCharactersList()
          ],
        ),
      ),
    );
  }
  buildCharactersList(){
    return GridView.builder(
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2,
        childAspectRatio: 2/3,
          crossAxisSpacing: 1,
          mainAxisSpacing: 1,
        ),
        itemBuilder: (context,index){
          return
        });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Characters'),
      ),
      body: buildBlocWidget(),
    );
  }
}
