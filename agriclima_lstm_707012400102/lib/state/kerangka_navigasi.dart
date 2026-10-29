// lib/state/kerangka_navigasi.dart

import 'package:flutter/material.dart';

import '../pages/halaman_beranda.dart';
import '../pages/halaman_prediksi.dart';
import '../pages/halaman_pengaturan.dart';
import 'app_routes.dart';

const _tabLabels = ['Beranda', 'Prediksi', 'Statistik', 'Pengaturan'];

class KerangkaNavigasi extends StatefulWidget {
  const KerangkaNavigasi({super.key});

  @override
  State<KerangkaNavigasi> createState() => _KerangkaNavigasiState();
}

class _KerangkaNavigasiState extends State<KerangkaNavigasi> {
  int _indeks = 0;

  void _pilih(int i) => setState(() => _indeks = i);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('AgriClima — ${_tabLabels[_indeks]}')),
      body: IndexedStack(
        index: _indeks,
        children: const [
          HalamanBeranda(),
          HalamanPrediksi(),
          SizedBox.shrink(),
          HalamanPengaturan(),
        ],
      ),
      floatingActionButton: _indeks == 1
          ? FloatingActionButton.extended(
              onPressed: () =>
                  Navigator.pushNamed(context, AppRoutes.inputPrediksi),
              icon: const Icon(Icons.add),
              label: const Text('Prediksi Baru'),
            )
          : null,
      bottomNavigationBar: NavigationBar(
        selectedIndex: _indeks,
        onDestinationSelected: _pilih,
        destinations: const [
          NavigationDestination(
            icon: Icon(Icons.home_outlined),
            selectedIcon: Icon(Icons.home),
            label: 'Beranda',
          ),
          NavigationDestination(
            icon: Icon(Icons.eco_outlined),
            selectedIcon: Icon(Icons.eco),
            label: 'Prediksi',
          ),
          NavigationDestination(
            icon: Icon(Icons.bar_chart_outlined),
            selectedIcon: Icon(Icons.bar_chart),
            label: 'Statistik',
          ),
          NavigationDestination(
            icon: Icon(Icons.settings_outlined),
            selectedIcon: Icon(Icons.settings),
            label: 'Pengaturan',
          ),
        ],
      ),
    );
  }
}
