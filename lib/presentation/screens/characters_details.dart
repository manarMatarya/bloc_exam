import 'dart:math';

import 'package:animated_text_kit/animated_text_kit.dart';
import '../../business_logic/cubit/cubit/characters_cubit.dart';
import '../../constants/colors.dart';
import '../../data/models/Character.dart';
import '../../data/models/qoutes.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class CharactersDetails extends StatelessWidget {
  final Character character;
  const CharactersDetails({Key? key, required this.character})
      : super(key: key);

  Widget buildSliverAppBar() {
    return SliverAppBar(
        expandedHeight: 600,
        pinned: true,
        stretch: true,
        centerTitle: true,
        backgroundColor: MyColors.myGray,
        flexibleSpace: FlexibleSpaceBar(
          title: Text(
            character.nickname,
            style: const TextStyle(color: MyColors.myWhite),
            //  textAlign: TextAlign.center,
          ),
          background: Hero(
            tag: character.charId,
            child: Image.network(
              character.img,
              fit: BoxFit.cover,
            ),
          ),
        ));
  }

  Widget characterInfo(String key, String value) {
    return RichText(
      maxLines: 1,
      overflow: TextOverflow.ellipsis,
      text: TextSpan(
        children: [
          TextSpan(
            text: key,
            style: const TextStyle(
                fontSize: 18,
                color: MyColors.myWhite,
                fontWeight: FontWeight.bold),
          ),
          TextSpan(
            text: value,
            style: const TextStyle(
              fontSize: 16,
              color: MyColors.myWhite,
            ),
          ),
        ],
      ),
    );
  }

  Widget buildDivider(double endIndent) {
    return Divider(
      height: 30,
      endIndent: endIndent,
      color: MyColors.myYellow,
      thickness: 2,
    );
  }

  Widget buildQuoteWidget(CharactersState state) {
    if (state is QuoteLoadded) {
      var quate = (state).quotes;
      if (quate.length == 1) {
        print(quate.length);
        int randomQuateIndex = Random().nextInt(quate.length);
        return Center(
          child: DefaultTextStyle(
            textAlign: TextAlign.center,
            style: const TextStyle(
              fontSize: 20,
              color: MyColors.myWhite,
              shadows: [
                Shadow(
                  blurRadius: 7,
                  color: MyColors.myYellow,
                  offset: Offset(0, 0),
                )
              ],
            ),
            child: AnimatedTextKit(
              repeatForever: true,
              animatedTexts: [
                FlickerAnimatedText(quate[randomQuateIndex].quote),
              ],
            ),
          ),
        );
      } else if (quate.length > 1) {
        print(quate.length);
        int randomQuateIndex = Random().nextInt(quate.length - 1);
        return Center(
          child: DefaultTextStyle(
            textAlign: TextAlign.center,
            style: const TextStyle(
              fontSize: 20,
              color: MyColors.myWhite,
              shadows: [
                Shadow(
                  blurRadius: 7,
                  color: MyColors.myYellow,
                  offset: Offset(0, 0),
                )
              ],
            ),
            child: AnimatedTextKit(
              repeatForever: true,
              animatedTexts: [
                FlickerAnimatedText(quate[randomQuateIndex].quote),
              ],
            ),
          ),
        );
      } else {
        return Center();
      }
      ;
    } else {
      return const Center(
          child: CircularProgressIndicator(
        backgroundColor: MyColors.myGray,
        color: MyColors.myYellow,
      ));
    }
  }

  // Widget disblayRandomQuoteOrEmptyState(state) {}

  @override
  Widget build(BuildContext context) {
    BlocProvider.of<CharactersCubit>(context).getQuote(name: character.name);
    return Scaffold(
      backgroundColor: MyColors.myGray,
      body: CustomScrollView(
        slivers: [
          buildSliverAppBar(),
          SliverList(
            delegate: SliverChildListDelegate(
              [
                Container(
                  margin: const EdgeInsets.fromLTRB(14, 14, 14, 0),
                  padding: const EdgeInsets.all(8),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      characterInfo('Job : ', character.occupation.join(' / ')),
                      buildDivider(315),
                      characterInfo('Appeared in : ', character.category),
                      buildDivider(250),
                      characterInfo(
                          'Seasons : ', character.appearance.join(' / ')),
                      buildDivider(280),
                      characterInfo('Status : ', character.status),
                      buildDivider(300),
                      character.betterCallSaulAppearance.isEmpty
                          ? Container()
                          : characterInfo('Better Call Saul Seasons : ',
                              character.betterCallSaulAppearance.join(' / ')),
                      character.betterCallSaulAppearance.isEmpty
                          ? Container()
                          : buildDivider(150),
                      characterInfo('Actor/Actoress : ', character.portrayed),
                      buildDivider(300),
                      const SizedBox(
                        height: 20,
                      ),
                      BlocBuilder<CharactersCubit, CharactersState>(
                        builder: (context, state) {
                          return buildQuoteWidget(state);
                        },
                      ),
                    ],
                  ),
                ),
                const SizedBox(
                  height: 500,
                )
              ],
            ),
          ),
        ],
      ),
    );
  }
}
