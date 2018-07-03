import 'package:flutter/material.dart';

import 'hn_client.dart';

class StoriesList extends StatefulWidget {
  final HNClient hnClient;
  final String appBarTitle;

  StoriesList({this.hnClient, this.appBarTitle});

  @override
  StoriesListState createState() => StoriesListState();
}

class StoriesListState extends State<StoriesList> {
  List<Text> _titles = [];

  @override
  void initState() {
    super.initState();

    widget.hnClient.getTopStories().then((stories) {
      var titles = stories.map((story) => Text(story.title)).toList();

      setState(() {
        _titles = titles;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.appBarTitle),
      ),
      body: new Center(
        child: ListView(
          children: _titles,
        ),
      ),
    );
  }
}
