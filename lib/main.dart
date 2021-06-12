import 'package:flutter/material.dart';

import './model/hero_api_classes.dart';
import './providers/search.dart';
import './widgets/results.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Marvel Universe',
      theme: ThemeData(
          primaryColor: const Color.fromRGBO(226, 54, 54, 1),
          fontFamily: "Marvel",
          textTheme: TextTheme(
              headline1: TextStyle(
                fontSize: 40,
                letterSpacing: 3,
                color: Colors.white,
              ),
              headline2: TextStyle(
                  color: const Color.fromRGBO(80, 74, 74, 1), fontSize: 20),
              headline3: TextStyle(
                  color: const Color.fromRGBO(247, 143, 63, 1), fontSize: 25))),
      home: MyForm(),
    );
  }
}

// Define a custom Form widget.
class MyForm extends StatefulWidget {
  @override
  _MyFormState createState() => _MyFormState();
}

// Define a corresponding State class.
// This class holds the data related to the Form.
class _MyFormState extends State<MyForm> {
  Future<MarvelData> futureResult;
  String searchString;
  final myController = TextEditingController();
  FocusNode focusNode = new FocusNode();

  @override
  void dispose() {
    // Clean up the controller when the widget is disposed.
    myController.dispose();
    super.dispose();
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    futureResult = fetchResults(searchString);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Center(
          child: Text("MARVEL", style: Theme.of(context).textTheme.headline1),
        ),
        backgroundColor: Theme.of(context).primaryColor,
      ),
      body: Container(
        height: MediaQuery.of(context).size.height,
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment
                .bottomRight, // 10% of the width, so there are ten blinds.
            colors: <Color>[
              Colors.black,
              const Color.fromRGBO(81, 140, 202, 1)
            ],
          ),
        ),
        child: ListView(
          children: [
            Container(
              margin: EdgeInsets.only(left: 10, right: 10),
              decoration: BoxDecoration(
                  border: Border.all(
                      width: 3, color: const Color.fromRGBO(81, 140, 202, 1)),
                  borderRadius: BorderRadius.only(
                      bottomRight: Radius.circular(10),
                      bottomLeft: Radius.circular(10)),
                  color: const Color.fromRGBO(247, 143, 63, 1)),
              child: TextField(
                onEditingComplete: () {
                  focusNode.unfocus();
                  if (myController.text != "") {
                    setState(() {
                      searchString = myController.text;
                      futureResult = fetchResults(searchString);
                    });
                  }
                },
                focusNode: focusNode,
                controller: myController,
                style: Theme.of(context).textTheme.headline2,
                decoration: InputDecoration(
                    labelText: 'Search for Heroes',
                    contentPadding: EdgeInsets.symmetric(horizontal: 10)),
              ),
            ),
            SizedBox(height: 10),
            Container(
              margin: EdgeInsets.only(left: 10, right: 10),
              child: TextButton(
                onPressed: () {
                  focusNode.unfocus();
                  if (myController.text != "") {
                    setState(() {
                      searchString = myController.text;
                      futureResult = fetchResults(searchString);
                    });
                  }
                },
                child: Text(
                  "Search",
                  style: TextStyle(color: const Color.fromRGBO(80, 74, 74, 1)),
                ),
                style: TextButton.styleFrom(
                  backgroundColor: const Color.fromRGBO(247, 143, 63, 1),
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10)),
                  padding: EdgeInsets.all(5),
                  side: BorderSide(
                      color: const Color.fromRGBO(81, 140, 202, 1), width: 3),
                ),
              ),
            ),
            Container(
              height: MediaQuery.of(context).size.height - 200,
              child: searchString != null
                  ? FetchResult(futureResult)
                  : Center(
                      child: Text(
                        "Have fun exploring Marvel Universe",
                        textAlign: TextAlign.center,
                        style: TextStyle(
                            color: const Color.fromRGBO(81, 140, 202, 1),
                            fontSize: 55),
                      ),
                    ),
            )
          ],
        ),
      ),
    );
  }
}
