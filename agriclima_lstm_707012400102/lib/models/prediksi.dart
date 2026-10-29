import 'package:equatable/equatable.dart';

const Map<String, String> catatanPerawatan = {
  'Padi': 'Jaga genangan air 2-5 cm pada fase vegetatif dan keringkan lahan menjelang panen.',
  'Jagung': 'Siram saat tanah mulai kering dan hindari genangan di sekitar perakaran.',
  'Cabai': 'Gunakan mulsa untuk menjaga kelembapan tanah dan siram pada pagi atau sore hari.',
};

const List<String> daftarTanaman = ['Padi', 'Jagung', 'Cabai'];
const List<String> daftarPetak = ['Petak 1', 'Petak 2'];

enum StatusMikroklimat { kering, optimal, terlaluLembap }

StatusMikroklimat tentukanStatus(double kelembapanTanah) {
  if (kelembapanTanah < 40) return StatusMikroklimat.kering;
  if (kelembapanTanah <= 70) return StatusMikroklimat.optimal;
  return StatusMikroklimat.terlaluLembap;
}

String labelStatus(StatusMikroklimat s) {
  switch (s) {
    case StatusMikroklimat.kering:
      return 'Kering';
    case StatusMikroklimat.optimal:
      return 'Optimal';
    case StatusMikroklimat.terlaluLembap:
      return 'Terlalu Lembap';
  }
}

String rekomendasiStatus(StatusMikroklimat s) {
  switch (s) {
    case StatusMikroklimat.kering:
      return 'Segera lakukan penyiraman atau irigasi';
    case StatusMikroklimat.optimal:
      return 'Pertahankan pola perawatan saat ini';
    case StatusMikroklimat.terlaluLembap:
      return 'Kurangi penyiraman dan periksa drainase';
  }
}

class HasilPrediksi extends Equatable {
  final int id;
  final String petak;
  final String tanaman;
  final double suhuUdara;
  final double kelembapanUdara;
  final double kelembapanTanah;
  final String namaPetugas;
  final DateTime waktu;

  const HasilPrediksi({
    required this.id,
    required this.petak,
    required this.tanaman,
    required this.suhuUdara,
    required this.kelembapanUdara,
    required this.kelembapanTanah,
    required this.namaPetugas,
    required this.waktu,
  });

  StatusMikroklimat get status => tentukanStatus(kelembapanTanah);
  String get labelStatusText => labelStatus(status);
  String get rekomendasi => rekomendasiStatus(status);
  String get catatan => catatanPerawatan[tanaman] ?? '';

  String get waktuFormatted {
    String dua(int n) => n.toString().padLeft(2, '0');
    return '${dua(waktu.day)}/${dua(waktu.month)}/${waktu.year} '
        '${dua(waktu.hour)}:${dua(waktu.minute)}';
  }

  @override
  List<Object?> get props => [
    id,
    petak,
    tanaman,
    suhuUdara,
    kelembapanUdara,
    kelembapanTanah,
    namaPetugas,
    waktu,
  ];
}
