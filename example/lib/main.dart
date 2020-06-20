import 'package:dotted_decoration/dotted_decoration.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key}) : super(key: key);

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Dotted Decoration'),
      ),
      body: SingleChildScrollView(
        child: Container(
            padding: EdgeInsets.all(10),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: <Widget>[
                _getDecorationWidget('Line', <Decoration>[
                  DottedDecoration(
                      shape: Shape.line, linePosition: LinePosition.bottom),
                  DottedDecoration(
                      shape: Shape.line,
                      linePosition: LinePosition.left,
                      color: Colors.red),
                  DottedDecoration(
                      shape: Shape.line,
                      linePosition: LinePosition.top,
                      dash: <int>[5, 1]),
                  DottedDecoration(
                      shape: Shape.line, linePosition: LinePosition.right)
                ], <String>[
                  'Bottom Line',
                  'Left Line',
                  'Top Line',
                  'Right Line'
                ]),
                _getDecorationWidget('Box', <Decoration>[
                  DottedDecoration(shape: Shape.box),
                  DottedDecoration(
                    shape: Shape.box,
                    borderRadius: BorderRadius.circular(10),
                  ),
                  DottedDecoration(
                      shape: Shape.box,
                      borderRadius:
                          BorderRadius.only(topLeft: Radius.circular(10)),
                      dash: <int>[2, 5],
                      strokeWidth: 2),
                  DottedDecoration(
                      shape: Shape.box, color: Colors.red, strokeWidth: 2),
                ], <String>[
                  'Box',
                  'Rounded Box',
                  'Custom Rounded Box',
                  'Colored Box'
                ]),
                _getDecorationWidget('Oval', <Decoration>[
                  DottedDecoration(shape: Shape.circle),
                  DottedDecoration(shape: Shape.circle, dash: <int>[1, 4]),
                ], <String>[
                  'Oval',
                  'Oval with dotted outline'
                ])
              ],
            )),
      ),
    );
  }

  _getDecorationWidget(String title, List<Decoration> decorations,
      List<String> decorationStrings) {
    return Container(
      padding: EdgeInsets.symmetric(vertical: 10),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          Text(
            title,
            style: TextStyle(color: Colors.black, fontSize: 20),
          ),
          Wrap(
            children: List.generate(
                decorations.length,
                (index) => Container(
                      width: 130,
                      margin: EdgeInsets.all(20),
                      padding: EdgeInsets.all(20),
                      decoration: decorations[index],
                      child: Text(
                        decorationStrings[index],
                        style: TextStyle(
                          fontSize: 16,
                        ),
                      ),
                    )),
          )
        ],
      ),
    );
  }
}
