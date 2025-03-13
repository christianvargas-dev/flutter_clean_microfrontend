import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:intl/intl.dart';
import 'package:qr_app/presentation/ui/history/cubit/scan_history_cubit.dart';

class ScanHistoryScreen extends StatelessWidget {
  const ScanHistoryScreen({super.key});

  @override
  Widget build(BuildContext context) {

    context.read<ScanHistoryCubit>().loadHistory();
    
    return Scaffold(
      appBar: AppBar(
        title: const Text("Historial de Escaneos"),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back), 
          onPressed: () => context.go('/scan'),
        ),
      ),
      body: BlocBuilder<ScanHistoryCubit, ScanHistoryState>(
        builder: (context, state) {
          if (state is ScanHistoryLoading) {
            return const Center(child: CircularProgressIndicator());
          } else if (state is ScanHistoryLoaded) {
            if (state.history.isEmpty) {
              return const Center(child: Text("No hay escaneos aún."));
            }

            return ListView.builder(
              padding: const EdgeInsets.all(10),
              itemCount: state.history.length,
              itemBuilder: (context, index) {
                final scan = state.history[index];
                final formattedDate = DateFormat('dd/MM/yyyy HH:mm').format(scan.timestamp);

                return Card(
                  elevation: 3,
                  margin: const EdgeInsets.symmetric(vertical: 8, horizontal: 10),
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
                  child: ListTile(
                    leading: const Icon(Icons.qr_code, size: 40, color: Colors.blue), // 📌 Ícono QR
                    title: Text(
                      scan.scannedCode,
                      style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                      overflow: TextOverflow.ellipsis, // Para evitar desbordamiento
                    ),
                    subtitle: Text(
                      "Escaneado el: $formattedDate",
                      style: const TextStyle(color: Colors.grey),
                    ),
                    trailing: IconButton(
                      icon: const Icon(Icons.copy, color: Colors.grey), // 📋 Botón para copiar
                      onPressed: () {
                        // Copiar código al portapapeles
                        Clipboard.setData(ClipboardData(text: scan.scannedCode));
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(content: Text("Código copiado al portapapeles")),
                        );
                      },
                    ),
                  ),
                );
              },
            );
          }

          return const Center(child: Text("No hay escaneos aún."));
        },
      ),
    );
  }
}
