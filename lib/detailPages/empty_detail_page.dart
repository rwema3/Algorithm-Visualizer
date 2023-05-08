  EmptyHomePage(Lesson lesson, Controllers controllers) : super(lesson, controllers);

  @override
  Container bottomContent() {
    return Container(
      width: MediaQuery.of(context).size.width,
      padding: EdgeInsets.all(30.0),
      child: Center(
        child: Column(
          children: <Widget>[getBottomContentText()],
        ),
      ),
    );
  }
}
