import 'package:flutter/material.dart';
import 'package:union_shop/widgets/app_footer.dart';
import 'package:union_shop/widgets/app_header.dart';

class HalloweenPage extends StatelessWidget {
  const HalloweenPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const AppHeader(),
      body: SingleChildScrollView(
        child: Column(
          children: [
            const Padding(
              padding: EdgeInsets.all(24.0),
              child: Center(
                child: Text(
                  'Halloween collection (placeholder)\nAdd seasonal items here.',
                  textAlign: TextAlign.center,
                  style: TextStyle(fontSize: 16),
                ),
              ),
            ),

            /// Shared footer widget
            const AppFooter(),
          ],
        ),
      ),
    );
  }
}
