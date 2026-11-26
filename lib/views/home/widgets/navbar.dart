import 'package:africatrip/views/home/search_flights_screen.dart';
import 'package:flutter/material.dart';

class Navbar extends StatefulWidget {
  const Navbar({super.key});

  @override
  State<Navbar> createState() => _NavbarState();
}

int _selectedIndex = 0;

class _NavbarState extends State<Navbar> {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 12, vertical: 9),
      decoration: BoxDecoration(
        color: Color.fromARGB(255, 49, 59, 49).withOpacity(0.8),
        borderRadius: BorderRadius.circular(40),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          // Onglet 0 : Accueil (cercle vert actif)
          _buildNavItem(icon: Icons.home_filled, index: 0),
          // Onglet 1 : Boussole / Explore
          _buildNavItem(icon: Icons.explore_outlined, index: 1),
          // Onglet 2 : Horloge
          _buildNavItem(icon: Icons.access_time, index: 2),
          // Onglet 3 : Profil
          _buildNavItem(icon: Icons.person_outline, index: 3),
        ],
      ),
    );
  }

  Widget _buildNavItem({required IconData icon, required int index}) {
    final isSelected = _selectedIndex == index;

    return GestureDetector(
      onTap: () {
        if (index == 1) {
          // Deuxième bouton : navigation vers SecondScreen
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => const SearchFlightsScreen(),
            ),
          );
        } else {
          setState(() {
            _selectedIndex = index;
          });
        }
      },
      child: isSelected
          ? Container(
              width: 60,
              height: 60,
              decoration: const BoxDecoration(
                color: Color(0xFF74B743), // Pastille verte vive
                shape: BoxShape.circle,
              ),
              child: Icon(icon, color: Colors.white, size: 30),
            )
          : Icon(icon, color: Colors.white, size: 30),
    );
  }
}
