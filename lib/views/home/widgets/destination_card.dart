import 'package:flutter/material.dart';

class DestinationCard extends StatelessWidget {
  const DestinationCard({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold();
  }

  Widget cardBuilder({
    required String location,
    required String name,
    required String imageSource,
  }) {
    return Container(
      decoration: BoxDecoration(
        image: DecorationImage(image: AssetImage(assetName)),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Row(
            children: [
              Icon(Icons.location_on_outlined, size: 40),
              Text(location),
            ],
          ),
          Text(name),
        ],
      ),
    );
  }
}
