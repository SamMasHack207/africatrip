import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class CategoriesList extends StatefulWidget {
  const CategoriesList({super.key});

  @override
  State<CategoriesList> createState() => _CategoriesListState();
}

class _CategoriesListState extends State<CategoriesList> {
  // int _index_selected = 0;
  static const List<({IconData icon, String label})> _categories = [
    (icon: Icons.flight_sharp, label: "Flight"),
    (icon: Icons.hotel, label: "Hotel"),
    (icon: Icons.directions_bus, label: "Bus"),
    (icon: Icons.directions_car, label: "Car"),
  ];
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: Row(
        children: List.generate(_categories.length, (index) {
          final categorie = _categories[index];
          //final selected = index == _index_selected;
          // final foreground = selected ? Colors.white : Colors.black87;
          return Padding(
            padding: EdgeInsets.only(
              right: index == _categories.length - 1 ? 0 : 10,
            ),
            child: Material(
              borderRadius: BorderRadius.circular(22),
              child: Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: 16,
                  vertical: 11,
                ),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Icon(categorie.icon),
                    const SizedBox(width: 6),
                    Text(categorie.label),
                  ],
                ),
              ),
            ),
          );
        }),
      ),
    );
  }
}
