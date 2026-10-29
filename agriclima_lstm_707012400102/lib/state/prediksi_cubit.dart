// lib/state/prediksi_cubit.dart
// Cubit mengelola daftar HasilPrediksi: tambah, hapus, filter petak.

import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../models/prediksi.dart';

class PrediksiState extends Equatable {
  final List<HasilPrediksi> semuaData;
  final String filterPetak;

  const PrediksiState({this.semuaData = const [], this.filterPetak = 'Semua'});

  List<HasilPrediksi> get dataFiltered {
    if (filterPetak == 'Semua') return semuaData;
    return semuaData.where((d) => d.petak == filterPetak).toList();
  }

  int get totalFiltered => dataFiltered.length;

  int get optimalFiltered =>
      dataFiltered.where((d) => d.status == StatusMikroklimat.optimal).length;

  int get perluTindakanFiltered => totalFiltered - optimalFiltered;

  PrediksiState copyWith({
    List<HasilPrediksi>? semuaData,
    String? filterPetak,
  }) {
    return PrediksiState(
      semuaData: semuaData ?? this.semuaData,
      filterPetak: filterPetak ?? this.filterPetak,
    );
  }

  @override
  List<Object?> get props => [semuaData, filterPetak];
}

class PrediksiCubit extends Cubit<PrediksiState> {
  PrediksiCubit() : super(const PrediksiState());

  void tambah(HasilPrediksi data) {
    final daftar = List<HasilPrediksi>.from(state.semuaData)..add(data);
    emit(state.copyWith(semuaData: daftar));
  }

  void hapus(int id) {
    final daftar = List<HasilPrediksi>.from(state.semuaData)
      ..removeWhere((d) => d.id == id);
    emit(state.copyWith(semuaData: daftar));
  }

  void ubahFilter(String petak) {
    emit(state.copyWith(filterPetak: petak));
  }

  int idBaru() {
    if (state.semuaData.isEmpty) return 1;
    int max = 0;
    for (final d in state.semuaData) {
      if (d.id > max) max = d.id;
    }
    return max + 1;
  }
}
