import 'package:flutter/material.dart';

class HalamanTentang extends StatelessWidget {
  const HalamanTentang({super.key});

  @override
  Widget build(BuildContext context) {
    final teks = Theme.of(context).textTheme;
    final warna = Theme.of(context).colorScheme;

    return Scaffold(
      appBar: AppBar(title: const Text('Tentang')),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          Text(
            'Tujuan Aplikasi',
            style: teks.titleMedium?.copyWith(
              fontWeight: FontWeight.bold,
              color: warna.onSurface,
            ),
          ),
          const SizedBox(height: 8),
          Text(
            'Mencatat dan memantau prediksi mikroklimat tanaman berbasis model LSTM untuk membantu petani dalam menentukan rekomendasi perawatan tanaman.',
            style: teks.bodyMedium?.copyWith(color: warna.onSurfaceVariant),
          ),
          const Divider(height: 32),
          Text(
            'Lokasi Pemantauan',
            style: teks.titleMedium?.copyWith(
              fontWeight: FontWeight.bold,
              color: warna.onSurface,
            ),
          ),
          const SizedBox(height: 8),
          ListTile(
            dense: true,
            contentPadding: EdgeInsets.zero,
            leading: Icon(Icons.location_on_outlined, color: warna.onSurface),
            title: const Text('Petak 1'),
          ),
          ListTile(
            dense: true,
            contentPadding: EdgeInsets.zero,
            leading: Icon(Icons.location_on_outlined, color: warna.onSurface),
            title: const Text('Petak 2'),
          ),
          const Divider(height: 32),
          Text(
            'Daftar Parameter',
            style: teks.titleMedium?.copyWith(
              fontWeight: FontWeight.bold,
              color: warna.onSurface,
            ),
          ),
          const SizedBox(height: 8),
          ListTile(
            dense: true,
            contentPadding: EdgeInsets.zero,
            leading: Icon(Icons.thermostat_outlined, color: warna.onSurface),
            title: const Text('Suhu Udara'),
            trailing: const Text('°C'),
          ),
          ListTile(
            dense: true,
            contentPadding: EdgeInsets.zero,
            leading: Icon(Icons.air_outlined, color: warna.onSurface),
            title: const Text('Kelembapan Udara'),
            trailing: const Text('%'),
          ),
          ListTile(
            dense: true,
            contentPadding: EdgeInsets.zero,
            leading: Icon(Icons.water_drop_outlined, color: warna.onSurface),
            title: const Text('Kelembapan Tanah'),
            trailing: const Text('%'),
          ),
        ],
      ),
    );
  }
}
