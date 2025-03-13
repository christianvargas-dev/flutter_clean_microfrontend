import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:qr_app/presentation/ui/auth/cubit/auth_cubit.dart';
import 'package:qr_app/presentation/ui/auth/cubit/auth_state.dart';

class AuthScreen extends StatelessWidget {
  const AuthScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.blueAccent.shade100,
      appBar: AppBar(
        title: const Text(
          "Autenticación Biométrica",
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        backgroundColor: Colors.blueAccent,
      ),
      body: Center(
        child: BlocConsumer<AuthCubit, AuthState>(
          listener: (context, state) {
            if (state is AuthError) {
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(content: Text(" ${state.message}")),
              );
              Future.microtask(() => context.go('/pin'));
            } else if (state is AuthSuccess && state.isAuthenticated) {
              Future.microtask(() => context.go('/scan'));
            }
          },
          builder: (context, state) {
            return Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                  padding: const EdgeInsets.all(20),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(15),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withOpacity(0.1),
                        blurRadius: 10,
                        spreadRadius: 2,
                      ),
                    ],
                  ),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      if (state is AuthLoading) ...[
                        const CircularProgressIndicator(),
                        const SizedBox(height: 20),
                        const Text(
                          "Verificando autenticación...",
                          style: TextStyle(
                              fontSize: 16, fontWeight: FontWeight.bold),
                        ),
                      ] else if (state is AuthSuccess) ...[
                        Icon(
                          state.isAuthenticated
                              ? Icons.verified_rounded
                              : Icons.error_outline,
                          size: 100,
                          color:
                              state.isAuthenticated ? Colors.green : Colors.red,
                        ),
                        const SizedBox(height: 20),
                        Text(
                          state.isAuthenticated
                              ? "Autenticación Exitosa"
                              : "Autenticación Fallida",
                          style: TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                              color: state.isAuthenticated
                                  ? Colors.green
                                  : Colors.red),
                        ),
                        const SizedBox(height: 20),
                      ],
                      ElevatedButton.icon(
                        onPressed: () =>
                            context.read<AuthCubit>().authenticate(),
                        icon: const Icon(Icons.fingerprint, size: 24),
                        label: const Text("Autenticarse"),
                        style: ElevatedButton.styleFrom(
                          foregroundColor: Colors.white,
                          backgroundColor: Colors.blueAccent,
                          padding: const EdgeInsets.symmetric(
                              horizontal: 30, vertical: 15),
                          textStyle: const TextStyle(fontSize: 18),
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10)),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            );
          },
        ),
      ),
    );
  }
}
