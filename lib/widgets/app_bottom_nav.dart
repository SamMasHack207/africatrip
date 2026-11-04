import 'package:flutter/material.dart';

import '../theme/app_theme.dart';

class AppBottomNav extends StatelessWidget {
  const AppBottomNav({
    super.key,
    required this.currentIndex,
    required this.onTap,
  });

  final int currentIndex;
  final ValueChanged<int> onTap;

  static const List<IconData> _icons = [
    Icons.home_rounded,
    Icons.public_rounded,
    Icons.schedule_rounded,
    Icons.person_outline_rounded,
  ];

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(20, 0, 20, 16),
      child: Material(
        color: AppColors.dark,
        borderRadius: BorderRadius.circular(37),
        clipBehavior: Clip.antiAlias,
        child: SizedBox(
          height: 74,
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 6),
            child: Row(
              children: List.generate(_icons.length, (index) {
                final selected = index == currentIndex;
                return Expanded(
                  child: InkWell(
                    borderRadius: BorderRadius.circular(28),
                    onTap: () => onTap(index),
                    child: Center(
                      child: AnimatedContainer(
                        duration: const Duration(milliseconds: 220),
                        width: selected ? 48 : 44,
                        height: selected ? 48 : 44,
                        decoration: BoxDecoration(
                          color: selected ? AppColors.lime : Colors.transparent,
                          shape: BoxShape.circle,
                        ),
                        child: Icon(
                          _icons[index],
                          size: 22,
                          color: selected
                              ? AppColors.dark
                              : Colors.white.withValues(alpha: 0.85),
                        ),
                      ),
                    ),
                  ),
                );
              }),
            ),
          ),
        ),
      ),
    );
  }
}
