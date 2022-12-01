import 'package:flutter/material.dart';
import 'package:movie/presentation/screens/characters.dart';

class AppRouter{
  Route ? generateRoute(RouteSettings settings){
    switch (settings.name){
      case '/':
        return MaterialPageRoute(builder: (_)=>const CharactersScreen());
    }
  }
}