import 'package:flutter/material.dart';
import 'package:movie/constants/strings.dart';
import 'package:movie/presentation/screens/characters.dart';
import 'package:movie/presentation/screens/characters_details.dart';

class AppRouter{
  Route ? generateRoute(RouteSettings settings){
    switch (settings.name){
      case charactersScreen:
        return MaterialPageRoute(builder: (_)=>const CharactersScreen());

      case characterDetailsScreen:
        return MaterialPageRoute(builder: (_)=>const CharacterDetailsScreen());
    }
  }
}