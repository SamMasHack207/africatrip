import 'package:flutter/material.dart';

import '../models/travel_models.dart';
import '../theme/app_theme.dart';
import 'flight_route_row.dart';

class TicketCard extends StatelessWidget {
  const TicketCard({super.key, required this.ticket, this.onTap});

  final FlightTicket ticket;
  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    return Material(
      color: AppColors.cream,
      borderRadius: BorderRadius.circular(24),
      clipBehavior: Clip.antiAlias,
      child: InkWell(
        onTap: onTap,
        child: Column(
          children: [
            Container(
              width: double.infinity,
              padding: const EdgeInsets.symmetric(vertical: 9),
              color: AppColors.creamDark,
              child: Text(
                ticket.airline,
                textAlign: TextAlign.center,
                style: const TextStyle(
                  fontSize: 11,
                  fontWeight: FontWeight.w600,
                  color: AppColors.textPrimary,
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.fromLTRB(18, 16, 18, 16),
              child: Column(
                children: [
                  FlightRouteRow(
                    originCode: ticket.originCode,
                    originCity: ticket.originCity,
                    destinationCode: ticket.destinationCode,
                    destinationCity: ticket.destinationCity,
                    planeBackground: AppColors.dark,
                  ),
                  const SizedBox(height: 18),
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Expanded(
                        child: _TimeColumn(
                          day: ticket.departureDay,
                          time: ticket.departureTime,
                          alignment: CrossAxisAlignment.start,
                        ),
                      ),
                      Expanded(
                        child: _TimeColumn(
                          day: ticket.arrivalDay,
                          time: ticket.arrivalTime,
                          alignment: CrossAxisAlignment.end,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
            Container(
              color: AppColors.green,
              padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 12),
              child: Row(
                children: [
                  Expanded(
                    child: _Info(label: 'Seats', value: ticket.seats),
                  ),
                  Expanded(
                    child: _Info(
                      label: 'Terminal',
                      value: ticket.terminal,
                      centered: true,
                    ),
                  ),
                  Expanded(
                    child: _Info(label: 'Gate', value: ticket.gate, trailing: true),
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

class _TimeColumn extends StatelessWidget {
  const _TimeColumn({
    required this.day,
    required this.time,
    required this.alignment,
  });

  final String day;
  final String time;
  final CrossAxisAlignment alignment;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: alignment,
      children: [
        Text(
          day,
          style: const TextStyle(
            fontSize: 10,
            fontWeight: FontWeight.w500,
            color: AppColors.textSecondary,
          ),
        ),
        const SizedBox(height: 3),
        Text(
          time,
          style: const TextStyle(
            fontSize: 15,
            fontWeight: FontWeight.w700,
            color: AppColors.textPrimary,
          ),
        ),
      ],
    );
  }
}

class _Info extends StatelessWidget {
  const _Info({
    required this.label,
    required this.value,
    this.centered = false,
    this.trailing = false,
  });

  final String label;
  final String value;
  final bool centered;
  final bool trailing;

  @override
  Widget build(BuildContext context) {
    final alignment = trailing
        ? CrossAxisAlignment.end
        : centered
        ? CrossAxisAlignment.center
        : CrossAxisAlignment.start;

    return Column(
      crossAxisAlignment: alignment,
      children: [
        Text(
          label,
          style: TextStyle(
            fontSize: 9.5,
            fontWeight: FontWeight.w500,
            color: Colors.white.withValues(alpha: 0.75),
          ),
        ),
        const SizedBox(height: 2),
        Text(
          value,
          style: const TextStyle(
            fontSize: 13,
            fontWeight: FontWeight.w700,
            color: Colors.white,
          ),
        ),
      ],
    );
  }
}
