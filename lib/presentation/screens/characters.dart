import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movie/bussnies_logic/cubit/movie_cubit.dart';
import 'package:movie/bussnies_logic/cubit/movie_state.dart';
import 'package:movie/constants/colors.dart';
import 'package:movie/presentation/widgets/character_item.dart';

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
   BlocProvider.of<CharactersCubit>(context).getAllCharacters();

  }
  Widget buildBlocWidget(){
    return BlocBuilder<CharactersCubit,CharactersState>(
      builder: (context,state){
        if(state is CharactersLoaded){
          allCharacters=state.characters;
          return buildLoadedListWidget();
        }else{
          return showLoadingIndicator();
        }
      },
    );
  }
  Widget showLoadingIndicator(){
    return const Center(child:  CircularProgressIndicator(color: MyColors.primaryColor,));
   }

  Widget buildLoadedListWidget(){
   return SingleChildScrollView(
      child: Container(
        color:MyColors.primaryColor.shade200,
        child: Column(
          children: [
            buildCharactersList()
          ],
        ),
      ),
    );
  }
  Widget buildCharactersList(){
    return GridView.builder(
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2,
        childAspectRatio: 2/3,
          crossAxisSpacing: 1,
          mainAxisSpacing: 1,
        ),shrinkWrap: true,
        physics: const NeverScrollableScrollPhysics(),
        itemCount: allCharacters.length,
        padding: EdgeInsets.zero,
        itemBuilder: (context,index){
          return  CharacterItem(character: allCharacters[index],);
        });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(backgroundColor: MyColors.primaryColor.shade200,
        elevation: 0,
        title: const Text('Characters'),
        centerTitle: true,
      ),
      body: buildBlocWidget(),
    );
  }
}
