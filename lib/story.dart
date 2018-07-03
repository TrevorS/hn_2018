import 'package:firebase_database/firebase_database.dart';

const _ID = 'id';
const _TITLE = 'title';
const _BY = 'by';
const _URL = 'url';
const _SCORE = 'score';
const _TIME = 'time';
const _DESCENDANTS = 'descendants';

class Story {
  int id;
  String title;
  String by;
  int score;
  Uri url;
  int hoursSince;
  int commentCount;

  Story(Map<dynamic, dynamic> map) {
    id = map[_ID];
    title = map[_TITLE];
    by = map[_BY];
    score = map[_SCORE];
    url = _getUrl(map[_URL]);
    hoursSince = _hoursSince(map[_TIME]);
    commentCount = _commentCount(descendants: map[_DESCENDANTS]);
  }

  Story.from(DataSnapshot dataSnapshot) {
    Story(dataSnapshot.value);
  }

  _getUrl(possibleUrl) =>
      possibleUrl != null ? Uri.dataFromString(possibleUrl) : null;

  _hoursSince(int time) => 0;

  _commentCount({int descendants = 0}) => descendants;
}
