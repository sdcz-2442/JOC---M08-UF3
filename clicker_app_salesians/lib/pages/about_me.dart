import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:clicker_app_salesians/widgets/customShapeClipper.dart';
import 'package:url_launcher/url_launcher.dart';

class AboutMePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Developed by'),
        centerTitle: true,
        elevation: 0.0,
        backgroundColor: Colors.lightBlue,
      ),
      body: Column(
        children: <Widget>[
          Expanded(
            child: Stack(
              children: <Widget>[
                ClipPath(
                  clipper: CustomShapeClipper(),
                  child: Container(
                    decoration: BoxDecoration(
                      gradient: LinearGradient(
                        colors: [Colors.lightBlue, Color(0xFF2639F7)],
                        begin: Alignment.topCenter,
                        end: Alignment.bottomCenter,
                      ),
                    ),
                  ),
                ),
                Center(
/*                  child: Image.asset(
                    'assets/icon/nackha1.png',
                    fit: BoxFit.contain,
                  ),*/
                ),
              ],
            ),
          ),
          Expanded(
            flex: 2,
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                children: <Widget>[
                  Center(
                    child: Text(
                      'Samantha Conus',
                      style: TextStyle(
                        fontSize: 28,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text(''),
                  ),
                  Expanded(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: <Widget>[
                        Text(
                          '\n',
                          textAlign: TextAlign.center,
                          style: Theme.of(context).textTheme.caption,
                        ),
                        Text(
                          '\n',
                          textAlign: TextAlign.center,
                          style: Theme.of(context).textTheme.caption,
                        ),
                        Text(
                          '\n',
                          textAlign: TextAlign.center,
                          style: Theme.of(context).textTheme.caption,
                        ),
                        Text(
                          'Animal Crossing And All Respective Names are Trademark of Nintendo 1996-2020',
                          textAlign: TextAlign.center,
                          style: Theme.of(context).textTheme.subtitle,
                        ),
                      ],
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 32.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: <Widget>[
                        AboutMeTile(
                          text: 'GITHUB',
                          icon: Icon(FontAwesomeIcons.github),
                          url: 'https://github.com/sdcz-2442',
                        ),
                        AboutMeTile(
                          text: 'LINKEDIN',
                          icon: Icon(FontAwesomeIcons.instagram),
                          url: 'https://www.linkedin.com/in/samanthaconus/',
                        ),
                        AboutMeTile(
                          text: 'EMAIL',
                          icon: Icon(FontAwesomeIcons.solidEnvelope),
                          url: 'mailto:<samanthaconus@gmail.com>',
                        ),
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
}

class AboutMeTile extends StatelessWidget {
  AboutMeTile({this.text, this.icon, this.url});

  final String text;
  final Icon icon;
  final String url;

  @override
  Widget build(BuildContext context) {
    _launchURL() async {
      if (await canLaunch(url)) {
        await launch(url);
      } else {
        throw 'Could not launch $url';
      }
    }

    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: <Widget>[
        Text(
          text,
          style: TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.bold,
          ),
        ),
        IconButton(
          icon: icon,
          onPressed: _launchURL,
        ),
      ],
    );
  }
}
