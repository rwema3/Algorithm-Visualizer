part of 'detail_page.dart';

class GraphHomePage extends HomePage {
  GraphHomePage(Lesson lesson, Controllers controllers) : super(lesson, controllers);

  Container getSimulationStepSwitch(BuildContext context) {
	  return Container(
		  padding: EdgeInsets.symmetric(vertical: 16.0),
		  width: MediaQuery
	