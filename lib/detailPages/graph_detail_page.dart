part of 'detail_page.dart';

class GraphHomePage extends HomePage {
  GraphHomePage(Lesson lesson, Controllers controllers) : super(lesson, controllers);

  Container getSimulationStepSwitch(BuildContext context) {
	  return Container(
		  padding: EdgeInsets.symmetric(vertical: 16.0),
		  width: MediaQuery
			  .of(context)
			  .size
			  .width,
		  child: Row(
			  mainAxisAlignment: MainAxisAlignment.spaceBetween,
			  children: <Widget>[
				  Container(
					  child: Text(getStepMessage(), style: TextStyle(color: Colors.black)),
				  ),
				  Switch(
					  value: askForInformation(lesson.simulationDetails, lesson.stepByStep),
					  onChanged: (value) {
						  setState(() {
							  changeSimulationDetails(lesson.stepByStep);
						  });
					  },
					  activeTrackColor: Colors.lightGreenAccent,
					  activeColor: Colors.green,
				  ),
			  ],
		  ));
  }

  Container getNumberOfEdgesSlider(BuildContext context) {
    return askForInformation(lesson.simulationDetails, lesson.askForEdges)
        ? Container(
            padding: EdgeInsets.symmetric(vertical: 16.0),
            width: MediaQuery.of(context).size.width,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Flexible(
                  flex: 1,
                  child: Slider(
                    activeColor: Colors.green,
                    min: minEdges(),
                    max: maxEdges(),
                    onChanged: (value) {
                      setState(() {
                        return lesson.edges = value;
                      });
                    },
                    value: minMaxEdges(),
                  ),
                ),
                Container(
                  width: 80.0,
                  alignment: Alignment.center,
                  child: Text('${lesson.edges.toInt()}', style: Theme.of(context).textTheme.display1),
                ),
              ],
            ))
        : Container();
  }

  Container getNumberOfEdgesText(BuildContext context) {
    return askForInformation(lesson.simulationDetails, lesson.askForEdges)
        ? Container(
   