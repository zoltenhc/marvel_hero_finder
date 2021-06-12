import 'package:flutter/material.dart';

import '../model/hero_api_classes.dart';
import '../screens/detail_screen.dart';

class FetchResult extends StatelessWidget {
  final Future<MarvelData> futureResult;
  FetchResult(this.futureResult);

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<MarvelData> (
      future: futureResult,
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          return ListView.builder(
              itemCount: snapshot.data.data.count,
              itemBuilder: (context, index) {
                return InkWell(
                  onTap: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) =>
                                DetailScreen(
                                    data: snapshot.data.data
                                        .results[index])));
                  },
                  child: Container(
                    margin: EdgeInsets.all(10),
                    height: 200,
                    decoration: BoxDecoration(
                        border: Border.all(
                          width: 2,
                          color: Color.fromRGBO(81, 140, 202, 1),
                        ),
                        borderRadius: BorderRadius.circular(10),
                        color: Color.fromRGBO(81, 140, 202, 1)),
                    child: Stack(
                      children: [
                        ClipRRect(
                          borderRadius:
                          BorderRadius.circular(10),
                          child: Image.network(
                            "https${snapshot.data.data.results[index]
                                .thumbnail.path.toString()
                                .substring(4)}.${snapshot.data.data
                                .results[index].thumbnail.extension
                                .toString()}",
                            fit: BoxFit.cover,
                            width: double.infinity,
                            loadingBuilder: (context, child,
                                loadingProgress) {
                              if (loadingProgress == null) {
                                return child;
                              }
                              return Center(
                                child: CircularProgressIndicator(
                                  value: loadingProgress
                                      .expectedTotalBytes != null
                                      ? loadingProgress
                                      .cumulativeBytesLoaded /
                                      loadingProgress.expectedTotalBytes
                                      : null,
                                ),
                              );
                            },
                          ),
                        ),
                        Positioned(
                          bottom: 20,
                          right: 0,
                          child: Container(
                            width: 300,
                            color: Colors.black54,
                            padding: EdgeInsets.symmetric(
                                horizontal: 20, vertical: 5),
                            child: Text(
                              "${snapshot.data.data.results[index].name}",
                              style: TextStyle(
                                fontSize: 26,
                                color: Color.fromRGBO(247, 143, 63, 1),
                              ),
                              softWrap: true,
                              overflow: TextOverflow.fade,
                            ),
                          ),
                        )
                      ],
                    ),
                  ),
                );
              });
        } else if (snapshot.hasError) {
          return Text("${snapshot.error}");
        }else {
          return Center(
            child: SizedBox(
              child: CircularProgressIndicator(),
              width: 60,
              height: 60,
            ),
          );
        }
      },
    );
  }
}
