import 'package:flutter/material.dart';
import "json_parsing.dart";

class ParseWidget extends StatefulWidget {
  final int val;
  ParseWidget(this.val);

  int get value => this.val;

  @override
  _ParseWidgetState createState() => _ParseWidgetState();
}

class _ParseWidgetState extends State<ParseWidget> {
  late Future<ParseJSON> futureParseJSON;

  @override
  void initState() {
    super.initState();
    futureParseJSON = parse();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Parse JSON',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: Scaffold(
        appBar:
            AppBar(title: const Text('Fetch Data Example'), actions: <Widget>[
          IconButton(
            icon: Icon(Icons.arrow_back),
            onPressed: () {
              Navigator.pop(context, widget.value + 1);
            },
          ),
        ]),
        body: Center(
          child: FutureBuilder<ParseJSON>(
            future: futureParseJSON,
            builder: (context, snapshot) {
              if (snapshot.hasData) {
                return Text(snapshot.data!.message);
              } else if (snapshot.hasError) {
                return Text('${snapshot.error}');
              }
              return const CircularProgressIndicator();
            },
          ),
        ),
      ),
    );
  }
}
