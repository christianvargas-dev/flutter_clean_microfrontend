import 'package:go_router/go_router.dart';
import 'package:qr_app/presentation/ui/auth/view/auth_screen.dart';
import 'package:qr_app/presentation/ui/history/view/scan_history_screen.dart';
import 'package:qr_app/presentation/ui/pin_auth/view/pin_auth_screen.dart';
import 'package:qr_app/presentation/ui/scan_qr/view/can_qr_screen.dart';


final appRouter = GoRouter(
  routes: [
    GoRoute(
      path: '/',
      builder: (context, state) => const AuthScreen(), 
    ),
    GoRoute(
      path: '/scan',
      builder: (context, state) => const ScanQrScreen(), 
    ),
    GoRoute(
      path: '/history',
      builder: (context, state) => const ScanHistoryScreen(), 
    ),
    GoRoute(
      path: '/pin',
      builder: (context, state) => const PinAuthScreen(),
    ),
  ],
);
