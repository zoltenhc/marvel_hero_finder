import 'package:flutter/material.dart';

import '../model/hero_api_classes.dart';

class DetailScreen extends StatelessWidget {
  final Results data;

  DetailScreen({this.data});

  @override
  Widget build(BuildContext context) {
    final imageUrl =
        "https${data.thumbnail.path.toString().substring(4)}.${data.thumbnail.extension.toString()}";

    return Scaffold(
      appBar: AppBar(
        title: Text(
          data.name,
          style: Theme.of(context).textTheme.headline1,
        ),
      ),
      body: Container(
        height: MediaQuery.of(context).size.height,
        decoration: BoxDecoration(
          image: DecorationImage(
            image: NetworkImage(imageUrl),
            fit: BoxFit.cover,
          ),
        ),
        child: Stack(
          children: [
            Positioned(
              bottom: 20,
              right: 0,
              child: Container(
                width: 300,
                color: Colors.black54,
                padding: EdgeInsets.symmetric(horizontal: 20, vertical: 5),
                child: data.description == ""
                    ? Text(
                    "Description not found. \n Appears in ${data.comics.available} comic/s.",
                    style: Theme.of(context).textTheme.headline3)
                    : Text(
                  "${data.description} \n Appears in ${data.comics.available} comic/s.",
                  style: Theme.of(context).textTheme.headline3,
                  softWrap: true,
                  overflow: TextOverflow.fade,
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
