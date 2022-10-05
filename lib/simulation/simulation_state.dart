                    onChanged: (value) {
						setState(() => simulation.abstractSimulationExecutor.speedFactor = value.floor());
                    },
					  value: simulation.abstractSimulationExecutor.speedFactor.floorToDouble(),
                  ),
                ),
                Container(
                  width: 60.0,
                  alignment: Alignment.centerLeft,
					child: Text('${simulation.abstractSimulationExecutor.speedFactor}', style: Theme
						.of(context)
						.textTheme
						.display1),
                ),
              ],
            ))
      ],
    );
  }

  Container buildSimulator(BuildContext context) {
	  return Container(padding: EdgeInsets.fromLTRB(30.0, 24.0, 30.0, 24.0), width: MediaQuery
		  .of(context)
		  .size
		  .width, height: MediaQuery
		  .of(context)
		  .size
		  .height - 124, child: simulation.widget);
  }

  Container buildDivider(BuildContext context) {
    return Container(
      width: 90.0,
		padding: EdgeInsets.fromLTRB(24, 0, MediaQuery
			.of(context)
			.size
			.width - 48 - 90, 0),
      alignment: Alignment.centerLeft,
      child: new Divider(color: Colors.green),
    );
  }

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
