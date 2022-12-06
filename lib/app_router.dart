import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movie/bussnies_logic/cubit/movie_cubit.dart';
import 'package:movie/constants/strings.dart';
import 'package:movie/data/repository/characters_repository.dart';
import 'package:movie/data/services/characters_service.dart';
import 'package:movie/presentation/screens/characters.dart';
import 'package:movie/presentation/screens/characters_details.dart';

import 'data/models/characters.dart';

class AppRouter{

  late CharactersRepository charactersRepository;
  late CharactersCubit charactersCubit;
  AppRouter(){
    charactersRepository=CharactersRepository(CharactersWebServices());
    charactersCubit=CharactersCubit(charactersRepository);
}
  Route ? generateRoute(RouteSettings settings){
    switch (settings.name){
      case charactersScreen:
        return MaterialPageRoute(builder: (_)=>  BlocProvider(
            create:(BuildContext context)=>
                charactersCubit ,
          child: const CharactersScreen(),
        ));

      case characterDetailsScreen:
        final character=settings.arguments as Character ;
        return MaterialPageRoute(builder: (_)=> BlocProvider(
            create: (BuildContext context)=>charactersCubit,
        child: CharacterDetailsScreen(character: character,)));
    }
  }
}