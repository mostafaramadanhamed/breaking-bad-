
import 'package:movie/data/models/qoute.dart';
import 'package:movie/data/services/characters_service.dart';

import '../models/characters.dart';

class CharactersRepository{

  final CharactersWebServices charactersWebServices;

  CharactersRepository(this.charactersWebServices);

  Future<List<Character>>getAllCharacters()async{
    final characters =await charactersWebServices.getAllCharacters();
    return characters.map((character)=>Character.fromJson(character)).toList();
  }

  Future<List<Quote>>getCharacterQuotes(String charName)async{
    final quotes =await charactersWebServices.getCharacterQuotes(charName);
    return quotes.map((quote)=>Quote.fromJson(quote)).toList();
  }
}