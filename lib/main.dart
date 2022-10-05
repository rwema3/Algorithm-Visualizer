import 'package:AlgorithmVisualizer/controllers/Controllers.dart';
import 'package:AlgorithmVisualizer/detailPages/detail_page.dart';
import 'package:AlgorithmVisualizer/model/lesson.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

void main() => runApp(new MyApp());

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  final Controllers _controllers = Controllers();

  @override
  Widget build(BuildContext context) {
    return new MaterialApp(
      title: 'Flutter Demo',
      theme: new ThemeData(
        primaryColor: Color.fromRGBO(58, 66, 86, 1.0),
        fontFamily: 'Raleway',
        primaryColorBrightness: Brightness.dark,
      ),

      home: new ListPage(
        controllers: _controllers,
      ),
      // home: DetailPage(),
    );
  }
}

class ListPage extends StatefulWidget {
  ListPage({Key key, this.controllers}) : super(key: key);

  final Controllers controllers;

  @override
  _ListPageState createState() => _ListPageState(controllers);
}

class _ListPageState extends State<ListPage> with TickerProviderStateMixin {
  final Controllers _controllers;
  int activePage = 0;

  _ListPageState(this._controllers);

  @override
  Widget build(BuildContext context) {
    ListTile makeListTile(Lesson lesson) => ListTile(
		contentPadding: EdgeInsets.symmetric(horizontal: 20.0, vertical: 10.0),
          leading: Container(
            padding: EdgeInsets.only(right: 12.0),
			  decoration: new BoxDecoration(border: new Border(right: new BorderSide(width: 1.0, color: Colors.white24))),
            child: lesson.icon,
          ),
          title: Text(
            lesson.title,
            style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
          ),
          // subtitle: Text("Intermediate", style: TextStyle(color: Colors.white)),

          subtitle: Row(
            children: <Widget>[
              Expanded(
                  flex: 1,
                  child: Container(
                    // tag: 'hero',
					  child: LinearProgressIndicator(backgroundColor: Color.fromRGBO(209, 224, 224, 0.2), value: lesson.indicatorValue, valueColor: AlwaysStoppedAnimation(Colors.green)),
                  )),
              Expanded(
                flex: 4,
				  child: Padding(padding: EdgeInsets.only(left: 10.0), child: Text(lesson.level, style: TextStyle(color: Colors.white))),
              )
            ],
          ),
		trailing: Icon(Icons.keyboard_arrow_right, color: Colors.white, size: 30.0),
          onTap: () {
			  lesson.screenSize = MediaQuery
				  .of(context)
				  .size
				  .width * MediaQuery
				  .of(context)
				  .size
				  .height;
			  Navigator.push(context, MaterialPageRoute(builder: (context) => DetailPage(lesson, _controllers)));
          },
        );



/* sources>

  https://brilliant.org/wiki/shortest-path-algorithms/

 */
