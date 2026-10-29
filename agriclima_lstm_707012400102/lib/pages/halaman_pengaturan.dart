import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../state/theme_cubit.dart';

class HalamanPengaturan extends StatelessWidget {
  const HalamanPengaturan({super.key});

  @override
  Widget build(BuildContext context) {
    final warna = Theme.of(context).colorScheme;

    return BlocBuilder<ThemeCubit, ThemeMode>(
      builder: (context, mode) {
        return ListView(
          padding: const EdgeInsets.all(16),
          children: [
            SwitchListTile(
              title: Text(
                'Mode Gelap',
                style: TextStyle(color: warna.onSurface),
              ),
              subtitle: Text(
                mode == ThemeMode.dark ? 'Aktif' : 'Nonaktif',
                style: TextStyle(color: warna.onSurfaceVariant),
              ),
              secondary: Icon(
                mode == ThemeMode.dark ? Icons.dark_mode : Icons.light_mode,
                color: warna.primary,
              ),
              value: mode == ThemeMode.dark,
              onChanged: (_) => context.read<ThemeCubit>().toggle(),
            ),
          ],
        );
      },
    );
  }
}
