import 'package:flutter/material.dart';

class SearchFlightsScreen extends StatefulWidget {
  const SearchFlightsScreen({super.key});

  @override
  State<SearchFlightsScreen> createState() => _SearchFlightsScreenState();
}

class _SearchFlightsScreenState extends State<SearchFlightsScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        title: Row(
          children: [
            Container(child: Icon(Icons.arrow_back_ios_new)),
            Text("Search"),
            Container(child: Icon(Icons.more_horiz_outlined)),
          ],
        ),
      ),
    );
  }
}
