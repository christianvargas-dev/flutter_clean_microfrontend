import 'package:flutter/material.dart';
import 'package:qr_scanner_plugin/qr_scanner_plugin.dart'; // ✅ Plugin de QR
import 'package:auth_biometric_plugin/auth_biometric_plugin.dart'; // ✅ Plugin de Biometría

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: HomeScreen(),
    );
  }
}

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  String? scannedCode;
  String? authStatus;

  /// **Función para escanear QR**
  Future<void> scanQRCode() async {
    try {
      print("Enviando solicitud de escaneo...");
      final result = await QrScannerPlugin().scanQRCode();
      
      setState(() {
        scannedCode = " Código: ${result.value}";
      });

      print(scannedCode);
    } catch (e, stacktrace) {
      print(" Error al escanear QR: $e");
      print(stacktrace);
      setState(() {
        scannedCode = "Error: $e";
      });
    }
  }

  /// **Función para autenticación biométrica**
  Future<void> authenticate() async {
    try {
      print(" Iniciando autenticación biométrica...");
      final result = await AuthBiometricPlugin().authenticate();
      
      setState(() {
        authStatus = result.success 
            ? "Autenticación exitosa" 
            : " Falló: ${result.message}";
      });

      print(authStatus);
    } catch (e, stacktrace) {
      print(" Error en autenticación: $e");
      print(stacktrace);
      setState(() {
        authStatus = "Error: $e";
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("QR & Biometría")),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
          
            Text(scannedCode ?? "Escanea un QR", style: TextStyle(fontSize: 16)),
            Text(authStatus ?? "Autentica con biometría", style: TextStyle(fontSize: 16)),
            SizedBox(height: 20),

         
            ElevatedButton(
              onPressed: scanQRCode,
              child: Text("📷 Escanear QR"),
            ),
            SizedBox(height: 10),

          
            ElevatedButton(
              onPressed: authenticate,
              child: Text("🔐 Autenticación Biométrica"),
            ),
          ],
        ),
      ),
    );
  }
}
