import '../../constants/colors.dart';
import '../../constants/strings.dart';
import '../../data/models/Character.dart';
import 'package:flutter/material.dart';

class character_item extends StatelessWidget {
  final Character charcter;
  const character_item({Key? key, required this.charcter}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      margin: EdgeInsetsDirectional.fromSTEB(8, 8, 8, 8),
      padding: EdgeInsetsDirectional.all(4),
      decoration: BoxDecoration(
          color: MyColors.myWhite, borderRadius: BorderRadius.circular(8)),
      child: InkWell(
        onTap: () {
          Navigator.pushNamed(context, characterDetailsScreen,
              arguments: charcter);
        },
        child: GridTile(
          child: Hero(
            tag: charcter.charId,
            child: Container(
                color: MyColors.myGray,
                child: charcter.img.isNotEmpty
                    ? FadeInImage.assetNetwork(
                        width: double.infinity,
                        height: double.infinity,
                        placeholder: 'assets/images/loading.gif',
                        image: charcter.img,
                        fit: BoxFit.cover,
                      )
                    : Image.asset('assets/images/img.jpg')),
          ),
          footer: Container(
            width: double.infinity,
            color: Colors.black54,
            alignment: Alignment.bottomCenter,
            padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
            child: Text(
              '${charcter.name}',
              style: TextStyle(
                height: 1.3,
                fontSize: 16,
                fontWeight: FontWeight.bold,
                color: MyColors.myWhite,
              ),
              overflow: TextOverflow.ellipsis,
              maxLines: 2,
              textAlign: TextAlign.center,
            ),
          ),
        ),
      ),
    );
  }
}
