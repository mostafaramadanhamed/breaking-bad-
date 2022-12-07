import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_offline/flutter_offline.dart';
import '../../bussnies_logic/cubit/movie_cubit.dart';
import '../../bussnies_logic/cubit/movie_state.dart';
import '../../constants/colors.dart';
import '../../data/models/characters.dart';
import '../widgets/character_item.dart';

class CharactersScreen extends StatefulWidget {
  const CharactersScreen({Key? key}) : super(key: key);

  @override
  State<CharactersScreen> createState() => _CharactersScreenState();
}

class _CharactersScreenState extends State<CharactersScreen> {
  late List<Character>allCharacters;
  late List<Character>searchedForCharacters;
  bool _isSearching=false;
  final _searchTextController=TextEditingController();

  Widget buildSearchField(){
    return TextField(
      cursorColor: Colors.black,
      controller: _searchTextController,
      decoration: const InputDecoration(
        hintText:'Find a character',
        hintStyle: TextStyle(
          fontSize: 18,
        ),
      ),
      style: const TextStyle(
        fontSize: 18,
      ),
      onChanged: (searchedCharacter){
        addSearchedForItemsToSearchedList(searchedCharacter);
      },
    );
  }
  void addSearchedForItemsToSearchedList(String searchedCharacter) {
    searchedForCharacters = allCharacters
        .where((character) =>
        character.name.toLowerCase().startsWith(searchedCharacter))
        .toList();
    setState(() {});
  }
  List<Widget> buildAppBarActions() {
    if (_isSearching) {
      return [
        IconButton(
          onPressed: () {
            _clearSearch();
            Navigator.pop(context);
          },
          icon: const Icon(Icons.clear,),
        ),
      ];
    } else {
      return [
        IconButton(
          onPressed: _startSearch,
          icon: const Icon(
            Icons.search,
          ),
        ),
      ];
    }
  }

  void _startSearch() {
    ModalRoute.of(context)!
        .addLocalHistoryEntry(LocalHistoryEntry(onRemove: _stopSearching));

    setState(() {
      _isSearching = true;
    });
  }

  void _stopSearching() {
    _clearSearch();

    setState(() {
      _isSearching = false;
    });
  }

  void _clearSearch() {
    setState(() {
      _searchTextController.clear();
    });
  }
  @override
  void initState() {
    super.initState();
    BlocProvider.of<CharactersCubit>(context).getAllCharacters();

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
        itemCount: _searchTextController.text.isEmpty
            ? allCharacters.length
            : searchedForCharacters.length,
        itemBuilder: (context, index) {
          return CharacterItem(
            character: _searchTextController.text.isEmpty
                ? allCharacters[index]
                : searchedForCharacters[index],
          );
        });
  }
  Widget buildBlocWidget() {
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
  Widget buildAppBarTitle() {
    return const Text(
      'Characters',
    );
  }
  Widget buildNoInternetWidget(){
    return Center(
      child: Container(
        height: MediaQuery.of(context).size.height,
        width: MediaQuery.of(context).size.width,
        color: Colors.white,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SizedBox(
              height: MediaQuery.of(context).size.height/15,
            ),
            Image.asset('assets/images/no_interner.png',
              height:MediaQuery.of(context).size.height/1.5 ,
              width: MediaQuery.of(context).size.width,),
            const Text(
              ' Can\'t connect .. check your internet',
              style: TextStyle(
                fontSize: 22,
                color: MyColors.primaryColor,
              ),
            ),
          ],
        ),
      ),
    );
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.teal.shade200,
      appBar: AppBar(
        leading: _isSearching
            ? const BackButton(
        )
            : Container(),
        title: _isSearching ? buildSearchField() : buildAppBarTitle(),
        actions: buildAppBarActions(),
      ),
      body:  OfflineBuilder(
      connectivityBuilder: (
      BuildContext context,
      ConnectivityResult connectivity,
      Widget child,
    ) {
      final bool connected = connectivity != ConnectivityResult.none;
    if(connected){
      return buildBlocWidget();
    }
    else{
      return buildNoInternetWidget();
    }
      },
        child: showLoadingIndicator(),
      )
      //buildBlocWidget(),
    );
  }
}
