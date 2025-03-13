import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:get_it/get_it.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import 'package:qr_app/main.dart'; // Asegúrate de importar tu app
import 'package:qr_app/domain/use_cases/auth_use_case.dart';
import 'package:qr_app/domain/repositories/auth_repository.dart';

import 'mocks.mocks.dart';
//import 'widget_test.mocks.dart';

final GetIt sl = GetIt.instance;

@GenerateMocks([AuthRepository])
void main() {
  late MockAuthRepository mockAuthRepository;

  setUpAll(() {
    mockAuthRepository = MockAuthRepository();

    sl.registerLazySingleton<AuthRepository>(() => mockAuthRepository);
    sl.registerLazySingleton<AuthUseCase>(() => AuthUseCase(sl<AuthRepository>()));
  });

  tearDownAll(() {
    sl.reset();
  });

  testWidgets('Counter increments smoke test', (WidgetTester tester) async {
    await tester.pumpWidget(const MyApp());

    expect(find.text('0'), findsOneWidget);
    expect(find.text('1'), findsNothing);

    await tester.tap(find.byIcon(Icons.add));
    await tester.pump();

    expect(find.text('0'), findsNothing);
    expect(find.text('1'), findsOneWidget);
  });
}
