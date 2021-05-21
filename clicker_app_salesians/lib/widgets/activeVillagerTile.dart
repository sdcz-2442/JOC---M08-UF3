import 'package:flutter/material.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:clicker_app_salesians/classes/villagerManager.dart';
import 'package:clicker_app_salesians/classes/villager.dart';
import 'package:clicker_app_salesians/classes/typeColors.dart';
import 'package:clicker_app_salesians/pages/details.dart';

Widget activeVillagerTile(BuildContext context, Villager villager) {
  TypeColors _villagerPersonalityColor = VillagerManager.villagerPersonalityTypeColor[villager.personality];
  return Padding(
    padding: const EdgeInsets.all(4.0),
    child: Material(
      type: MaterialType.card,
      elevation: 1,
      borderRadius: BorderRadius.all(Radius.circular(16.0)),
      clipBehavior: Clip.antiAlias,
      color: _villagerPersonalityColor.light,
      child: InkWell(
        splashColor: _villagerPersonalityColor.normal,
        onTap: () {
          Navigator.of(context).push(
            MaterialPageRoute(
              builder: (BuildContext context) => DetailsPage(
                villager: villager,
              ),
            ),
          );
        },
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            children: <Widget>[
              Expanded(
                child: Stack(
                  alignment: Alignment.bottomCenter,
                  children: <Widget>[
                    Align(
                      alignment: Alignment.topRight,
                      child: Text(
                        '#${villager.id.toString().padLeft(3, '0')}',
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 28,
                          color: Colors.black38,
                        ),
                      ),
                    ),
                    Positioned.fill(
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Hero(
                          tag: villager.name,
                          child: CachedNetworkImage(
                            placeholder: (context, url) => CircularProgressIndicator(
                              valueColor:
                              AlwaysStoppedAnimation<Color>(_villagerPersonalityColor.normal),
                            ),
                            errorWidget: (context, url, error) => Icon(
                              Icons.error,
                              color: Colors.red,
                            ),
                            imageUrl:
                            'https://acnhapi.com/v1/icons/villagers/${villager.id}',
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 8.0),
                child: Text(
                  villager.name,
                  overflow: TextOverflow.ellipsis,
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 20,
                    color: Colors.black54,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    ),
  );
}
