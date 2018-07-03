import 'dart:async';

import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_database/firebase_database.dart';

import 'story.dart';

const _PER_PAGE = 20;

class HNClient {
  final String _appName = 'HN2018';
  final String _googleAppID = '1:755998112179:ios:2dfd2ab34fc646e1';
  final String _gcmSenderID = '755998112179';
  final String _databaseURL = 'https://hacker-news.firebaseio.com';

  FirebaseDatabase db;

  Future<FirebaseApp> _configure() async {
    final FirebaseOptions options = FirebaseOptions(
      googleAppID: _googleAppID,
      gcmSenderID: _gcmSenderID,
      databaseURL: _databaseURL,
    );

    return await FirebaseApp.configure(name: _appName, options: options);
  }

  Future<void> connect() async {
    FirebaseApp app = await _configure();

    db = FirebaseDatabase(app: app);

    return;
  }

  Future<List<Story>> getTopStories({page = 1}) {
    return db.reference().child('/v0/topstories/').once().then(
        (DataSnapshot snapshot) async {
          var allIds = snapshot.value;
          var ids = _getPageIds(allIds, page);

          return (await getItems(ids)).map((item) => Story.from(item)).toList();
        }
    );
  }

  Future<List<DataSnapshot>> getItems(List<dynamic> ids) async {
    List<DataSnapshot> items = [];

    for (var id in ids) {
      var item = await getItem(id);

      items.add(item);
    }

    return items;
  }

  Future<DataSnapshot> getItem(int id) async {
    return await db.reference().child('/v0/item/$id').once();
  }

  List<dynamic> _getPageIds(List<dynamic> ids, page) {
    var start = (page - 1) * _PER_PAGE;
    var end = page * _PER_PAGE;

    return ids.sublist(start, end);
  }
}
