import 'dart:io';
import 'package:flutter/material.dart';
import 'package:audioplayers/audio_cache.dart';
import 'package:audioplayers/audioplayers.dart';
import 'package:admob_flutter/admob_flutter.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:url_launcher/url_launcher.dart';

void main() {
  Admob.initialize(getAppId());
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Forty Click',
      theme: ThemeData(
              primarySwatch: Colors.green,
      ),
      home: MyHomePage(title: 'Forty Click - Some Say This is Relaxing'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);
  final String title;
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  AudioPlayer advancedPlayer;
  AudioCache audioCache;
  AdmobBannerSize bannerSize;
  @override
  void initState(){
    super.initState();
    initPlayer();
    bannerSize = AdmobBannerSize.MEDIUM_RECTANGLE;
  }
  void initPlayer(){
    advancedPlayer = new AudioPlayer();
    audioCache = new AudioCache(fixedPlayer: advancedPlayer);
  }
  String localFilePath;
  Widget _tab(List<Widget> children) {
    return Center(
      child: Container(
        padding: EdgeInsets.all(16.0),
        child: Column(
          children: children
              .map((w) => Container(child: w, padding: EdgeInsets.all(6.0)))
              .toList(),
        ),
      ),
    );
  }
  Widget _btn(String txt, VoidCallback onPressed) {
    return ButtonTheme(
        minWidth: 48.0,
        child: RaisedButton(child: Text(txt), onPressed: onPressed));
  }
  Widget localAsset() {
    return _tab([
//      Text('Play 40Hz Click'),
      _btn('Play 40Hz Click', () => audioCache.loop('audio2.mp3')),
//      Text('Play 40Hz Sound'),
      _btn('Play 40Hz Sound', () => audioCache.loop('audio.mp3')),
      _btn('Stop', () => advancedPlayer.stop()),
    ]);
  }
  @override
  Widget build(BuildContext context) {
     return Container(
        decoration: BoxDecoration(
        image: DecorationImage(
            image: AssetImage('assets/relax.webp'), fit: BoxFit.cover)),
      child: Scaffold(
        appBar: AppBar(
          title: Text('Some Say these Sounds are Relaxing'),
        ),
        body: ListView(
          children: [
            localAsset(),
            Html( data: '<hr>'),
            new InkWell(
                child: new Text('Does listening to a 40 Hz tone “clean up” the brain in Alzheimer’s patients?',
                style: TextStyle(
                fontWeight: FontWeight.bold,
                color: Colors.blue)),
                onTap: () => launch('https://blog.szynalski.com/2018/03/40-hz-tone-alzheimers/')
            ),
            new InkWell(
                child: new Text('Gamma wave - Wikipedia',
                    style: TextStyle(
                        fontWeight: FontWeight.bold,
                        color: Colors.blue)),
                onTap: () => launch('https://en.wikipedia.org/wiki/Gamma_wave')
            ),
            Html( data: '<hr>'),
            AdmobBanner(
            adUnitId: getBannerAdUnitId(),
            adSize: bannerSize,
    )],

    )));
  }
}
String getAppId() {
  if (Platform.isIOS) {
    return 'ca-app-pub-4436272376536757~7379690244';
  } else if (Platform.isAndroid) {
    return 'ca-app-pub-4436272376536757~7379690244';
  }
  return null;
}

String getBannerAdUnitId() {
  if (Platform.isIOS) {
    return 'ca-app-pub-4436272376536757/5875036884';
  } else if (Platform.isAndroid) {
    return 'ca-app-pub-4436272376536757/5875036884';
  }
  return null;
}

//\n<a href="https://www.ncbi.nlm.nih.gov/pubmed/18818122">https://www.ncbi.nlm.nih.gov/pubmed/18818122