class Destination {
  const Destination({
    required this.imageUrl,
    required this.location,
    required this.title,
  });

  final String imageUrl;
  final String location;
  final String title;
}

class FlightTicket {
  const FlightTicket({
    required this.airline,
    required this.originCode,
    required this.originCity,
    required this.destinationCode,
    required this.destinationCity,
    required this.departureTime,
    required this.arrivalTime,
    required this.departureDay,
    required this.arrivalDay,
    required this.seats,
    required this.terminal,
    required this.gate,
  });

  final String airline;
  final String originCode;
  final String originCity;
  final String destinationCode;
  final String destinationCity;
  final String departureTime;
  final String arrivalTime;
  final String departureDay;
  final String arrivalDay;
  final String seats;
  final String terminal;
  final String gate;
}

const List<Destination> popularDestinations = [
  Destination(
    imageUrl:
        'https://images.unsplash.com/photo-1506905925346-21bda4d32df4?w=800&q=80',
    location: 'Laut Aegea',
    title: 'Lake Pukaki',
  ),
  Destination(
    imageUrl:
        'https://images.unsplash.com/photo-1469854523086-cc02fe5d8800?w=800&q=80',
    location: 'Gunung Gede',
    title: 'Auckland',
  ),
  Destination(
    imageUrl:
        'https://images.unsplash.com/photo-1507525428034-b723cf961d3e?w=800&q=80',
    location: 'Bali',
    title: 'Nusa Penida',
  ),
  Destination(
    imageUrl:
        'https://images.unsplash.com/photo-1464822759023-fed622ff2c3b?w=800&q=80',
    location: 'Lombok',
    title: 'Mount Rinjani',
  ),
];

const List<FlightTicket> availableTickets = [
  FlightTicket(
    airline: 'CitiLink Airline',
    originCode: 'USA',
    originCity: 'Chicago',
    destinationCode: 'IDN',
    destinationCity: 'Jakarta',
    departureTime: '4:30 PM',
    arrivalTime: '5:19 AM',
    departureDay: 'Sun, 5 Feb',
    arrivalDay: 'Mon, 5 Feb',
    seats: '18B, 18C',
    terminal: 'G32',
    gate: '9',
  ),
  FlightTicket(
    airline: 'CitiLink Airline',
    originCode: 'USA',
    originCity: 'Chicago',
    destinationCode: 'IDN',
    destinationCity: 'Jakarta',
    departureTime: '7:45 PM',
    arrivalTime: '8:34 AM',
    departureDay: 'Sun, 5 Feb',
    arrivalDay: 'Mon, 5 Feb',
    seats: '21A, 21B',
    terminal: 'G12',
    gate: '4',
  ),
  FlightTicket(
    airline: 'CitiLink Airline',
    originCode: 'USA',
    originCity: 'Chicago',
    destinationCode: 'IDN',
    destinationCity: 'Jakarta',
    departureTime: '11:10 PM',
    arrivalTime: '11:59 AM',
    departureDay: 'Sun, 5 Feb',
    arrivalDay: 'Mon, 5 Feb',
    seats: '7C, 7D',
    terminal: 'G28',
    gate: '12',
  ),
];
