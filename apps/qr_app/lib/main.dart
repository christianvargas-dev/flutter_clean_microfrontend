import 'package:flutter/material.dart';
import 'package:qr_scanner_plugin/qr_scanner_plugin.dart'; // ✅ Importar el plugin

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: ScannerScreen(),
    );
  }
}

class ScannerScreen extends StatefulWidget {
  @override
  _ScannerScreenState createState() => _ScannerScreenState();
}

class _ScannerScreenState extends State<ScannerScreen> {
  String? scannedCode;

 Future<void> scanQRCode() async {
  try {
    print("📡 Enviando solicitud de escaneo...");
    final result = await QrScannerPlugin().scanQRCode();
    print("✅ Código escaneado: ${result.value}");
    setState(() {
      scannedCode = result.value;
    });
  } catch (e, stacktrace) {
    print("❌ Error al escanear QR: $e");
    print(stacktrace);
    setState(() {
      scannedCode = "Error: $e";
    });
  }
}

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Escáner QR")),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(scannedCode ?? "Presiona el botón para escanear"),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: scanQRCode, // ✅ Ejecutar el escaneo al presionar el botón
              child: Text("Escanear QR"),
            ),
          ],
        ),
      ),
    );
  }
}
