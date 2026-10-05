import 'package:flutter/material.dart';

class TitleRibbon extends StatelessWidget {
  final String title;
  final String? subtitle;

  const TitleRibbon({
    super.key,
    this.title = 'Brgy.Casile City, City of cabuyao',
    this.subtitle = 'Enterprise & Business Profiling Research Portal',
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      decoration: BoxDecoration(
        gradient: const LinearGradient(
          colors: [
            Color(0xFF0D472B), // Deep Emerald
            Color(0xFF1B6A41), // Rich Casile Green
            Color(0xFF0F3D24), // Dark Green
          ],
          begin: Alignment.centerLeft,
          end: Alignment.centerRight,
        ),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.25),
            offset: const Offset(0, 4),
            blurRadius: 10,
          ),
        ],
      ),
      child: Column(
        children: [
          // Top Gold Accent Line
          Container(
            height: 3,
            decoration: const BoxDecoration(
              gradient: LinearGradient(
                colors: [
                  Color(0xFFB8860B),
                  Color(0xFFFFDF73),
                  Color(0xFFD4AF37),
                  Color(0xFFFFDF73),
                  Color(0xFFB8860B),
                ],
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 12.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                // Ribbon left star / emblem
                const Icon(
                  Icons.stars_rounded,
                  color: Color(0xFFFFD700),
                  size: 26,
                ),
                const SizedBox(width: 12),
                Flexible(
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Text(
                        title.toUpperCase(),
                        textAlign: TextAlign.center,
                        style: const TextStyle(
                          color: Colors.white,
                          fontSize: 22,
                          fontWeight: FontWeight.w900,
                          letterSpacing: 2.0,
                          shadows: [
                            Shadow(
                              color: Colors.black54,
                              offset: Offset(1, 2),
                              blurRadius: 4,
                            ),
                          ],
                        ),
                      ),
                      if (subtitle != null) ...[
                        const SizedBox(height: 3),
                        Text(
                          subtitle!,
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            color: const Color(0xFFFFDF73).withOpacity(0.95),
                            fontSize: 13,
                            fontWeight: FontWeight.w600,
                            letterSpacing: 1.2,
                          ),
                        ),
                      ],
                    ],
                  ),
                ),
                const SizedBox(width: 12),
                // Ribbon right star / emblem
                const Icon(
                  Icons.stars_rounded,
                  color: Color(0xFFFFD700),
                  size: 26,
                ),
              ],
            ),
          ),
          // Bottom Gold Accent Line
          Container(
            height: 3,
            decoration: const BoxDecoration(
              gradient: LinearGradient(
                colors: [
                  Color(0xFFB8860B),
                  Color(0xFFFFDF73),
                  Color(0xFFD4AF37),
                  Color(0xFFFFDF73),
                  Color(0xFFB8860B),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
