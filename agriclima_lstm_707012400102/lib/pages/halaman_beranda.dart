import 'package:flutter/material.dart';

import '../state/app_routes.dart';

class HalamanBeranda extends StatelessWidget {
  const HalamanBeranda({super.key});

  @override
  Widget build(BuildContext context) {
    final teks = Theme.of(context).textTheme;
    final warna = Theme.of(context).colorScheme;

    return SingleChildScrollView(
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Selamat Datang di AgriClima LSTM',
            style: teks.headlineSmall?.copyWith(
              fontWeight: FontWeight.bold,
              color: warna.onSurface,
            ),
          ),
          const SizedBox(height: 8),
          Text(
            'Aplikasi untuk mencatat hasil prediksi mikroklimat tanaman di lahan Kelompok Tani Sri Mulya, agar kebutuhan penyiraman tiap petak mudah dipantau',
            style: teks.bodyMedium?.copyWith(color: warna.onSurfaceVariant),
          ),
          const SizedBox(height: 16),
          Card(
            child: Padding(
              padding: const EdgeInsets.all(16),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Icon(Icons.memory, size: 36, color: warna.primary),
                  const SizedBox(width: 16),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        _infoBaris(context, 'Model', 'LTSM (Deep Learning)'),
                        _infoBaris(context, 'Prediksi', '24 jam ke depan'),
                        _infoBaris(
                          context,
                          'Parameter',
                          'Suhu udara, kelembapan udara, kelembapan tanah',
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
          const SizedBox(height: 16),
          SizedBox(
            width: double.infinity,
            child: FilledButton.icon(
              onPressed: () => Navigator.pushNamed(context, AppRoutes.tentang),
              label: const Text('Tentang Aplikasi'),
            ),
          ),
        ],
      ),
    );
  }

  Widget _infoBaris(BuildContext context, String label, String nilai) {
    final warna = Theme.of(context).colorScheme;
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            width: 76,
            child: Text(
              label,
              style: Theme.of(context).textTheme.bodyMedium
                  ?.copyWith(color: warna.onSurfaceVariant),
            ),
          ),
          Expanded(
            child: Text(
              nilai,
              style: Theme.of(context).textTheme.bodyMedium
                  ?.copyWith(color: warna.onSurface),
            ),
          ),
        ],
      ),
    );
  }
}
