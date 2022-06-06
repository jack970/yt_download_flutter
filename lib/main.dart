import 'package:flutter/material.dart';
import 'package:yt_download/views/download_phone_screen.dart';
import 'package:yt_download/views/home.dart';

void main() {
  runApp(
    MaterialApp(
      title: 'YT Downloader',
      theme: ThemeData(
        primarySwatch: Colors.red,
      ),
      initialRoute: '/',
      routes: {
        '/': (context) => MyHomePage(title: 'Youtube Downloader',),
        '/Downloads': (context) => DownloadPhoneScreen()
      },
    ),
  );
}
