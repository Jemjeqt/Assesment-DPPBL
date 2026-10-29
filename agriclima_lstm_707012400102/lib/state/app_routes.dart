// lib/state/app_routes.dart
// Konstanta route dan pemetaan route.

import 'package:flutter/material.dart';

import 'kerangka_navigasi.dart';
import '../pages/halaman_tentang.dart';
import '../pages/halaman_input_prediksi.dart';

class AppRoutes {
  static const String beranda = '/';
  static const String tentang = '/tentang';
  static const String inputPrediksi = '/input-prediksi';

  static Map<String, WidgetBuilder> daftarRoute() {
    return {
      beranda: (_) => const KerangkaNavigasi(),
      tentang: (_) => const HalamanTentang(),
      inputPrediksi: (_) => const HalamanInputPrediksi(),
    };
  }

  static Route<dynamic>? bentukRoute(RouteSettings settings) {
    return null;
  }

  static Route<dynamic> routeTidakDikenal(RouteSettings settings) {
    return MaterialPageRoute(
      builder: (_) => Scaffold(
        appBar: AppBar(title: const Text('Tidak Ditemukan')),
        body: Center(child: Text('Route ${settings.name} belum terdaftar.')),
      ),
    );
  }
}
