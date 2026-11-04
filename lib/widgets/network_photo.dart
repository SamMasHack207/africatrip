import 'package:flutter/material.dart';

class NetworkPhoto extends StatelessWidget {
  const NetworkPhoto({super.key, required this.url});

  final String url;

  @override
  Widget build(BuildContext context) {
    return Image.network(
      url,
      fit: BoxFit.cover,
      width: double.infinity,
      height: double.infinity,
      errorBuilder: (context, error, stackTrace) => const _PhotoFallback(),
      loadingBuilder: (context, child, progress) {
        if (progress == null) return child;
        return const _PhotoFallback();
      },
    );
  }
}

class _PhotoFallback extends StatelessWidget {
  const _PhotoFallback();

  @override
  Widget build(BuildContext context) {
    return const DecoratedBox(
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [Color(0xFF9DBB78), Color(0xFF3E6B3A)],
        ),
      ),
      child: Center(
        child: Icon(Icons.landscape_rounded, color: Colors.white38, size: 42),
      ),
    );
  }
}
