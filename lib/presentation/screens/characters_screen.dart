import '../../business_logic/cubit/cubit/characters_cubit.dart';
import '../../constants/colors.dart';
import '../../data/models/Character.dart';
import '../widget/character_item.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_offline/flutter_offline.dart';

class CharactersScreen extends StatefulWidget {
  const CharactersScreen({Key? key}) : super(key: key);

  @override
  _CharactersScreenState createState() => _CharactersScreenState();
}

class _CharactersScreenState extends State<CharactersScreen> {
  List<Character> allCharacters = [];
  List<Character> search = [];
  bool _isSearch = false;
  final searchTextController = TextEditingController();
  @override
  initState() {
    super.initState();
    allCharacters = BlocProvider.of<CharactersCubit>(context).getAllCharacter();
  }

  Widget buildSearchField() {
    return TextField(
      controller: searchTextController,
      cursorColor: MyColors.myGray,
      decoration: const InputDecoration(
        hintText: 'Find A character...',
        border: InputBorder.none,
        hintStyle: TextStyle(fontSize: 18, color: MyColors.myGray),
      ),
      style: const TextStyle(fontSize: 18, color: MyColors.myGray),
      onChanged: (searchValue) {
        saveOnSearchList(searchValue);
      },
    );
  }

  void saveOnSearchList(searchValue) {
    search = allCharacters
        .where(
            (character) => character.name.toLowerCase().startsWith(searchValue))
        .toList();
    setState(() {});
  }

  List<Widget> builaAppBarActions() {
    if (_isSearch) {
      return [
        IconButton(
          onPressed: () {
            searchTextController.clear();
            Navigator.pop(context);
            setState(() {
              _isSearch = false;
            });
          },
          icon: const Icon(
            Icons.clear,
            color: MyColors.myGray,
          ),
        ),
      ];
    } else {
      return [
        IconButton(
          onPressed: () {
            print('manar mmm');
            startSearch();
          },
          icon: const Icon(
            Icons.search,
            color: MyColors.myGray,
          ),
        ),
      ];
    }
  }

  void startSearch() {
    print('manar');
    ModalRoute.of(context)?.addLocalHistoryEntry(LocalHistoryEntry(
        onRemove:
            // Hide the red rectangle.
            stopSearch));

    setState(() {
      _isSearch = true;
    });
  }

  void stopSearch() {
    searchTextController.clear();

    setState(() {
      _isSearch = false;
    });
  }

  Widget buildBlockWidget() {
    return BlocBuilder<CharactersCubit, CharactersState>(
        builder: (context, state) {
      if (state is CharacterLoadded) {
        allCharacters = (state).characters;
        //      print(allCharacters.length);
        return buildLoadedListWidgets();
      } else {
        return const Center(
            child: CircularProgressIndicator(
          backgroundColor: MyColors.myGray,
          color: MyColors.myYellow,
        ));
      }
    });
  }

  Widget buildLoadedListWidgets() {
    return SingleChildScrollView(
      child: Container(
        color: MyColors.myGray,
        child: Column(
          children: [
            childCharacterList(),
          ],
        ),
      ),
    );
  }

  Widget childCharacterList() {
    return GridView.builder(
        itemCount: searchTextController.text.isEmpty
            ? allCharacters.length
            : search.length,
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2,
            childAspectRatio: 2 / 3,
            crossAxisSpacing: 1,
            mainAxisSpacing: 1),
        shrinkWrap: true,
        physics: const ClampingScrollPhysics(),
        padding: EdgeInsets.zero,
        itemBuilder: (context, i) {
          return character_item(
            charcter: searchTextController.text.isEmpty
                ? allCharacters[i]
                : search[i],
          );
        });
  }

  Widget buildNoInternetWidget() {
    return Center(
      child: Container(
        color: MyColors.myWhite,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text(
              'Cannot connect...check your internet',
              style: TextStyle(fontSize: 20, color: MyColors.myGray),
            ),
            const SizedBox(
              height: 20,
            ),
            Image.asset('assets/images/noInternet.png'),
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: _isSearch
            ? const BackButton(
                color: MyColors.myGray,
              )
            : Container(),
        actions: builaAppBarActions(),
        backgroundColor: MyColors.myYellow,
        title: _isSearch
            ? buildSearchField()
            : const Text(
                'Characters',
                style: TextStyle(color: MyColors.myGray),
              ),
      ),
      body: OfflineBuilder(
        connectivityBuilder: (
          BuildContext context,
          ConnectivityResult connectivity,
          Widget child,
        ) {
          final bool connected = connectivity != ConnectivityResult.none;
          if (connected) {
            return Container(
              color: MyColors.myGray,
              child: buildBlockWidget(),
            );
          } else {
            return buildNoInternetWidget();
          }
        },
        child: const Center(
            child: CircularProgressIndicator(
          backgroundColor: MyColors.myGray,
          color: MyColors.myYellow,
        )),
      ),
    );
  }
}
