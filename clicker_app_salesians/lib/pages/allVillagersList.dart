import 'package:draggable_scrollbar/draggable_scrollbar.dart';
import 'package:flutter/material.dart';
import 'package:clicker_app_salesians/classes/villagerManager.dart';
import 'package:clicker_app_salesians/classes/villager.dart';
import 'package:clicker_app_salesians/widgets/activeVillagerTile.dart';
import 'package:clicker_app_salesians/widgets/disabledVillagerTile.dart';

class AllVillagersPage extends StatefulWidget {
  @override
  _AllVillagersPageState createState() => _AllVillagersPageState();
}

class _AllVillagersPageState extends State<AllVillagersPage> {
  bool _isSortedAlpha;
  bool _isShowingAllVillagers;
  ScrollController myScrollController;
  List<Villager> villagers;

  @override
  void initState() {
    super.initState();
    _isSortedAlpha = false;
    _isShowingAllVillagers = false;
    myScrollController = ScrollController();
    villagers = List<Villager>();

    _loadCaughtVillagers();
  }

  void _loadCaughtVillagers() {
    VillagerManager.foundVillagers.forEach((item) {
      villagers.add(VillagerManager.villagerdex[item]);
    });
    villagers.sort((a, b) => a.id.compareTo(b.id));
  }

  void _sort() {
    _isSortedAlpha
        ? villagers.sort((a, b) => a.id.compareTo(b.id))
        : villagers.sort((a, b) => a.name.compareTo(b.name));
    setState(() {
      _isSortedAlpha = !_isSortedAlpha;
    });
  }

  void _show() {
    villagers.clear();
    if (_isShowingAllVillagers) {
      _loadCaughtVillagers();
    } else {
      villagers.addAll(VillagerManager.villagerdex);
    }

    _isSortedAlpha
        ? villagers.sort((a, b) => a.name.compareTo(b.name))
        : villagers.sort((a, b) => a.id.compareTo(b.id));

    setState(() {
      _isShowingAllVillagers = !_isShowingAllVillagers;
      myScrollController.jumpTo(0.0);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.green,
        title: RichText(text: TextSpan(
          children: <TextSpan>[
            TextSpan(text: 'Villager ', style: TextStyle(fontFamily: "Pacifico", color: Colors.white, fontSize: 25)),
            TextSpan(text: 'List', style: TextStyle(fontFamily: "Source Sans Pro", color: Colors.white, fontSize: 25)),
          ],
        ),
        ),
        actions: <Widget>[
          PopupMenuButton(
            icon: Icon(Icons.more_vert, color: Colors.white),
            onSelected: (value) {
              if (value == 'show') {
                _show();
              } else if (value == 'sort') {
                _sort();
              }
            },
            itemBuilder: (BuildContext context) {
              return <PopupMenuEntry<dynamic>>[
                CheckedPopupMenuItem(
                  checked: _isSortedAlpha,
                  child: Text('Sort alphabetically'),
                  value: 'sort',
                ),
                CheckedPopupMenuItem(
                  checked: _isShowingAllVillagers,
                  enabled: true,
                  child: Text('Show all'),
                  value: 'show',
                ),
              ];
            },
          ),
        ],
      ),
      body: DraggableScrollbar.rrect(
        controller: myScrollController,
        child: GridView.builder(
          padding: const EdgeInsets.all(4.0),
          controller: myScrollController,
          itemCount: villagers.length,
          gridDelegate:
              SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 2),
          itemBuilder: (BuildContext context, int index) {
            if (VillagerManager.foundVillagers.contains(villagers[index].id - 1)) {
              return activeVillagerTile(context, villagers[index]);
            } else {
              return disabledVillagerTile(context, villagers[index]);
            }
          },
        ),
      ),
      floatingActionButton: FloatingActionButton.extended(
        backgroundColor: Colors.green,
        onPressed: null,
        label: Text(
            '${VillagerManager.foundVillagers.length}/${VillagerManager.villagerdex.length}'),
      ),
    );
  }
}
