import 'package:africatrip/views/home/widgets/categories_list.dart';
import 'package:africatrip/views/home/widgets/destinations_grid.dart';
import 'package:flutter/material.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.yellow[50],
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
      backgroundColor: const Color(0xfffcf7f3),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  const Spacer(),
                  Container(
                    width: 32,
                    height: 32,
                    decoration: BoxDecoration(
                      color: Colors.white70,
                      shape: BoxShape.circle,
                    ),
                    child: Icon(Icons.notifications_none, size: 22),
                  ),
                ],
              ),
              Text(
                "GOOD Morning,",
                style: TextStyle(
                  fontSize: 24,
                  color: Colors.grey[400],
                  fontWeight: FontWeight.w600,
                ),
              ),
              SizedBox(height: 10),
              Text(
                "Budiarti 🫣",
                style: TextStyle(
                  fontWeight: FontWeight.w800,
                  fontSize: 34,
                  color: Colors.black,
                ),
              ),
              SizedBox(height: 20),
              Row(
                children: [
                  Expanded(
                    child: Container(
                      height: 50,
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(22),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black.withOpacity(0.2),
                            blurRadius: 1,
                            // spreadRadius: 0,
                            offset: const Offset(0, 1),
                          ),
                        ],
                      ),
                      child: TextField(
                        decoration: InputDecoration(
                          hintText: "search here ...",
                          prefixIcon: Icon(Icons.search_outlined),
                          // filled: true,
                          // fillColor: Colors.white,
                          border: OutlineInputBorder(
                            borderSide: BorderSide.none,
                            borderRadius: BorderRadius.circular(30),
                          ),
                        ),
                      ),
                    ),
                  ),
                  SizedBox(width: 10),
                  Container(
                    width: 50,
                    height: 50,
                    decoration: BoxDecoration(
                      color: Colors.white,
                      shape: BoxShape.circle,
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withOpacity(0.2),
                          blurRadius: 2,
                          // spreadRadius: 5,
                          offset: const Offset(0, 1),
                        ),
                      ],
                    ),
                    child: Icon(Icons.filter_alt_outlined),
                  ),
                ],
              ),
              const SizedBox(height: 30),
              CategoriesList(),
              const SizedBox(height: 30),
              Text(
                "Popular Destinations",
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 35),
              ),
              DestinationsGrid(),
            ],
          ),
        ),
      ),
    );
  }
}
