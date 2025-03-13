import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart'; 
import 'package:qr_app/presentation/ui/history/cubit/scan_history_cubit.dart';
import 'package:qr_app/presentation/ui/scan_qr/cubit/scan_qr_cubit.dart';
import 'package:qr_app/presentation/ui/scan_qr/cubit/scan_qr_state.dart';

class ScanQrScreen extends StatelessWidget {
  const ScanQrScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "Escaneo de QR",
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.history_rounded, color: Colors.white, size: 28), 
            onPressed: () => context.go('/history'),
          ),
        ],
        backgroundColor: Colors.blueAccent, // Fondo azul para un look más moderno
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Center(
          child: BlocConsumer<ScanQrCubit, ScanQrState>(
            listener: (context, state) {
              if (state is ScanQrError) {
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(content: Text("❌ ${state.message}")),
                );
              } else if (state is ScanQrSuccess) {
                context.read<ScanHistoryCubit>().saveScan(state.qrData);
              }
            },
            builder: (context, state) {
              return Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Container(
                    padding: const EdgeInsets.all(20),
                    decoration: BoxDecoration(
                      color: Colors.blueAccent.shade100,
                      borderRadius: BorderRadius.circular(15),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withOpacity(0.1),
                          blurRadius: 10,
                          spreadRadius: 2,
                        ),
                      ],
                    ),
                    child: const Column(
                      children: [
                        Icon(Icons.qr_code_scanner, size: 100, color: Colors.white),
                        SizedBox(height: 10),
                        Text(
                          "Escanea un código QR",
                          style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Colors.white),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 30),

                  // Estado de escaneo
                  if (state is ScanQrLoading) ...[
                    const CircularProgressIndicator(),
                  ] else if (state is ScanQrSuccess) ...[
                    Card(
                      color: Colors.white,
                      elevation: 4,
                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                      child: Padding(
                        padding: const EdgeInsets.all(15),
                        child: Column(
                          children: [
                            const Icon(Icons.check_circle, color: Colors.green, size: 50),
                            const SizedBox(height: 10),
                            const Text(
                              "Código escaneado:",
                              style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                            ),
                            const SizedBox(height: 5),
                            Text(
                              state.qrData,
                              style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Colors.blueAccent),
                              textAlign: TextAlign.center,
                            ),
                          ],
                        ),
                      ),
                    ),
                    const SizedBox(height: 20),
                  ],

                  // Botón de escaneo
                  ElevatedButton.icon(
                    onPressed: () => context.read<ScanQrCubit>().scanQRCode(),
                    icon: const Icon(Icons.camera_alt, size: 24),
                    label: const Text("Escanear QR"),
                    style: ElevatedButton.styleFrom(
                      foregroundColor: Colors.white,
                      backgroundColor: Colors.blueAccent,
                      padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 15),
                      textStyle: const TextStyle(fontSize: 18),
                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
                    ),
                  ),
                  
                  const SizedBox(height: 20),

                  // Botón para ir al historial
                  TextButton.icon(
                    onPressed: () => context.go('/history'),
                    icon: const Icon(Icons.history, color: Colors.blueAccent),
                    label: const Text("Ver historial"),
                    style: TextButton.styleFrom(
                      textStyle: const TextStyle(fontSize: 16),
                    ),
                  ),
                ],
              );
            },
          ),
        ),
      ),
    );
  }
}
