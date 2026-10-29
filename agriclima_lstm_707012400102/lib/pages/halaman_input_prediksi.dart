import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../models/prediksi.dart';
import '../state/prediksi_cubit.dart';

class HalamanInputPrediksi extends StatefulWidget {
  const HalamanInputPrediksi({super.key});

  @override
  State<HalamanInputPrediksi> createState() => _HalamanInputPrediksiState();
}

class _HalamanInputPrediksiState extends State<HalamanInputPrediksi> {
  final _formKey = GlobalKey<FormState>();

  String _petak = daftarPetak.first;
  String _tanaman = daftarTanaman.first;
  bool _sudahBenar = false;

  final _suhuC = TextEditingController();
  final _kelembabanUdaraC = TextEditingController();
  final _kelembabanTanahC = TextEditingController();
  final _petugasC = TextEditingController();

  String? _suhuError;
  String? _kuError;
  String? _ktError;
  String? _petugasError;

  @override
  void dispose() {
    _suhuC.dispose();
    _kelembabanUdaraC.dispose();
    _kelembabanTanahC.dispose();
    _petugasC.dispose();
    super.dispose();
  }

  bool _validasi() {
    bool valid = true;

    final suhu = double.tryParse(_suhuC.text.trim());
    if (suhu == null) {
      _suhuError = 'Harus berupa angka';
      valid = false;
    } else {
      _suhuError = null;
    }

    final ku = double.tryParse(_kelembabanUdaraC.text.trim());
    if (ku == null) {
      _kuError = 'Harus berupa angka';
      valid = false;
    } else if (ku < 0 || ku > 100) {
      _kuError = 'Harus antara 0-100';
      valid = false;
    } else {
      _kuError = null;
    }

    final kt = double.tryParse(_kelembabanTanahC.text.trim());
    if (kt == null) {
      _ktError = 'Harus berupa angka';
      valid = false;
    } else if (kt < 0 || kt > 100) {
      _ktError = 'Harus antara 0-100';
      valid = false;
    } else {
      _ktError = null;
    }

    if (_petugasC.text.trim().isEmpty) {
      _petugasError = 'Tidak boleh kosong';
      valid = false;
    } else {
      _petugasError = null;
    }

    setState(() {});
    return valid;
  }

  void _simpan() {
    if (!_validasi()) return;

    final suhu = double.parse(_suhuC.text.trim());
    final ku = double.parse(_kelembabanUdaraC.text.trim());
    final kt = double.parse(_kelembabanTanahC.text.trim());
    final status = labelStatus(tentukanStatus(kt));

    final messenger = ScaffoldMessenger.of(context);
    final cubit = context.read<PrediksiCubit>();

    showDialog<bool>(
      context: context,
      builder: (ctx) => AlertDialog(
        title: const Text('Konfirmasi'),
        content: Text('Simpan prediksi $_tanaman di $_petak?\n$status'),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(ctx, false),
            child: const Text('Batal'),
          ),
          FilledButton(
            onPressed: () => Navigator.pop(ctx, true),
            child: const Text('Ya, Simpan'),
          ),
        ],
      ),
    ).then((confirmed) {
      if (confirmed != true) return;

      cubit.tambah(
        HasilPrediksi(
          id: cubit.idBaru(),
          petak: _petak,
          tanaman: _tanaman,
          suhuUdara: suhu,
          kelembapanUdara: ku,
          kelembapanTanah: kt,
          namaPetugas: _petugasC.text.trim(),
          waktu: DateTime.now(),
        ),
      );

      messenger.showSnackBar(const SnackBar(content: Text('Data tersimpan')));

      if (mounted) Navigator.pop(context);
    });
  }

  @override
  Widget build(BuildContext context) {
    final warna = Theme.of(context).colorScheme;

    return Scaffold(
      appBar: AppBar(title: const Text('Input Prediksi')),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text('Petak', style: TextStyle(color: warna.onSurface)),
              RadioGroup<String>(
                groupValue: _petak,
                onChanged: (v) =>
                    setState(() => _petak = v ?? daftarPetak.first),
                child: Column(
                  children: daftarPetak
                      .map(
                        (p) => RadioListTile<String>(title: Text(p), value: p),
                      )
                      .toList(),
                ),
              ),
              const SizedBox(height: 8),
              DropdownButtonFormField<String>(
                initialValue: _tanaman,
                decoration: const InputDecoration(
                  labelText: 'Nama Tanaman',
                  border: OutlineInputBorder(),
                ),
                items: daftarTanaman
                    .map((t) => DropdownMenuItem(value: t, child: Text(t)))
                    .toList(),
                onChanged: (v) => setState(() => _tanaman = v!),
              ),
              const SizedBox(height: 12),
              TextField(
                controller: _suhuC,
                keyboardType: const TextInputType.numberWithOptions(
                  decimal: true,
                ),
                decoration: InputDecoration(
                  labelText: 'Prediksi Suhu Udara (°C)',
                  border: const OutlineInputBorder(),
                  errorText: _suhuError,
                ),
              ),
              const SizedBox(height: 12),
              TextField(
                controller: _kelembabanUdaraC,
                keyboardType: const TextInputType.numberWithOptions(
                  decimal: true,
                ),
                decoration: InputDecoration(
                  labelText: 'Prediksi Kelembapan Udara (%)',
                  border: const OutlineInputBorder(),
                  errorText: _kuError,
                ),
              ),
              const SizedBox(height: 12),
              TextField(
                controller: _kelembabanTanahC,
                keyboardType: const TextInputType.numberWithOptions(
                  decimal: true,
                ),
                decoration: InputDecoration(
                  labelText: 'Prediksi Kelembapan Tanah (%)',
                  border: const OutlineInputBorder(),
                  errorText: _ktError,
                ),
              ),
              const SizedBox(height: 12),
              TextField(
                controller: _petugasC,
                decoration: InputDecoration(
                  labelText: 'Nama Petugas',
                  border: const OutlineInputBorder(),
                  errorText: _petugasError,
                ),
              ),
              const SizedBox(height: 8),
              CheckboxListTile(
                title: const Text('Data sudah benar'),
                value: _sudahBenar,
                onChanged: (v) => setState(() => _sudahBenar = v ?? false),
                controlAffinity: ListTileControlAffinity.trailing,
              ),
              const SizedBox(height: 16),
              SizedBox(
                width: double.infinity,
                child: FilledButton(
                  onPressed: _sudahBenar ? _simpan : null,
                  child: const Text('Simpan'),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
