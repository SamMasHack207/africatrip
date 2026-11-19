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
            Container(
              child: Row(
                children: [
                  Expanded(
                    child: Container(
                      decoration: BoxDecoration(
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black.withOpacity(0.3),
                            blurRadius: 8,
                            // spreadRadius: 5,
                            // offset: const Offset(6, 1),
                          ),
                        ],
                      ),
                      child: TextField(
                        decoration: InputDecoration(
                          hintText: "search here ...",
                          prefixIcon: Icon(Icons.search_outlined),
                          filled: true,
                          fillColor: Colors.white54,
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
                    width: 40,
                    height: 40,
                    decoration: BoxDecoration(
                      color: Colors.white,
                      shape: BoxShape.circle,
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withOpacity(0.3),
                          blurRadius: 6,
                          // spreadRadius: 5,
                          offset: const Offset(6, 1),
                        ),
                      ],
                    ),
                    child: Icon(Icons.filter_alt_outlined),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 10),
            SingleChildScrollView(
              scrollDirection: Axis.horizontal,

              child: Row(
                children: [
                  Container(
                    width: 80,
                    height: 30,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(22),
                      color: Colors.green,
                    ),
                    child: Center(child: Text("Flight")),
                  ),

                  SizedBox(width: 10),

                  Container(
                    width: 80,
                    height: 30,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(22),
                      color: Colors.orange,
                    ),
                    child: Center(child: Text("Hotel")),
                  ),

                  SizedBox(width: 10),

                  Container(
                    width: 80,
                    height: 30,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(22),
                      color: Colors.blue,
                    ),
                    child: Center(child: Text("Bus")),
                  ),

                  SizedBox(width: 10),

                  Container(
                    width: 80,
                    height: 30,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(22),
                      color: Colors.red,
                    ),
                    child: Center(child: Text("Car")),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
