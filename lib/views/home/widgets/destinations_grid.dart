import 'package:flutter/material.dart';

class DestinationsGrid extends StatelessWidget {
  const DestinationsGrid({super.key});

  @override
  Widget build(BuildContext context) {
    final List<Map<String, String>> destinationList = const [
      {
        "location": "Laut Aeegae",
        "name": "Lake PauKai",
        "imagesource": "assets/images/image4.jpg",
      },
      {
        "location": "Gunung",
        "name": "Auckland",
        "imagesource": "assets/images/image3.jpg",
      },
      {
        "location": "Adidogomé",
        "name": "Lomé",
        "imagesource": "assets/images/image2.jpg",
      },
      {
        "location": "Lapampa",
        "name": "Lomé",
        "imagesource": "assets/images/image1.jpg",
      },
    ];
    return GridView.builder(
      itemCount: destinationList.length,
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        mainAxisSpacing: 16,
        crossAxisSpacing: 16,
        childAspectRatio: 0.72,
      ),
      physics: NeverScrollableScrollPhysics(),
      shrinkWrap: true,
      itemBuilder: (context, index) {
        final item = destinationList[index];
        return cardBuilder(
          location: item["location"] ?? "",
          name: item["name"] ?? "",
          imageSource: item["imagesource"] ?? "",
        );
      },
    );
  }

  Widget cardBuilder({
    required String location,
    required String name,
    required String imageSource,
  }) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(24),
      child: Stack(
        fit: StackFit.expand,
        children: [
          Image.asset(imageSource, fit: BoxFit.cover),
          DecoratedBox(
            decoration: BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                colors: [
                  Colors.black.withValues(alpha: 0.15),
                  Colors.transparent,
                  Colors.black.withValues(alpha: 0.75),
                ],
                stops: const [0.0, 0.45, 1.0],
              ),
            ),
          ),
          Positioned(
            top: 12,
            right: 12,
            child: Container(
              padding: const EdgeInsets.all(8),
              decoration: BoxDecoration(
                color: Colors.white.withValues(alpha: 0.2),
                shape: BoxShape.circle,
                border: Border.all(color: Colors.white.withValues(alpha: 0.3)),
              ),
              child: const Icon(
                Icons.arrow_outward,
                color: Colors.white,
                size: 18,
              ),
            ),
          ),
          Positioned(
            left: 16,
            right: 16,
            bottom: 16,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: [
                Row(
                  children: [
                    const Icon(
                      Icons.location_on_outlined,
                      color: Colors.white70,
                      size: 14,
                    ),
                    const SizedBox(width: 4),
                    Text(
                      location,
                      style: const TextStyle(
                        color: Colors.white70,
                        fontSize: 12,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 2),
                Text(
                  name,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 20,
                    fontWeight: FontWeight.w700,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
