import 'package:flutter/material.dart';
import 'package:lab4/model_colors.dart';
import 'package:provider/provider.dart';
import "app_bar.dart";
import "theme.dart";

void main() {
  runApp(ChangeNotifierProvider(
      create: (_) => ChangeColor(Color.fromRGBO(133, 133, 133, 0.9)),
      child: MyApp()));
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
        create: (_) => ThemeNotifier(),
        child: Consumer<ThemeNotifier>(
            builder: (context, ThemeNotifier notifier, child) {
          return MaterialApp(
            title: 'Flutter Demo',
            theme: notifier.darkMode ? darkMode : lightMode,
            initialRoute: '/',
            routes: {
              '/': (context) => MyHomePage(),
              '/screen1': (context) => Screen1(),
            },
          );
        }));
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key, this.title = "demo"}) : super(key: key);

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class Screen1 extends StatefulWidget {
  @override
  _Screen1State createState() => _Screen1State();
}

class _Screen1State extends State<Screen1> with TickerProviderStateMixin {
  int value = 0;
  late AnimationController _controller;
  late AnimationController _colorController;
  late Animation<Color?> _colorTween;

  @override
  void initState() {
    super.initState();

    _controller = AnimationController(
      duration: const Duration(milliseconds: 2000),
      vsync: this,
    );
    _colorController = AnimationController(
      duration: const Duration(milliseconds: 2000),
      vsync: this,
    );

    _colorTween = ColorTween(begin: Colors.red, end: Colors.green)
        .animate(_colorController);
    _colorController
      ..addListener(() {
        setState(() {});
      });
    _controller.repeat(reverse: true);
    _colorController.forward();
    _colorController.repeat(reverse: true);
  }

  @override
  void dispose() {
    _controller.dispose();
    _colorController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) => Scaffold(
          body: GestureDetector(
        onTap: () {
          Navigator.pop(context);
        },
        child: Column(
          children: <Widget>[
            RotationTransition(
                turns: Tween(begin: 0.0, end: 1.0).animate(_controller),
                child: Hero(
                    tag: 'profile_photo',
                    child: Image.asset('assets/images/scroll.jpg'))),
            ElevatedButton(
              child: Text("go"),
              onPressed: () => _controller.forward(),
            ),
            ElevatedButton(
              style: ButtonStyle(
                  backgroundColor:
                      MaterialStateProperty.all<Color>(_colorTween.value!)),
              child: Text("reset"),
              onPressed: () => _controller.reset(),
            ),
          ],
        ),
      ));
}

class _MyHomePageState extends State<MyHomePage> {
  var counter = 0;
  var currentIndex = 0;

  void changeFloatingButton() {
    setState(() {
      currentIndex += 1;
      if (currentIndex == 3) {
        currentIndex = 0;
      }
    });
  }

  Widget getFloatingButton() {
    List<Widget> buttons = [
      FloatingActionButton(
        child: Icon(Icons.favorite),
        backgroundColor: Colors.black54,
        onPressed: () {},
      ),
      FloatingActionButton(
        child: Icon(Icons.audiotrack),
        backgroundColor: Colors.black54,
        onPressed: () {},
      ),
      FloatingActionButton(
        child: Icon(Icons.beach_access),
        backgroundColor: Colors.black54,
        onPressed: () {},
      ),
    ];

    return IndexedStack(
      index: currentIndex,
      children: buttons,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBarWidget(changeFloatingButton),
      floatingActionButton: getFloatingButton(),
      body: SingleChildScrollView(
          scrollDirection: Axis.vertical,
          child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                SingleChildScrollView(
                  scrollDirection: Axis.horizontal,
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: List.generate(
                        8,
                        (index) => Container(
                              decoration: BoxDecoration(boxShadow: [
                                BoxShadow(
                                  color: Colors.grey.shade50,
                                  spreadRadius: 5,
                                  blurRadius: 7,
                                  offset: Offset(0, 3),
                                )
                              ]),
                              padding: EdgeInsets.all(13),
                              child: GestureDetector(
                                  onTap: () {
                                    Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) => Screen1()),
                                    );
                                  },
                                  child: Hero(
                                    tag: 'profile_photo',
                                    child: CircleAvatar(
                                      radius: 19,
                                      backgroundImage: AssetImage(
                                          "assets/images/scroll.jpg"),
                                    ),
                                  )),
                            )),
                  ),
                ),
                Divider(),
                Container(
                  padding: EdgeInsets.only(left: 5, right: 5, bottom: 10),
                  child: Consumer<ThemeNotifier>(
                    builder: (context, notifier, child) => SwitchListTile(
                      title: Text("Switch Theme"),
                      onChanged: (val) {
                        notifier.switchTheme();
                      },
                      value: notifier.darkMode,
                    ),
                  ),
                ),
                SingleChildScrollView(
                  scrollDirection: Axis.vertical,
                  child: Column(
                      children: List.generate(
                          8,
                          (index) => Row(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  tweetAvatar(),
                                  tweetBody(),
                                  Divider(color: Colors.grey.shade200),
                                ],
                              ))),
                ),
              ])),
      bottomNavigationBar: BottomNavigationBar(
          items: [
            BottomNavigationBarItem(icon: Icon(Icons.home), label: "home"),
            BottomNavigationBarItem(icon: Icon(Icons.search), label: "search"),
            BottomNavigationBarItem(
                icon: Icon(Icons.notifications), label: "notification"),
            BottomNavigationBarItem(
                icon: Icon(Icons.mail_outline), label: "message")
          ],
          unselectedItemColor: Colors.grey.shade600,
          currentIndex: counter,
          fixedColor: Colors.blue,
          onTap: (int intIndex) {
            setState(() {
              counter = intIndex;
            });
          }),
    );
  }

  Widget tweetAvatar() {
    return Container(
      margin: const EdgeInsets.all(10.0),
      child: CircleAvatar(
        backgroundImage: AssetImage("assets/images/scroll.jpg"),
      ),
    );
  }

  Widget tweetBody() {
    return Expanded(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Container(
                margin: const EdgeInsets.only(right: 5.0),
                child: Text(
                  'Nickname',
                  style: TextStyle(
                    color: Colors.black,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              Consumer<ChangeColor>(
                  builder: (context, changeColor, child) => Text(
                        '@nickname',
                        style: TextStyle(
                          color: changeColor.color,
                        ),
                      )),
              Spacer(),
              IconButton(
                icon: Icon(
                  Icons.more_horiz,
                  size: 14.0,
                  color: Colors.grey,
                ),
                onPressed: () {
                  Provider.of<ChangeColor>(context, listen: false)
                      .changeColor();
                },
              ),
            ],
          ),
          Text(
            'Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat.',
            overflow: TextOverflow.clip,
          ),
          Container(
            margin: const EdgeInsets.only(top: 7.0, right: 20.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                IconButton(
                  onPressed: () {
                    Navigator.pushNamed(context, '/screen1');
                  },
                  icon: Icon(Icons.comment, color: Colors.grey.shade600),
                ),
                IconButton(
                  onPressed: () {},
                  icon: Icon(Icons.ios_share, color: Colors.grey.shade600),
                ),
                IconButton(
                  onPressed: () {},
                  icon: Icon(Icons.favorite, color: Colors.grey.shade600),
                ),
                IconButton(
                  onPressed: () {},
                  icon: Icon(Icons.share, color: Colors.grey.shade600),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
