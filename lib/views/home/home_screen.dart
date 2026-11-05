import 'package:flutter/material.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Row(
          children: [
            Icon(Icons.location_on_outlined, size: 24),
            SizedBox(width: 0),
            Text(
              "Indonesia",
              style: TextStyle(fontSize: 12, fontWeight: FontWeight.w500),
            ),
            SizedBox(width: 0),
            Icon(Icons.keyboard_arrow_down, size: 17),
          ],
        ),
      ),
      backgroundColor: Colors.white,
      body: Column(
        children: [
          Row(
            // crossAxisAlignment: CrossAxisAlignment.,
            children: [
              Container(
                width: 32,
                height: 32,
                decoration: BoxDecoration(
                  color: Colors.white,
                  shape: BoxShape.circle,
                ),
                child: Icon(Icons.notifications_none, size: 22),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
