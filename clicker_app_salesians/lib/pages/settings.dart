import 'package:flutter/material.dart';
import 'package:package_info/package_info.dart';
import 'package:clicker_app_salesians/classes/villagerManager.dart';
import 'package:clicker_app_salesians/classes/themeChanger.dart';
import 'package:provider/provider.dart';

class SettingsPage extends StatefulWidget {
  @override
  _SettingsPageState createState() => _SettingsPageState();
}

class _SettingsPageState extends State<SettingsPage> {
  PackageInfo _packageInfo = PackageInfo(
    appName: 'Unknown',
    packageName: 'Unknown',
    version: 'Unknown',
    buildNumber: 'Unknown',
  );

  @override
  void initState() {
    super.initState();
    _initPackageInfo();
  }

  Future<void> _initPackageInfo() async {
    final PackageInfo info = await PackageInfo.fromPlatform();
    setState(() {
      _packageInfo = info;
    });
  }

  Future<bool> _showDialog(BuildContext context) {
    return showDialog(
          context: context,
          builder: (BuildContext context) {
            return AlertDialog(
              title: Text("Reset Data?"),
              content:
                  Text("This will reset all your current progress and data"),
              actions: <Widget>[
                FlatButton(
                  child: Text("CANCEL"),
                  onPressed: () {
                    Navigator.of(context).pop(false);
                  },
                ),
                RaisedButton(
                  child: Text("RESET"),
                  onPressed: () {
                    Navigator.of(context).pop(true);
                  },
                ),
              ],
            );
          },
        ) ??
        false;
  }

  @override
  Widget build(BuildContext context) {
    ThemeChanger _themeChanger = Provider.of<ThemeChanger>(context);
    return Scaffold(
      appBar: AppBar(
        title: RichText(text: TextSpan(
          children: <TextSpan>[
            TextSpan(text: 'Settings ', style: TextStyle(fontFamily: "Pacifico", color: Colors.green, fontSize: 25)),
            //TextSpan(text: 'List', style: TextStyle(fontFamily: "Source Sans Pro", color: Colors.white, fontSize: 25)),
          ],
        ),
        ),
        centerTitle: false,
      ),
      body: Column(
        children: <Widget>[
          Expanded(
              child: ListView(
            children: <Widget>[
              ListTile(
                title: Text('Dark Theme'),
                trailing: Switch(
                  value: VillagerManager.readTheme(),
                  onChanged: (value) {
                    if (value) {
                      _themeChanger.setTheme(ThemeData.dark());
                    } else {
                      _themeChanger.setTheme(
                        ThemeData(
                          primaryColor: Colors.white,
                        ),
                      );
                    }
                    VillagerManager.writeTheme(value);
                  },
                ),
              ),
              ListTile(
                title: Text('Level up your prestige'),
                trailing: RaisedButton(
                    child: Text('PRESTIGE'),
                    onPressed: VillagerManager.completed
                        ? () {
                            Navigator.of(context).pushNamed('/win');
                          }
                        : null),
              ),
              Divider(),
              ListTile(
                title: Text('Tap power'),
                subtitle: Text('Increases by 0.01 every 10 Villagers found'),
                trailing: Text(
                    '+${(VillagerManager.getRawPower() / 100).toStringAsFixed(2)}'),
              ),
              ListTile(
                title: Text('Prestige level'),
                subtitle: Text('Each level grants +0.05 tap power'),
                trailing: Text('${VillagerManager.prestige}'),
              ),
              ListTile(
                title: Text('Prestige tap power'),
                trailing: Text(
                    '+${(VillagerManager.prestige * 5 / 100).toStringAsFixed(2)}'),
              ),
              ListTile(
                title: Text('Bells'),
                trailing: Text('${VillagerManager.coins}'),
              ),
              ListTile(
                title: Text('Villagers List'),
                trailing: Text(
                    '${VillagerManager.foundVillagers.length}/${VillagerManager.villagerdex.length}'),
              ),
              ExpansionTile(
                title: Text('Debug'),
                children: <Widget>[
                  ListTile(
                    title: Text('Complete Villager List'),
                    trailing: OutlineButton(
                      child: Text('COMPLETE'),
                      onPressed: () {
                        VillagerManager.foundVillagers.clear();
                        for (var i = 0; i < VillagerManager.villagerdex.length; i++) {
                          VillagerManager.foundVillagers.add(i);
                        }
                        VillagerManager.completedVillagersList();
                        setState(() {});
                      },
                    ),
                  ),
                  Builder(
                    builder: (context) {
                      return ListTile(
                        title: Text('Get lots of Bells'),
                        trailing: OutlineButton(
                          child: Text('BELLS'),
                          onPressed: () {
                            VillagerManager.addCoins(777);
                            SnackBar snackBar = SnackBar(
                              content:
                                  Text('Added 777 Bells to your balance'),
                              action: SnackBarAction(
                                label: 'OK',
                                onPressed: () {},
                              ),
                            );
                            Scaffold.of(context).removeCurrentSnackBar();
                            Scaffold.of(context).showSnackBar(snackBar);
                          },
                        ),
                      );
                    },
                  ),
                ],
              ),
              Builder(
                builder: (BuildContext context) {
                  return ListTile(
                    title: Text('Reset data'),
                    trailing: OutlineButton(
                      child: Text('RESET'),
                      onPressed: () async {
                        if (await _showDialog(context)) {
                          VillagerManager.saveValues();
                          VillagerManager.resetValues();
                          SnackBar snackBar = SnackBar(
                            content: Text('Data resetted successfully'),
                            action: SnackBarAction(
                              label: 'UNDO',
                              onPressed: () {
                                VillagerManager.restoreValues();
                              },
                            ),
                          );
                          Scaffold.of(context).removeCurrentSnackBar();
                          Scaffold.of(context).showSnackBar(snackBar);
                        }
                      },
                    ),
                  );
                },
              ),
            ],
          )),
          Divider(),
        ],
      ),
    );
  }
}
