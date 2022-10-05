

  Row buildAppBar(BuildContext context) {
    return Row(
		mainAxisAlignment: MainAxisAlignment.start,
		children: <Widget>[
			Container(
				padding: EdgeInsets.symmetric(horizontal: 24),
				child: InkWell(
					onTap: () {
						Navigator.pop(context);
					},
					child: Icon(Icons.arrow_back, color: Colors.black, size: 24),
				),
			),
			Container(
				child: new Text(
					simulation.lesson.stateDescription,
					style: TextStyle(color: Colors.black),
				),
			)
		],
    );
  }
}

class GameWrapper extends StatefulWidget {
  final SimulationAlgorithm simulation;
  final Controllers _controllers;

  GameWrapper(this.simulation, this._controllers);

  @override
  Game createState() => Game(simulation, _controllers);
}
