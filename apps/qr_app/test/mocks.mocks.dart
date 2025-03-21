// Mocks generated by Mockito 5.4.4 from annotations
// in qr_app/test/mocks.dart.
// Do not manually edit this file.

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'dart:async' as _i4;

import 'package:dartz/dartz.dart' as _i2;
import 'package:mockito/mockito.dart' as _i1;
import 'package:qr_app/core/errors/failures.dart' as _i5;
import 'package:qr_app/domain/entities/auth_result.dart' as _i6;
import 'package:qr_app/domain/entities/qr_result.dart' as _i8;
import 'package:qr_app/domain/entities/scan_history.dart' as _i10;
import 'package:qr_app/domain/repositories/auth_repository.dart' as _i3;
import 'package:qr_app/domain/repositories/qr_scanner_repository.dart' as _i7;
import 'package:qr_app/domain/repositories/scan_history_repository.dart' as _i9;

// ignore_for_file: type=lint
// ignore_for_file: avoid_redundant_argument_values
// ignore_for_file: avoid_setters_without_getters
// ignore_for_file: comment_references
// ignore_for_file: deprecated_member_use
// ignore_for_file: deprecated_member_use_from_same_package
// ignore_for_file: implementation_imports
// ignore_for_file: invalid_use_of_visible_for_testing_member
// ignore_for_file: prefer_const_constructors
// ignore_for_file: unnecessary_parenthesis
// ignore_for_file: camel_case_types
// ignore_for_file: subtype_of_sealed_class

class _FakeEither_0<L, R> extends _i1.SmartFake implements _i2.Either<L, R> {
  _FakeEither_0(
    Object parent,
    Invocation parentInvocation,
  ) : super(
          parent,
          parentInvocation,
        );
}

/// A class which mocks [AuthRepository].
///
/// See the documentation for Mockito's code generation for more information.
class MockAuthRepository extends _i1.Mock implements _i3.AuthRepository {
  MockAuthRepository() {
    _i1.throwOnMissingStub(this);
  }

  @override
  _i4.Future<_i2.Either<_i5.Failure, _i6.AuthResult>> authenticate() =>
      (super.noSuchMethod(
        Invocation.method(
          #authenticate,
          [],
        ),
        returnValue: _i4.Future<_i2.Either<_i5.Failure, _i6.AuthResult>>.value(
            _FakeEither_0<_i5.Failure, _i6.AuthResult>(
          this,
          Invocation.method(
            #authenticate,
            [],
          ),
        )),
      ) as _i4.Future<_i2.Either<_i5.Failure, _i6.AuthResult>>);
}

/// A class which mocks [QrScannerRepository].
///
/// See the documentation for Mockito's code generation for more information.
class MockQrScannerRepository extends _i1.Mock
    implements _i7.QrScannerRepository {
  MockQrScannerRepository() {
    _i1.throwOnMissingStub(this);
  }

  @override
  _i4.Future<_i2.Either<_i5.Failure, _i8.QrResult>> scanQRCode() =>
      (super.noSuchMethod(
        Invocation.method(
          #scanQRCode,
          [],
        ),
        returnValue: _i4.Future<_i2.Either<_i5.Failure, _i8.QrResult>>.value(
            _FakeEither_0<_i5.Failure, _i8.QrResult>(
          this,
          Invocation.method(
            #scanQRCode,
            [],
          ),
        )),
      ) as _i4.Future<_i2.Either<_i5.Failure, _i8.QrResult>>);
}

/// A class which mocks [ScanHistoryRepository].
///
/// See the documentation for Mockito's code generation for more information.
class MockScanHistoryRepository extends _i1.Mock
    implements _i9.ScanHistoryRepository {
  MockScanHistoryRepository() {
    _i1.throwOnMissingStub(this);
  }

  @override
  _i4.Future<_i2.Either<_i5.Failure, void>> saveScan(_i10.ScanHistory? scan) =>
      (super.noSuchMethod(
        Invocation.method(
          #saveScan,
          [scan],
        ),
        returnValue: _i4.Future<_i2.Either<_i5.Failure, void>>.value(
            _FakeEither_0<_i5.Failure, void>(
          this,
          Invocation.method(
            #saveScan,
            [scan],
          ),
        )),
      ) as _i4.Future<_i2.Either<_i5.Failure, void>>);

  @override
  _i4.Future<_i2.Either<_i5.Failure, List<_i10.ScanHistory>>>
      getScanHistory() => (super.noSuchMethod(
            Invocation.method(
              #getScanHistory,
              [],
            ),
            returnValue: _i4
                .Future<_i2.Either<_i5.Failure, List<_i10.ScanHistory>>>.value(
                _FakeEither_0<_i5.Failure, List<_i10.ScanHistory>>(
              this,
              Invocation.method(
                #getScanHistory,
                [],
              ),
            )),
          ) as _i4.Future<_i2.Either<_i5.Failure, List<_i10.ScanHistory>>>);
}
