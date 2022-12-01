
import 'package:movie/data/services/characters_service.dart';

import '../models/characters.dart';

class CharactersRepository{

  final CharactersWebServices charactersWebServices;

  CharactersRepository(this.charactersWebServices);

  Future<List<dynamic>>getAllCharacters()async{
    final characters =await charactersWebServices.getAllCharacters();
    return characters.map((character)=>Character.fromJson(character)).toList();
  }
}