import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:provider/provider.dart';
import 'package:union_shop/widgets/app_header.dart';
import 'package:union_shop/models/cart_model.dart';

void main() {
  testWidgets('AppHeader shows logo and icons on wide screen',
      (WidgetTester tester) async {
    final binding = TestWidgetsFlutterBinding.ensureInitialized();
    binding.window.physicalSizeTestValue = const Size(1400, 900);
    binding.window.devicePixelRatioTestValue = 1.0;
    addTearDown(() {
      binding.window.clearPhysicalSizeTestValue();
      binding.window.clearDevicePixelRatioTestValue();
    });

    await tester.pumpWidget(ChangeNotifierProvider<CartModel>(
      create: (_) => CartModel(),
      child: const MaterialApp(home: Scaffold(appBar: AppHeader())),
    ));

    await tester.pumpAndSettle();

    // Logo (AdaptiveImage) is present via an Ink/gesture; search by icon buttons
    expect(find.byIcon(Icons.search), findsOneWidget);
    expect(find.byIcon(Icons.person_outline), findsOneWidget);
    expect(find.byIcon(Icons.shopping_bag_outlined), findsOneWidget);
  });

  testWidgets('AppHeader shows mobile search row when search toggled',
      (WidgetTester tester) async {
  final binding = TestWidgetsFlutterBinding.ensureInitialized();
  // narrow screen — increase height so the header has room and avoids
  // vertical RenderFlex overflow in tests.
  binding.window.physicalSizeTestValue = const Size(320, 200);
    binding.window.devicePixelRatioTestValue = 1.0;
    addTearDown(() {
      binding.window.clearPhysicalSizeTestValue();
      binding.window.clearDevicePixelRatioTestValue();
    });

    await tester.pumpWidget(ChangeNotifierProvider<CartModel>(
      create: (_) => CartModel(),
      child: const MaterialApp(home: Scaffold(appBar: AppHeader())),
    ));

    await tester.pumpAndSettle();

    // Initially search row hidden; tap search icon to show
    final searchIcon = find.byIcon(Icons.search).first;
    await tester.tap(searchIcon);
    await tester.pumpAndSettle();

    expect(find.byType(TextField), findsWidgets);
  });
}
