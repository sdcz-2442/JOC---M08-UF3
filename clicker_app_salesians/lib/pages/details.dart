import 'package:flutter/material.dart';
import 'package:clicker_app_salesians/classes/villagerManager.dart';
import 'package:clicker_app_salesians/classes/villager.dart';
import 'package:clicker_app_salesians/classes/typeColors.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:clicker_app_salesians/widgets/typeChip.dart';

class DetailsPage extends StatefulWidget {
  DetailsPage({Key key, this.villager}) : super(key: key);

  final Villager villager;

  @override
  _DetailsPageState createState() => _DetailsPageState();
}

class _DetailsPageState extends State<DetailsPage> {
  Villager _villager;
  TypeColors _villagerPersonalityColors;
  bool _isLight;

  TextStyle _attributeNameStyle;
  TextStyle _attributeValueStyle;

  @override
  void initState() {
    super.initState();

    _villager = widget.villager;
    _villagerPersonalityColors = VillagerManager.villagerPersonalityTypeColor[_villager.personality];
    _isLight = _villagerPersonalityColors.light.computeLuminance() > 0.5;
    _attributeNameStyle = TextStyle(
      color: _isLight ? Colors.black54 : Colors.white70,
      fontSize: 16,
      fontWeight: FontWeight.bold,
    );
    _attributeValueStyle = TextStyle(
      color: _isLight ? Colors.black54 : Colors.white70,
      fontSize: 20,
      fontWeight: FontWeight.bold,
      fontStyle: FontStyle.italic,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: _villagerPersonalityColors.normal,
      appBar: AppBar(
        title: Text(
          _villager.name,
          style: TextStyle(
            color: _villagerPersonalityColors.normal,
          ),
        ),
        centerTitle: true,
        elevation: 0.0,
        iconTheme: IconThemeData(
          color: _villagerPersonalityColors.normal,
        ),
      ),
      body: Column(
        children: <Widget>[
          Flexible(
            flex: 2,
            child: Material(
              elevation: 4.0,
              color: Theme.of(context).primaryColor,
              borderRadius: BorderRadius.only(
                bottomLeft: Radius.circular(100.0),
              ),
              child: Center(
                child: Hero(
                  tag: _villager.name,
                  child: CachedNetworkImage(
                    placeholder: (context, url) => CircularProgressIndicator(
                      valueColor:
                          AlwaysStoppedAnimation<Color>(_villagerPersonalityColors.normal),
                    ),
                    errorWidget: (context, url, error) => Icon(
                      Icons.error,
                      color: Colors.red,
                    ),
                    imageUrl:
                    'https://acnhapi.com/v1/icons/villagers/${_villager.id}',
                    //maxHeightDiskCache: 300
                  ),
                ),
              ),
            ),
          ),
          Center(
            child: Padding(
              padding: const EdgeInsets.fromLTRB(15, 1, 15, 1),
            child: Column(
              children: <Widget>[
                _buildStringAttribute('', _villager.saying),
              ],
            ),
          ),
          ),
          Flexible(
            flex: 2,
            child: Padding(
              padding: const EdgeInsets.all(25.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: <Widget>[
                  Flexible(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: <Widget>[
                        _buildStringAttribute('Species', _villager.species),
                        _buildStringAttribute('Gender', _villager.gender),
                        _buildStringAttribute('Personality', _villager.personality),
                      ],
                    ),
                  ),
                  Flexible(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: <Widget>[
                        _buildStringAttribute('Birthday', _villager.birthdayString),
                        _buildStringAttribute('Hobby', _villager.hobby),
                        _buildStringAttribute('Saying', _villager.catchPhrase),
                      ],
                    ),
                  )
                ],
              ),
            ),
          )
        ],
      ),
    );
  }

  Widget _buildStringAttribute(String name, String val) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: <Widget>[
        Text(
          name,
          style: _attributeNameStyle,
        ),
        Text(
          val,
          style: _attributeValueStyle,
        ),
      ],
    );
  }

  Widget _buildChipsAttribute(String name, List<String> list) {
    List<Widget> _chips = List.generate(list.length, (index) {
      return TypeChip(name: list[index]);
    });

    return Column(
      mainAxisSize: MainAxisSize.min,
      children: <Widget>[
        Text(
          name,
          style: _attributeNameStyle,
        ),
        Flexible(
          child: Wrap(
            spacing: 4,
            runSpacing: -8,
            alignment: WrapAlignment.center,
            children: _chips,
          ),
        )
      ],
    );
  }
}
