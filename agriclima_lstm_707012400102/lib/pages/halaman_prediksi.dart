
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../state/prediksi_cubit.dart';
import '../widgets/stat_card.dart';
import '../widgets/prediksi_card.dart';

class HalamanPrediksi extends StatelessWidget {
  const HalamanPrediksi({super.key});

  static const _filterOptions = ['Semua', 'Petak 1', 'Petak 2'];

  @override
  Widget build(BuildContext context) {
    final teks = Theme.of(context).textTheme;
    final warna = Theme.of(context).colorScheme;

    return BlocBuilder<PrediksiCubit, PrediksiState>(
      builder: (context, state) {
        final filtered = state.dataFiltered;

        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.fromLTRB(16, 16, 16, 8),
              child: Text(
                'Riwayat Prediksi',
                style: teks.titleLarge?.copyWith(
                  fontWeight: FontWeight.bold,
                  color: warna.onSurface,
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: SegmentedButton<String>(
                segments: _filterOptions
                    .map((f) => ButtonSegment(value: f, label: Text(f)))
                    .toList(),
                selected: {state.filterPetak},
                onSelectionChanged: (selected) {
                  context.read<PrediksiCubit>().ubahFilter(selected.first);
                },
              ),
            ),
            const SizedBox(height: 12),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: Row(
                children: [
                  Expanded(
                    child: StatCard(
                      label: 'Total',
                      nilai: '${state.totalFiltered}',
                    ),
                  ),
                  const SizedBox(width: 8),
                  Expanded(
                    child: StatCard(
                      label: 'Optimal',
                      nilai: '${state.optimalFiltered}',
                    ),
                  ),
                  const SizedBox(width: 8),
                  Expanded(
                    child: StatCard(
                      label: 'Perlu Tindakan',
                      nilai: '${state.perluTindakanFiltered}',
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 12),
            Expanded(
              child: filtered.isEmpty
                  ? Center(
                      child: Text(
                        'Belum ada data',
                        style: teks.bodyLarge?.copyWith(
                          color: warna.onSurfaceVariant,
                        ),
                      ),
                    )
                  : ListView.builder(
                      padding: const EdgeInsets.symmetric(horizontal: 16),
                      itemCount: filtered.length,
                      itemBuilder: (context, i) {
                        final d = filtered[i];
                        return PrediksiCard(
                          data: d,
                          onHapus: () =>
                              context.read<PrediksiCubit>().hapus(d.id),
                        );
                      },
                    ),
            ),
          ],
        );
      },
    );
  }
}
