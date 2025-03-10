import AVFoundation
import UIKit

class QRScannerApiImpl: NSObject, QRScannerApi, AVCaptureMetadataOutputObjectsDelegate {
    private var completion: ((Result<QRResult, Error>) -> Void)?

    func scanQRCode(completion: @escaping (Result<QRResult, Error>) -> Void) {
        DispatchQueue.main.async {
            guard let rootViewController = UIApplication.shared.keyWindow?.rootViewController else {
                completion(.failure(NSError(domain: "QRScanner", code: 0, userInfo: [NSLocalizedDescriptionKey: "No se pudo obtener la vista principal."])))
                return
            }

            self.completion = completion

            let scannerVC = QRScannerViewController()
            scannerVC.delegate = self
            rootViewController.present(scannerVC, animated: true)
        }
    }
}

extension QRScannerApiImpl: QRScannerViewControllerDelegate {
    func didScanQRCode(result: String) {
        completion?(.success(QRResult(value: result)))
    }

    func didFailScanning(error: String) {
        completion?(.failure(NSError(domain: "QRScanner", code: 1, userInfo: [NSLocalizedDescriptionKey: error])))
    }
}
