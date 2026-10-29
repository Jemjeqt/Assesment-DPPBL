import 'package:flutter/material.dart';

import '../models/prediksi.dart';

class PrediksiCard extends StatelessWidget {
  final HasilPrediksi data;
  final VoidCallback? onHapus;

  const PrediksiCard({super.key, required this.data, this.onHapus});

  @override
  Widget build(BuildContext context) {
    final warna = Theme.of(context).colorScheme;
    final teks = Theme.of(context).textTheme;

    final statusWarna = _warnaStatus(data.status, warna);

    return Card(
      margin: const EdgeInsets.only(bottom: 10),
      child: Padding(
        padding: const EdgeInsets.all(14),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Icon(
                  _ikonStatus(data.status),
                  size: 20,
                  color: warna.onSurface,
                ),
                const SizedBox(width: 8),
                Expanded(
                  child: Text(
                    '${data.petak} · ${data.tanaman}',
                    style: teks.titleMedium?.copyWith(
                      fontWeight: FontWeight.bold,
                      color: warna.onSurface,
                    ),
                  ),
                ),
                if (onHapus != null)
                  IconButton(
                    icon: Icon(
                      Icons.delete_outline,
                      color: warna.onSurfaceVariant,
                    ),
                    onPressed: onHapus,
                    tooltip: 'Hapus',
                  ),
              ],
            ),
            const SizedBox(height: 4),
            Text(
              data.labelStatusText,
              style: teks.bodyMedium?.copyWith(
                fontWeight: FontWeight.bold,
                color: warna.onSurface,
              ),
            ),
            const SizedBox(height: 8),
            Text(
              'Kelembapan tanah: ${data.kelembapanTanah.toStringAsFixed(1)}%',
              style: teks.bodyMedium?.copyWith(color: warna.onSurface),
            ),
            const SizedBox(height: 4),
            ClipRRect(
              borderRadius: BorderRadius.circular(4),
              child: LinearProgressIndicator(
                value: (data.kelembapanTanah / 100).clamp(0.0, 1.0),
                backgroundColor: warna.surfaceContainerHighest,
                color: statusWarna,
                minHeight: 8,
              ),
            ),
            const SizedBox(height: 10),
            Text(
              'Suhu udara: ${data.suhuUdara.toStringAsFixed(1)}°C',
              style: teks.bodySmall?.copyWith(color: warna.onSurfaceVariant),
            ),
            const SizedBox(height: 4),
            Text(
              'Kelembapan udara: ${data.kelembapanUdara.toStringAsFixed(1)}%',
              style: teks.bodySmall?.copyWith(color: warna.onSurfaceVariant),
            ),
            const SizedBox(height: 8),
            Text(
              'Rekomendasi: ${data.rekomendasi}',
              style: teks.bodySmall?.copyWith(
                color: warna.onSurfaceVariant,
                fontStyle: FontStyle.italic,
              ),
            ),
            const SizedBox(height: 4),
            Text(
              'Catatan: ${data.catatan}',
              style: teks.bodySmall?.copyWith(color: warna.onSurfaceVariant),
            ),
            const Divider(height: 16),
            Text(
              '${data.namaPetugas} · ${data.waktuFormatted}',
              style: teks.bodySmall?.copyWith(color: warna.outline),
            ),
          ],
        ),
      ),
    );
  }

  Color _warnaStatus(StatusMikroklimat s, ColorScheme warna) {
    switch (s) {
      case StatusMikroklimat.kering:
        return warna.onSurface;
      case StatusMikroklimat.optimal:
        return warna.onSurfaceVariant;
      case StatusMikroklimat.terlaluLembap:
        return warna.outline;
    }
  }

  IconData _ikonStatus(StatusMikroklimat s) {
    switch (s) {
      case StatusMikroklimat.kering:
        return Icons.wb_sunny;
      case StatusMikroklimat.optimal:
        return Icons.check_circle;
      case StatusMikroklimat.terlaluLembap:
        return Icons.water;
    }
  }
}
