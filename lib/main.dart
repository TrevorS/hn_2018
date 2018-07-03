import 'dart:async';

import 'package:flutter/material.dart';

import 'hn_client.dart';
import 'stories_list.dart';

final String appTitle = 'HN 2018';
final String appBarTitle = 'Hacker News';

Future<void> main() async {
  final hnClient = HNClient();

  await hnClient.connect();

  final hnApp = MaterialApp(
    title: appTitle,
    home: StoriesList(
      hnClient: hnClient,
      appBarTitle: appBarTitle,
    ),
  );

  runApp(hnApp);
}

