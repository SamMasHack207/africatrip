import 'package:flutter/material.dart';

import '../../models/travel_models.dart';
import '../../theme/app_theme.dart';
import '../../widgets/circle_icon_button.dart';
import '../../widgets/flight_route_row.dart';
import '../../widgets/qr_code_view.dart';

class BoardingPassScreen extends StatelessWidget {
  const BoardingPassScreen({super.key, required this.ticket});

  final FlightTicket ticket;

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
                    icon: Icons.close_rounded,
                    onTap: () => Navigator.of(context).pop(),
                  ),
                  const Expanded(
                    child: Text(
                      'Boarding Pass',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.w700,
                        color: AppColors.textPrimary,
                      ),
                    ),
                  ),
                  CircleIconButton(
                    icon: Icons.download_rounded,
                    iconSize: 21,
                    onTap: () {},
                  ),
                ],
              ),
            ),
            Expanded(
              child: SingleChildScrollView(
                padding: const EdgeInsets.fromLTRB(20, 22, 20, 24),
                child: Column(
                  children: [
                    _BoardingPassTicket(ticket: ticket),
                    const SizedBox(height: 22),
                    Material(
                      color: AppColors.dark,
                      borderRadius: BorderRadius.circular(30),
                      clipBehavior: Clip.antiAlias,
                      child: InkWell(
                        onTap: () {},
                        child: const SizedBox(
                          height: 56,
                          width: double.infinity,
                          child: Center(
                            child: Text(
                              'Save and Download',
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

class _BoardingPassTicket extends StatelessWidget {
  const _BoardingPassTicket({required this.ticket});

  final FlightTicket ticket;

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(30),
      child: Container(
        color: AppColors.cream,
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.fromLTRB(20, 20, 20, 18),
              child: Column(
                children: [
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text(
                        'Citilink',
                        style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.w800,
                          fontStyle: FontStyle.italic,
                          color: AppColors.green,
                          letterSpacing: -0.5,
                        ),
                      ),
                      const Spacer(),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.end,
                        children: [
                          const Text(
                            'ID',
                            style: TextStyle(
                              fontSize: 8.5,
                              fontWeight: FontWeight.w500,
                              color: AppColors.textSecondary,
                            ),
                          ),
                          const SizedBox(height: 1),
                          Text(
                            '13SAKF3891',
                            style: TextStyle(
                              fontSize: 11,
                              fontWeight: FontWeight.w600,
                              color: AppColors.textPrimary.withValues(alpha: 0.8),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                  const SizedBox(height: 22),
                  FlightRouteRow(
                    originCode: ticket.originCode,
                    originCity: ticket.originCity,
                    destinationCode: ticket.destinationCode,
                    destinationCity: ticket.destinationCity,
                    codeColor: AppColors.dark,
                    cityColor: AppColors.textSecondary,
                    planeBackground: AppColors.green,
                  ),
                  const SizedBox(height: 20),
                  const _InfoGrid(
                    items: [
                      _InfoItem('Boarding time', '4:30 PM'),
                      _InfoItem('Departure', '09:00 AM'),
                      _InfoItem('Arrival Time', '05:19 AM'),
                    ],
                  ),
                  const SizedBox(height: 18),
                  const _InfoGrid(
                    items: [
                      _InfoItem('Passenger', 'Budiarti Rohman'),
                      _InfoItem('Date', '17 Mar 2025', end: true),
                    ],
                  ),
                ],
              ),
            ),
            const _Perforation(),
            const Padding(
              padding: EdgeInsets.symmetric(vertical: 26),
              child: QrCodeView(size: 188),
            ),
            Container(
              color: AppColors.green,
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 14),
              child: Row(
                children: [
                  Expanded(
                    child: _PassInfo(label: 'Seats', value: ticket.seats),
                  ),
                  Expanded(
                    child: _PassInfo(
                      label: 'Terminal',
                      value: ticket.terminal,
                      centered: true,
                    ),
                  ),
                  Expanded(
                    child: _PassInfo(
                      label: 'Gate',
                      value: ticket.gate,
                      trailing: true,
                    ),
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

class _InfoItem {
  const _InfoItem(this.label, this.value, {this.end = false});

  final String label;
  final String value;
  final bool end;
}

class _InfoGrid extends StatelessWidget {
  const _InfoGrid({required this.items});

  final List<_InfoItem> items;

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        for (final item in items)
          Expanded(
            child: Column(
              crossAxisAlignment: item.end
                  ? CrossAxisAlignment.end
                  : CrossAxisAlignment.start,
              children: [
                Text(
                  item.label,
                  style: const TextStyle(
                    fontSize: 9.5,
                    fontWeight: FontWeight.w500,
                    color: AppColors.textSecondary,
                  ),
                ),
                const SizedBox(height: 3),
                Text(
                  item.value,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: const TextStyle(
                    fontSize: 12,
                    fontWeight: FontWeight.w700,
                    color: AppColors.textPrimary,
                  ),
                ),
              ],
            ),
          ),
      ],
    );
  }
}

class _PassInfo extends StatelessWidget {
  const _PassInfo({
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

class _Perforation extends StatelessWidget {
  const _Perforation();

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 24,
      width: double.infinity,
      child: CustomPaint(painter: const _PerforationPainter()),
    );
  }
}

class _PerforationPainter extends CustomPainter {
  const _PerforationPainter();

  @override
  void paint(Canvas canvas, Size size) {
    final dashPaint = Paint()
      ..color = AppColors.dotted
      ..strokeWidth = 1.2
      ..strokeCap = StrokeCap.round;

    const dash = 5.0;
    const gap = 5.0;
    var x = 14.0;
    while (x < size.width - 14) {
      canvas.drawLine(
        Offset(x, size.height / 2),
        Offset((x + dash).clamp(0, size.width - 14), size.height / 2),
        dashPaint,
      );
      x += dash + gap;
    }

    final notchPaint = Paint()..color = AppColors.background;
    final radius = size.height / 2;
    canvas.drawCircle(Offset(0, size.height / 2), radius, notchPaint);
    canvas.drawCircle(Offset(size.width, size.height / 2), radius, notchPaint);
  }

  @override
  bool shouldRepaint(_PerforationPainter oldDelegate) => false;
}
