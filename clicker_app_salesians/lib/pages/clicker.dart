import 'package:flutter/material.dart';
import 'package:clicker_app_salesians/classes/villagerManager.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:audioplayers/audio_cache.dart';


class ClickerPage extends StatefulWidget {
  @override
  _ClickerPageState createState() => _ClickerPageState();
}

class _ClickerPageState extends State<ClickerPage>
    with SingleTickerProviderStateMixin {
  Animation _animation;
  AnimationController _animationController;
  int _selectedIndex = 0;
  @override
  void initState() {
    super.initState();

    _animationController = AnimationController(
      value: 2,
      vsync: this,
      duration: Duration(milliseconds: 250),
    );
    _animation =
        Tween<double>(begin: 0.95, end: 0.85).animate(_animationController)
          ..addListener(() {
            setState(() {});
          });
  }

  void playSound() {
    final player = AudioCache();
    player.play('sound1.wav');
  }

  void _onTap() {
    _animationController.reset();
    _animationController.forward();
    setState(() {
      VillagerManager.incrementProgress();
      playSound();
    });
  }

  static const TextStyle optionStyle =
  TextStyle(fontSize: 30, fontWeight: FontWeight.bold);
  static const List<Widget> _widgetOptions = <Widget>[
    Text(
      'Index 0: Home',
      style: optionStyle,
    ),
    Text(
      'Index 1: List',
      style: optionStyle,
    ),
    Text(
      'Index 2: List',
      style: optionStyle,
    ),
  ];



  @override
  Widget build(BuildContext context) {

    return Scaffold(
      appBar: AppBar(
        title: RichText(text: TextSpan(
          children: <TextSpan>[
            TextSpan(text: '   Villager ', style: TextStyle(fontFamily: "Pacifico", color: Colors.white, fontSize: 25)),
            TextSpan(text: 'Collector', style: TextStyle(fontFamily: "Source Sans Pro", color: Colors.white, fontSize: 25)),
          ],
        ),
        ),
        //  '   Villager'+'Collector', style: TextStyle(fontFamily: 'Pacifico', color: Colors.white)),
        backgroundColor: Colors.green,
        actions: <Widget>[
          IconButton(
            onPressed: () {
              Navigator.pushNamed(context, '/settings');
            },
            icon: Icon(Icons.settings, color: Colors.white),
          )
        ],
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.end,
        children: <Widget>[
          Expanded(
            child: Container(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Expanded(
                    flex: 1,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        Text(
                          '${VillagerManager.coins}',
                          style: TextStyle(
                            fontSize: 50,
                            color: Colors.green,
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                        ),
                        Image.asset(
                          'assets/bells.png',
                          width: 50,
                        ),
                      ],
                    ),
                  ),
                  Expanded(
                    flex: 3,
                    child: GestureDetector(
                      onTap: _onTap,
                      child: Transform.scale(
                        scale: _animation.value,
                        child: Image.asset(
                          'assets/bells_big.png',
                            width: 800,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
          BottomNavigationBar(
            items: const <BottomNavigationBarItem>[
              BottomNavigationBarItem(
                icon: Icon(Icons.shopping_cart),
                label: 'Shop',
              ),
              BottomNavigationBarItem(
                icon: Icon(Icons.menu),
                label: 'List'
              ),
            ],
            currentIndex: _selectedIndex,
            selectedItemColor: Colors.green,
            onTap: (index){
              switch(index){
                case 0:
                  Navigator.pushNamed(context, "/shop");
                  break;
                case 1:
                  Navigator.pushNamed(context, "/VillagersList");
                  break;
            }
            },
          ),
        ],
      ),
    );
  }
}
