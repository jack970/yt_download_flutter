import 'package:flutter/material.dart';

class CustomAppBar extends StatelessWidget {
  bool isSearching;
  TextEditingController controller;
  String title;
  Function(String)? onSubmitted;
  Function()? setIsSearching;

  CustomAppBar(
      {Key? key,
      required this.title,
      required this.isSearching,
      required this.controller,
      this.onSubmitted,
      this.setIsSearching})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SliverAppBar(
      floating: true,
      leadingWidth: 100.0,
      title: Padding(
        padding: const EdgeInsets.only(left: 12.0),
        child: isSearching
            ? TextField(
                cursorColor: Colors.white,
                controller: controller,
                onSubmitted: onSubmitted,
                decoration: const InputDecoration(
                    hintStyle: TextStyle(fontSize: 20.0, color: Colors.white),
                    hintText: "Pesquisar...",
                    prefixIcon: Icon(
                      Icons.search,
                      color: Colors.white,
                    )),
                style: const TextStyle(
                  color: Colors.white,
                  fontSize: 20,
                ),
              )
            : controller.text.isNotEmpty ? Text(controller.text) : Text(title),
      ),
      actions: [
        IconButton(
          onPressed: setIsSearching,
          icon: isSearching ? Icon(Icons.cancel) : Icon(Icons.search),
        ),
        IconButton(
            onPressed: () {}, iconSize: 40.0, icon: const Icon(Icons.menu))
      ],
    );
  }
}
