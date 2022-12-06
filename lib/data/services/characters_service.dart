import 'package:dio/dio.dart';
import 'package:movie/constants/strings.dart';

class CharactersWebServices{
 late Dio dio;
 CharactersWebServices(){
   BaseOptions options=BaseOptions(
     baseUrl: baseUrl,
     receiveDataWhenStatusError: true,
     receiveTimeout: 15*1000 , //15 sec
     sendTimeout: 15*100, //15 sec
   );
   dio=Dio(options);
 }
 Future<List<dynamic>>getAllCharacters()async{
try{

  Response response=await dio.get('characters');
  return response.data;
}
catch(ex){
  print('Error in $ex');
   return [];
}
 }
 Future<List<dynamic>>getCharacterQuotes(String charName)async{
try{

  Response response=await dio.get('quote',queryParameters: {'author':charName});
  return response.data;
}
catch(ex){
  print('Error in $ex');
   return [];
}
 }

}