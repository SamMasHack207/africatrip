import 'package:flutter/material.dart';

import '../../models/travel_models.dart';
import '../../theme/app_theme.dart';
import '../../widgets/circle_icon_button.dart';
import '../../widgets/flight_route_row.dart';
import '../../widgets/ticket_card.dart';
import '../boarding/boarding_pass_screen.dart';

class SearchScreen extends StatefulWidget {
  const SearchScreen({super.key});

  @override
  State<SearchScreen> createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  int _selectedDate = 2;

  static const List<({String weekday, String day})> _dates = [
    (weekday: 'Sun', day: '12'),
    (weekday: 'Mon', day: '13'),
    (weekday: 'Tue', day: '14'),
    (weekday: 'Wed', day: '16'),
    (weekday: 'Thu', day: '17'),
    (weekday: 'Fri', day: '18'),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.fromLTRB(20, 8, 20, 0),
              child: Row(
                children: [
                  CircleIconButton(
                    icon: Icons.arrow_back_rounded,
                    onTap: () => Navigator.of(context).pop(),
                  ),
                  const Expanded(
                    child: Text(
                      'Search',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.w700,
                        color: AppColors.textPrimary,
                      ),
                    ),
                  ),
                  CircleIconButton(icon: Icons.more_horiz_rounded, onTap: () {}),
                ],
              ),
            ),
            Expanded(
              child: SingleChildScrollView(
                padding: const EdgeInsets.fromLTRB(20, 22, 20, 28),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    _RouteCard(onSearch: () {}),
                    const SizedBox(height: 26),
                    const Text(
                      'Select Date',
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.w700,
                        color: AppColors.textPrimary,
                        letterSpacing: -0.3,
                      ),
                    ),
                    const SizedBox(height: 14),
                    SingleChildScrollView(
                      scrollDirection: Axis.horizontal,
                      clipBehavior: Clip.none,
                      child: Row(
                        children: List.generate(_dates.length, (index) {
                          final date = _dates[index];
                          return Padding(
                            padding: EdgeInsets.only(
                              right: index == _dates.length - 1 ? 0 : 10,
                            ),
                            child: _DateChip(
                              weekday: date.weekday,
                              day: date.day,
                              selected: index == _selectedDate,
                              onTap: () =>
                                  setState(() => _selectedDate = index),
                            ),
                          );
                        }),
                      ),
                    ),
                    const SizedBox(height: 26),
                    Text(
                      '${availableTickets.length + 5} Tickets Found',
                      style: const TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.w700,
                        color: AppColors.textPrimary,
                        letterSpacing: -0.3,
                      ),
                    ),
                    const SizedBox(height: 14),
                    for (final ticket in availableTickets)
                      Padding(
                        padding: const EdgeInsets.only(bottom: 14),
                        child: TicketCard(
                          ticket: ticket,
                          onTap: () => Navigator.of(context).push(
                            MaterialPageRoute<void>(
                              builder: (_) =>
                                  BoardingPassScreen(ticket: ticket),
                            ),
                          ),
                        ),
                      ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _RouteCard extends StatelessWidget {
  const _RouteCard({required this.onSearch});

  final VoidCallback onSearch;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: AppColors.lime,
        borderRadius: BorderRadius.circular(28),
      ),
      child: Column(
        children: [
          const FlightRouteRow(
            originCode: 'USA',
            originCity: 'Chicago',
            destinationCode: 'IDN',
            destinationCity: 'Jakarta',
            codeColor: AppColors.dark,
            cityColor: Color(0xFF4E5A34),
            dashColor: Color(0xFF6F7F45),
            planeBackground: AppColors.dark,
          ),
          const SizedBox(height: 20),
          Row(
            children: [
              Expanded(
                child: Material(
                  color: AppColors.dark,
                  borderRadius: BorderRadius.circular(26),
                  clipBehavior: Clip.antiAlias,
                  child: InkWell(
                    onTap: onSearch,
                    child: const SizedBox(
                      height: 52,
                      child: Center(
                        child: Text(
                          'Search flights',
                          style: TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.w600,
                            color: Colors.white,
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
              ),
              const SizedBox(width: 10),
              CircleIconButton(
                icon: Icons.swap_horiz_rounded,
                size: 52,
                onTap: () {},
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class _DateChip extends StatelessWidget {
  const _DateChip({
    required this.weekday,
    required this.day,
    required this.selected,
    required this.onTap,
  });

  final String weekday;
  final String day;
  final bool selected;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return Material(
      color: selected ? AppColors.lime : AppColors.cream,
      shape: const CircleBorder(),
      clipBehavior: Clip.antiAlias,
      child: InkWell(
        onTap: onTap,
        child: SizedBox(
          width: 56,
          height: 56,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                weekday,
                style: TextStyle(
                  fontSize: 10,
                  fontWeight: FontWeight.w500,
                  color: selected
                      ? AppColors.dark
                      : AppColors.textSecondary,
                ),
              ),
              const SizedBox(height: 1),
              Text(
                day,
                style: TextStyle(
                  fontSize: 15,
                  fontWeight: FontWeight.w700,
                  color: selected ? AppColors.dark : AppColors.textPrimary,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
