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
    return Container(
      decoration: BoxDecoration(
        image: DecorationImage(image: AssetImage(imageSource)),
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
