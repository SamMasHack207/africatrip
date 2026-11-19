import 'package:flutter/material.dart';

class CategoriesList extends StatefulWidget {
  const CategoriesList({super.key});

  @override
  State<CategoriesList> createState() => _CategoriesListState();
}

class _CategoriesListState extends State<CategoriesList> {
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: Row(
        spacing: 10,
        children: [
          optionBuilder(
            label: "Flight",
            icon: Icons.flight_outlined,
            isActivated: true,
          ),
          optionBuilder(
            label: "Hotel",
            icon: Icons.apartment_outlined,
            isActivated: false,
          ),
          optionBuilder(
            label: "Bus",
            icon: Icons.directions_bus_outlined,
            isActivated: false,
          ),
          optionBuilder(
            label: "Car",
            icon: Icons.directions_car_outlined,
            isActivated: false,
          ),
        ],
      ),
    );
  }

  Widget optionBuilder({
    required String label,
    required IconData icon,
    required bool isActivated,
  }) {
    return Container(
      padding: EdgeInsets.symmetric(vertical: 10, horizontal: 20),
      height: 45,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(22),
        color: isActivated ? Color(0xff6ba83a) : Colors.grey[300],
      ),
      child: Row(
        children: [
          Icon(icon, color: isActivated ? Colors.white : Colors.black),
          const SizedBox(width: 2),
          Text(
            label,
            style: TextStyle(
              color: isActivated ? Colors.white : Colors.black,
              fontWeight: FontWeight.bold,
              fontSize: 16,
            ),
          ),
        ],
      ),
    );
  }
}
