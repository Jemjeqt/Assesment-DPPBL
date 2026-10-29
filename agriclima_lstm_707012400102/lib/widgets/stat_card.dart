import 'package:flutter/material.dart';

class StatCard extends StatelessWidget {
  final String label;
  final String nilai;
  final IconData? ikon;
  final Color? warnaIkon;

  const StatCard({
    super.key,
    required this.label,
    required this.nilai,
    this.ikon,
    this.warnaIkon,
  });

  @override
  Widget build(BuildContext context) {
    final warna = Theme.of(context).colorScheme;

    return Card(
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 12),
        child: Column(
          children: [
            if (ikon != null) ...[
              Icon(ikon, size: 28, color: warnaIkon ?? warna.primary),
              const SizedBox(height: 8),
            ],
            Text(
              nilai,
              style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                fontWeight: FontWeight.bold,
                color: warna.onSurface,
              ),
            ),
            const SizedBox(height: 4),
            Text(
              label,
              style: Theme.of(context).textTheme.bodySmall
                  ?.copyWith(color: warna.onSurfaceVariant),
            ),
          ],
        ),
      ),
    );
  }
}
