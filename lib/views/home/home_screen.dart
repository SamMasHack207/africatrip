import 'package:flutter/material.dart';

import '../../models/travel_models.dart';
import '../../theme/app_theme.dart';
import '../../widgets/app_bottom_nav.dart';
import '../../widgets/app_search_field.dart';
import '../../widgets/circle_icon_button.dart';
import '../../widgets/destination_card.dart';
import '../history/history_screen.dart';
import '../profile/profile_screen.dart';
import '../search/search_screen.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int _selectedNavIndex = 0;
  int _selectedCategory = 0;

  static const List<({IconData icon, String label})> _categories = [
    (icon: Icons.flight_takeoff_rounded, label: 'Flight'),
    (icon: Icons.hotel_rounded, label: 'Hotel'),
    (icon: Icons.directions_bus_rounded, label: 'Bus'),
    (icon: Icons.directions_car_filled_rounded, label: 'Car'),
  ];

  void _openSearch() {
    Navigator.of(context).push(
      MaterialPageRoute<void>(builder: (_) => const SearchScreen()),
    );
  }

  Future<void> _onNavTap(int index) async {
    if (index == 0) return;

    setState(() => _selectedNavIndex = index);

    final Widget page = switch (index) {
      1 => const SearchScreen(),
      2 => const HistoryScreen(),
      _ => const ProfileScreen(),
    };

    await Navigator.of(context).push(
      MaterialPageRoute<void>(builder: (_) => page),
    );

    if (!mounted) return;
    setState(() => _selectedNavIndex = 0);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            Expanded(
              child: SingleChildScrollView(
                padding: const EdgeInsets.fromLTRB(20, 8, 20, 20),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        const Icon(
                          Icons.location_on_outlined,
                          size: 19,
                          color: AppColors.textPrimary,
                        ),
                        const SizedBox(width: 4),
                        const Text(
                          'Indonesia',
                          style: TextStyle(
                            fontSize: 13,
                            fontWeight: FontWeight.w600,
                            color: AppColors.textPrimary,
                          ),
                        ),
                        const Icon(
                          Icons.keyboard_arrow_down_rounded,
                          size: 18,
                          color: AppColors.textPrimary,
                        ),
                        const Spacer(),
                        CircleIconButton(
                          icon: Icons.notifications_none_rounded,
                          onTap: () {},
                        ),
                      ],
                    ),
                    const SizedBox(height: 22),
                    const Text(
                      'Good Morning,',
                      style: TextStyle(
                        fontSize: 26,
                        fontWeight: FontWeight.w600,
                        color: AppColors.textSecondary,
                        letterSpacing: -0.3,
                      ),
                    ),
                    const SizedBox(height: 2),
                    const Text(
                      'Budiarti 👋',
                      style: TextStyle(
                        fontSize: 34,
                        fontWeight: FontWeight.w800,
                        color: AppColors.textPrimary,
                        letterSpacing: -1,
                      ),
                    ),
                    const SizedBox(height: 20),
                    Row(
                      children: [
                        Expanded(
                          child: AppSearchField(onTap: _openSearch),
                        ),
                        const SizedBox(width: 10),
                        CircleIconButton(
                          icon: Icons.tune_rounded,
                          size: 56,
                          onTap: _openSearch,
                        ),
                      ],
                    ),
                    const SizedBox(height: 18),
                    SingleChildScrollView(
                      scrollDirection: Axis.horizontal,
                      clipBehavior: Clip.none,
                      child: Row(
                        children: List.generate(_categories.length, (index) {
                          final category = _categories[index];
                          return Padding(
                            padding: EdgeInsets.only(
                              right: index == _categories.length - 1 ? 0 : 10,
                            ),
                            child: _CategoryChip(
                              icon: category.icon,
                              label: category.label,
                              selected: index == _selectedCategory,
                              onTap: () =>
                                  setState(() => _selectedCategory = index),
                            ),
                          );
                        }),
                      ),
                    ),
                    const SizedBox(height: 24),
                    const Text(
                      'Popular Destinations',
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.w700,
                        color: AppColors.textPrimary,
                        letterSpacing: -0.4,
                      ),
                    ),
                    const SizedBox(height: 14),
                    GridView.builder(
                      shrinkWrap: true,
                      physics: const NeverScrollableScrollPhysics(),
                      padding: EdgeInsets.zero,
                      itemCount: popularDestinations.length,
                      gridDelegate:
                          const SliverGridDelegateWithFixedCrossAxisCount(
                            crossAxisCount: 2,
                            mainAxisSpacing: 12,
                            crossAxisSpacing: 12,
                            childAspectRatio: 0.82,
                          ),
                      itemBuilder: (context, index) {
                        final destination = popularDestinations[index];
                        return DestinationCard(
                          imageUrl: destination.imageUrl,
                          location: destination.location,
                          title: destination.title,
                          onTap: _openSearch,
                        );
                      },
                    ),
                  ],
                ),
              ),
            ),
            AppBottomNav(
              currentIndex: _selectedNavIndex,
              onTap: _onNavTap,
            ),
          ],
        ),
      ),
    );
  }
}

class _CategoryChip extends StatelessWidget {
  const _CategoryChip({
    required this.icon,
    required this.label,
    required this.selected,
    required this.onTap,
  });

  final IconData icon;
  final String label;
  final bool selected;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    final foreground = selected ? Colors.white : AppColors.textPrimary;

    return Material(
      color: selected ? AppColors.green : AppColors.cream,
      borderRadius: BorderRadius.circular(22),
      clipBehavior: Clip.antiAlias,
      child: InkWell(
        onTap: onTap,
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 11),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Icon(icon, size: 17, color: foreground),
              const SizedBox(width: 6),
              Text(
                label,
                style: TextStyle(
                  fontSize: 13,
                  fontWeight: FontWeight.w600,
                  color: foreground,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
