import 'dart:convert';
import 'package:crypto/crypto.dart';
import 'package:http/http.dart' as http;

import '../model/hero_api_classes.dart';


final publicKey = utf8.encode("YOUR_PUBLIC_API_KEY");
final privateKey = utf8.encode("YOUR_PRIVATE_API_KEY");
final timeStamp = DateTime.now().millisecondsSinceEpoch;
final hash = md5.convert(utf8.encode(timeStamp.toString()) + privateKey + publicKey);


Future<MarvelData> fetchResults(String searchString) async {

  final response = await http.get(Uri.parse(
      'https://gateway.marvel.com:443/v1/public/characters?ts=$timeStamp&nameStartsWith=$searchString&apikey=f734881eaf4e4e2421a60f973b5639c8&hash=$hash'));

  if (response.statusCode == 200) {
    return MarvelData.fromJson(jsonDecode(response.body));
  } else {
    throw Exception("Something went wrong...");
  }
}

