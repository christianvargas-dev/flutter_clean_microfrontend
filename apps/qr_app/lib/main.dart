import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:qr_app/core/di/injection.dart';
import 'package:qr_app/core/navigation/app_router.dart';
import 'package:qr_app/domain/use_cases/auth_use_case.dart';
import 'package:qr_app/domain/use_cases/get_scan_history_use_case.dart';
import 'package:qr_app/domain/use_cases/save_scan_use_case.dart';
import 'package:qr_app/domain/use_cases/scan_qr_use_case.dart';
import 'package:qr_app/presentation/ui/auth/cubit/auth_cubit.dart';
import 'package:qr_app/presentation/ui/history/cubit/scan_history_cubit.dart';
import 'package:qr_app/presentation/ui/pin_auth/cubit/pin_auth_cubit.dart';
import 'presentation/ui/scan_qr/cubit/scan_qr_cubit.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await configureDependencies();

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) => ScanQrCubit(
            scanQrUseCase: getIt<ScanQrUseCase>(),
          ),
        ),
        BlocProvider(
          create: (context) => AuthCubit(
            authUseCase: getIt<AuthUseCase>(),
          ),
        ),
        BlocProvider(
          create: (context) => ScanHistoryCubit(
              getScanHistoryUseCase: getIt<GetScanHistoryUseCase>(),
              saveScanUseCase: getIt<SaveScanUseCase>()),
        ),
        BlocProvider(
          create: (context) => PinAuthCubit(
              ),
        ),
      ],
      child: MaterialApp.router(
        title: 'QR App',
        routerConfig: appRouter,
      ),
    );
  }
}
