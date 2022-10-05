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

    Card makeCard(Lesson lesson) => Card(
          elevation: 8.0,
          margin: new EdgeInsets.symmetric(horizontal: 10.0, vertical: 6.0),
          child: Container(
            decoration: BoxDecoration(color: Color.fromRGBO(64, 75, 96, .9)),
            child: makeListTile(lesson),
          ),
        );

	final List<AnimationController> appBarIconAnimationController = new List<AnimationController>.generate(1, (int index) => AnimationController(vsync: this, duration: new Duration(seconds: 1)));

    final makeBody = Container(
        decoration: BoxDecoration(color: Color.fromRGBO(58, 66, 86, 1.0)),
        child: PageView(
          controller: _controllers.pageController,
          physics: AlwaysScrollableScrollPhysics(),
          pageSnapping: true,
          scrollDirection: Axis.horizontal,
          onPageChanged: (int newPage) {
            setState(() {
				setState(() {
					activePage = newPage;
				});
            });
          },
          children: createChildren(makeCard),
        ));

    final makeBottom = Container(
      height: 55.0,
      child: BottomAppBar(
        color: Color.fromRGBO(58, 66, 86, 1.0),
        child: ListView.builder(
          scrollDirection: Axis.horizontal,
          shrinkWrap: true,
			itemCount: AlgorithmTypes.values.length,
          itemBuilder: (BuildContext context, int index) {
            return IconButton(
				icon: Icon(
					AlgorithmTypes.values[index].getIcon(),
					color: activePage == index ? Colors.green : Colors.white,
					semanticLabel: 'Show menu',
				),
              onPressed: () {
				  if (activePage != index) {
					  setState(() {
						  activePage = index;
					  });
				  }
				  _controllers.pageController.animateToPage(activePage, duration: Duration(seconds: 1), curve: Curves.ease);
				  //toggleIcon(activePage + _controllers.iconAnimationControllerPositionShift);
              },
            );
          },
        ),
      ),
    );

    final topAppBar = AppBar(
      elevation: 0.1,
      backgroundColor: Color.fromRGBO(58, 66, 86, 1.0),
		title: Text(AlgorithmTypes.values[activePage].getAlgorithmToString()),
      actions: <Widget>[
        IconButton(
			icon: AnimatedIcon(
				icon: AnimatedIcons.menu_close,
				semanticLabel: 'Show menu',
				progress: appBarIconAnimationController[0],
			),
			onPressed: () {
				if (appBarIconAnimationController[0].isAnimating || appBarIconAnimationController[0].isCompleted) {
					appBarIconAnimationController[0].reverse();
				} else {
					appBarIconAnimationController[0].forward();
				}
			},
        ),
      ],
    );

    return Scaffold(
      backgroundColor: Color.fromRGBO(58, 66, 86, 1.0),
      appBar: topAppBar,
      body: makeBody,
      bottomNavigationBar: makeBottom,
    );
  }

  List<Widget> createChildren(Card makeCard(Lesson lesson)) {
    List<Widget> widgets = [];
	for (int i = 0; i < AlgorithmTypes.values.length; i++) {
      widgets.add(buildListView(makeCard, i));
    }
    return widgets;
  }

  ListView buildListView(Card makeCard(Lesson lesson), int index) {
    List<Lesson> listLessons = getLessons();
    listLessons.sort((a, b) => a.getSortingOrder().compareTo(b.getSortingOrder()));
    if (index != 0) {
		listLessons = listLessons.where((f) => f.algorithmType == AlgorithmTypes.values[index]).toList();
    }
    return ListView.builder(
      scrollDirection: Axis.vertical,
      shrinkWrap: true,
      itemCount: listLessons.length,
      itemBuilder: (BuildContext context, int listIndex) {
        return makeCard(listLessons[listIndex]);
      },
    );
  }
}

List<Lesson> getLessons() => [
      Lesson(
          title: "Dijkstra's algorithm",
          level: "Basic",
          indicatorValue: 0.2,
          complexity: "O(N²)",
          complexityDetails: "N-number of nodes",
          icon: Icon(Icons.directions_car, color: Colors.white),
          usages: "Single-source shortest path in a graph",
          simulationDetails: 7,
          additionalInformation: 3,
          algorithmTemplate: AlgorithmTemplate.graph,
		  algorithmType: AlgorithmTypes.pathFinding,
          content:
		  "Dijkstra's algorithm is an algorithm for finding the shortest paths between nodes in a graph, which may represent, for example, road networks. The algorithm exists in many variants; Dijkstra's original variant found the "
              "shortest path between two nodes, but a more common variant fixes a single node as the 'source' node and finds shortest paths from the source to all other nodes in the graph, producing a shortest-path tree."),
      Lesson(
          title: "A-star algorithm",
          level: "Intermediate",
          indicatorValue: 0.6,
          complexity: "O(b^d)",
          complexityDetails: "d-shortest path\nb-branching factor",
          icon: Icon(Icons.directions_bus, color: Colors.white),
          usages: "Finding the shortest route (GPS)",
          simulationDetails: 7,
          additionalInformation: 3,
          algorithmTemplate: AlgorithmTemplate.graph,
		  algorithmType: AlgorithmTypes.pathFinding,
          content:
		  "A* is just like Dijkstra, the only difference is that A* tries to look for a better path by using a heuristic function which gives priority to nodes that are supposed to be better than others while Dijkstra's just explore "
              "all possible paths. A* is faster than using dijkstra and uses best-first-search to speed things up. A* is basically an informed variation of Dijkstra. "),
      Lesson(
          title: "Bellman–Ford algorithm",
          

/* sources>

  https://brilliant.org/wiki/shortest-path-algorithms/

 */
