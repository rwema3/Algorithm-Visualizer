
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
