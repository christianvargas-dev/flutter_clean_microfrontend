import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:qr_app/presentation/ui/pin_auth/cubit/pin_auth_cubit.dart';
import 'package:qr_app/presentation/ui/pin_auth/cubit/pin_auth_state.dart';

class PinAuthScreen extends StatefulWidget {
  const PinAuthScreen({super.key});

  @override
  _PinAuthScreenState createState() => _PinAuthScreenState();
}

class _PinAuthScreenState extends State<PinAuthScreen> {
  final TextEditingController _pinController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.blueAccent.shade100, 
      appBar: AppBar(
        title: const Text(
          "Autenticación por PIN",
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        backgroundColor: Colors.blueAccent,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () => context.go('/'),
        ),
      ),
      body: Center(
        child: BlocConsumer<PinAuthCubit, PinAuthState>(
          listener: (context, state) {
            if (state is PinAuthSuccess) {
              Future.microtask(() => context.go('/scan'));
            } else if (state is PinAuthError) {
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  content: Text(state.message),
                  backgroundColor: Colors.redAccent,
                ),
              );
            }
          },
          builder: (context, state) {
            return Padding(
              padding: const EdgeInsets.all(20),
              child: Column(
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
                        const Icon(Icons.lock, size: 80, color: Colors.blueAccent), // 🔒 Ícono de seguridad
                        const SizedBox(height: 10),
                        const Text(
                          "Ingresa tu PIN de respaldo",
                          style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                          textAlign: TextAlign.center,
                        ),
                        const SizedBox(height: 20),
                        TextField(
                          controller: _pinController,
                          keyboardType: TextInputType.number,
                          obscureText: true,
                          textAlign: TextAlign.center,
                          maxLength: 4,
                          decoration: InputDecoration(
                            counterText: "", // Ocultar el contador de caracteres
                            filled: true,
                            fillColor: Colors.grey[200],
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10),
                            ),
                            hintText: "****",
                            hintStyle: const TextStyle(fontSize: 24),
                          ),
                          style: const TextStyle(
                            fontSize: 24,
                            letterSpacing: 8, // Espaciado entre dígitos
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        const SizedBox(height: 20),
                        if (state is PinAuthLoading) ...[
                          const CircularProgressIndicator(),
                        ] else ...[
                          ElevatedButton(
                            onPressed: () {
                              final pin = _pinController.text;
                              context.read<PinAuthCubit>().authenticateWithPin(pin);
                            },
                            style: ElevatedButton.styleFrom(
                              backgroundColor: Colors.blueAccent,
                              foregroundColor: Colors.white,
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 40, vertical: 15),
                              textStyle: const TextStyle(fontSize: 18),
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(10)),
                            ),
                            child: const Text("Validar PIN"),
                          ),
                        ],
                      ],
                    ),
                  ),
                ],
              ),
            );
          },
        ),
      ),
    );
  }
}
