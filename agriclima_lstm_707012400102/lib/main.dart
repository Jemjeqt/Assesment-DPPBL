import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'state/app_routes.dart';
import 'state/prediksi_cubit.dart';
import 'state/theme_cubit.dart';

void main() {
  runApp(const AplikasiAgriClima());
}

class AplikasiAgriClima extends StatelessWidget {
  const AplikasiAgriClima({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (_) => PrediksiCubit()),
        BlocProvider(create: (_) => ThemeCubit()),
      ],
      child: BlocBuilder<ThemeCubit, ThemeMode>(
        builder: (context, themeMode) {
          return MaterialApp(
            debugShowCheckedModeBanner: false,
            title: 'AgriClima',
            theme: ThemeData(
              colorScheme: ColorScheme.fromSeed(
                seedColor: const Color(0xFFFFFFFF),
              ),
              useMaterial3: true,
            ),
            darkTheme: ThemeData(
              colorScheme: ColorScheme.fromSeed(
                seedColor: const Color(0xFFFFFFFF),
                brightness: Brightness.dark,
              ),
              useMaterial3: true,
            ),
            themeMode: themeMode,
            initialRoute: AppRoutes.beranda,
            routes: AppRoutes.daftarRoute(),
            onGenerateRoute: AppRoutes.bentukRoute,
            onUnknownRoute: AppRoutes.routeTidakDikenal,
          );
        },
      ),
    );
  }
}
