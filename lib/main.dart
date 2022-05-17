import 'package:flutter/material.dart';
import 'package:yt_download/views/home.dart';

void main() {
  runApp(
    MaterialApp(
      title: 'YT Downloader',
      theme: ThemeData(
        primarySwatch: Colors.red,
      ),
      home: const MyHomePage(title: 'Flutter Demo Home Page'),
    ),
  );
}
