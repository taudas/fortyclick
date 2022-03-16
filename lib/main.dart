import 'dart:io';
import 'package:flutter/material.dart';
// import 'package:audioplayers/audio_cache.dart';
import 'package:audioplayers/audioplayers.dart';
// import 'package:admob_flutter/admob_flutter.dart';
import 'package:url_launcher/url_launcher.dart';
void main() {
  // Admob.initialize();
  runApp(MyApp());
}
// String getAppId() {
//   if (Platform.isIOS) {
//   return 'ca-app-pub-4436272376536757~7379690244';
// } else if (Platform.isAndroid) {
//   return 'ca-app-pub-4436272376536757~7379690244';
// }
// return null;
// }
class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Forty Click',
      theme: ThemeData(
        primarySwatch: Colors.lightGreen,
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
  // AdmobBannerSize bannerSize;
  @override
  void initState() {
    super.initState();
    initPlayer();
    // bannerSize = AdmobBannerSize.BANNER;
    //bannerSize = AdmobBannerSize.MEDIUM_RECTANGLE;
  }
  void initPlayer() {
    advancedPlayer = new AudioPlayer();
    audioCache = new AudioCache(fixedPlayer: advancedPlayer);
  }
  String localFilePath;
  bool firstStateEnabled = true;
  Widget myTable(List<Widget> children) {
    return Center(
      child: Container(
        padding: EdgeInsets.all(2.0),
//        child: Center(
        child: Row(
          children: children
              .map((w) =>
              Center(child: Container(child: w,padding: EdgeInsets.all(2.0))))
              .toList(),
        ),
//        ),
      ),
    );
  }
  Widget myButton(String txt, VoidCallback onPressed) {
    return ButtonTheme(
      minWidth: 16.0,
      splashColor: Colors.lightGreenAccent,
      child: ElevatedButton(
          onPressed: onPressed,
          // highlightElevation: 16,
          // shape: RoundedRectangleBorder(
          //     borderRadius: BorderRadius.circular(10)),
//            child: Container(
//            decoration: BoxDecoration(
//              image: DecorationImage(
//                  image: AssetImage('assets/grass.webp'),
//                  fit: BoxFit.contain
//                  ),
          child: Text(txt)
      ),
    );
  }
  Widget playerBar() {
    return FittedBox(fit: BoxFit.fitWidth,
      child: myTable([
        myButton('1',() => setState(() {
          audioCache.loop('audio1.mp3');
          firstStateEnabled = !firstStateEnabled;
        })  ),
        myButton('2',() => setState(() {
          audioCache.loop('audio2.mp3');
          firstStateEnabled = !firstStateEnabled;
        })  ),
        myButton('3',() => setState(() {
          audioCache.loop('audio3.mp3');
          firstStateEnabled = !firstStateEnabled;
        })  ),
        myButton('4',() => setState(() {
          audioCache.loop('audio4.mp3');
          firstStateEnabled = !firstStateEnabled;
        })  ),
        myButton('Stop',() => advancedPlayer.stop()),
//        myButton('Change',() => setState(() {
//          audioCache.loop('audio1.mp3');
//          firstStateEnabled = !firstStateEnabled;
//        })  ),
      ]),
    );
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.transparent,
        appBar: AppBar(
          centerTitle: true,
          title: FittedBox(fit: BoxFit.fitWidth,
              child: Text(('Some Say these Sounds are Relaxing'))
          ),
        ),
        body: Stack(
            children: <Widget>[
              AnimatedCrossFade(
                firstChild: Container(
                    decoration: new BoxDecoration(image: DecorationImage(
                        image: new AssetImage('assets/jurrasic.webp'), fit: BoxFit.fill))),
                secondChild: Container(
                    decoration: new BoxDecoration(image: DecorationImage(
                        image: AssetImage('assets/grass.webp'), fit: BoxFit.fill))),
                duration: new Duration(seconds: 9),
                crossFadeState: firstStateEnabled
                    ? CrossFadeState.showFirst : CrossFadeState.showSecond,
              ),
              ListView(
                children: [
                  Center(child: playerBar()),
                  //Html( data: '<hr>'),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: myButton(
                        'Does listening to a 40 Hz tone “clean up” the brain in Alzheimer’s patients?',
                            () =>
                            launch(
                                'https://blog.szynalski.com/2018/03/40-hz-tone-alzheimers/')),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: myButton('Gamma wave - Wikipedia',
                            () =>
                            launch('https://en.wikipedia.org/wiki/Gamma_wave')),
                  ),
                  // AdmobBanner(
                  //   adUnitId: getBannerAdUnitId(),
                  //   adSize: bannerSize,
                  // ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: myButton(
                        'Gamma Band Neural Stimulation in Humans and the Promise of a New Modality to Prevent and Treat Alzheimer’s Disease',
                            () =>
                            launch(
                                'https://www.ncbi.nlm.nih.gov/pmc/articles/PMC6130417/')),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: myButton('Science Direct - Gamma Wave',
                            () =>
                            launch(
                                'https://www.sciencedirect.com/topics/neuroscience/gamma-wave')),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: myButton(
                        'What is the function of the various brainwaves?',
                            () =>
                            launch(
                                'https://www.scientificamerican.com/article/what-is-the-function-of-t-1997-12-22/')),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: myButton(
                        'Flash! Beep! Gamma Waves Stimulate Microglia, Memory',
                            () =>
                            launch(
                                'https://www.alzforum.org/news/research-news/flash-beep-gamma-waves-stimulate-microglia-memory')),
                  ),
                ],
              )
            ])
    );
  }
  // String getBannerAdUnitId() {
  //   if (Platform.isIOS) {
  //     return 'ca-app-pub-4436272376536757/5875036884';
  //   } else if (Platform.isAndroid) {
  //     return 'ca-app-pub-4436272376536757/5875036884';
  //   }
  //   return null;
  // }
}
