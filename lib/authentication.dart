import 'package:flutter/material.dart';

class LoginPage extends StatelessWidget {
  const LoginPage({super.key});

  @override
  Widget build(BuildContext context) {
    const shopPurple = Color(0xFF5C3CF0); // bright button colour

    return Scaffold(
      backgroundColor: const Color(0xFFF7F7F7),
      body: Center(
        child: ConstrainedBox(
          constraints: const BoxConstraints(maxWidth: 430),
          child: Card(
            elevation: 4,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(16),
            ),
            child: Padding(
              padding: const EdgeInsets.symmetric(
                horizontal: 32,
                vertical: 32,
              ),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  // Logo text
                  const Text.rich(
                    TextSpan(
                      children: [
                        TextSpan(
                          text: 'The ',
                          style: TextStyle(
                            fontFamily: 'Sans',
                            fontSize: 28,
                            fontWeight: FontWeight.w400,
                            color: Colors.deepPurple,
                          ),
                        ),
                        TextSpan(
                          text: 'UNION',
                          style: TextStyle(
                            fontFamily: 'Sans',
                            fontSize: 28,
                            fontWeight: FontWeight.w800,
                            letterSpacing: 1.5,
                            color: Colors.deepPurple,
                          ),
                        ),
                      ],
                    ),
                    textAlign: TextAlign.center,
                  ),
                  const SizedBox(height: 24),

                  // "Sign in" title
                  const Align(
                    alignment: Alignment.centerLeft,
                    child: Text(
                      'Sign in',
                      style: TextStyle(
                        fontSize: 22,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                  ),
                  const SizedBox(height: 8),

                  const Align(
                    alignment: Alignment.centerLeft,
                    child: Text(
                      "Choose how you’d like to sign in",
                      style: TextStyle(
                        fontSize: 14,
                        color: Colors.black54,
                      ),
                    ),
                  ),
                  const SizedBox(height: 24),

                  // Sign in with shop button
                  SizedBox(
                    width: double.infinity,
                    child: ElevatedButton(
                      onPressed: () {
                        // TODO: handle "Sign in with shop"
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: shopPurple,
                        foregroundColor: Colors.white,
                        padding: const EdgeInsets.symmetric(vertical: 14),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(6),
                        ),
                        textStyle: const TextStyle(
                          fontSize: 15,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      child: const Text('Sign in with shop'),
                    ),
                  ),

                  const SizedBox(height: 24),

                  // Divider with "or"
                  Row(
                    children: const [
                      Expanded(
                        child: Divider(
                          thickness: 1,
                          color: Color(0xFFE0E0E0),
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.symmetric(horizontal: 12),
                        child: Text(
                          'or',
                          style: TextStyle(color: Colors.black45),
                        ),
                      ),
                      Expanded(
                        child: Divider(
                          thickness: 1,
                          color: Color(0xFFE0E0E0),
                        ),
                      ),
                    ],
                  ),

                  const SizedBox(height: 24),

                  // Email field
                  TextField(
                    keyboardType: TextInputType.emailAddress,
                    decoration: InputDecoration(
                      labelText: 'Email',
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(8),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(8),
                        borderSide: const BorderSide(
                          color: shopPurple,
                          width: 2,
                        ),
                      ),
                      isDense: true,
                      contentPadding: const EdgeInsets.symmetric(
                        horizontal: 12,
                        vertical: 14,
                      ),
                    ),
                  ),

                  const SizedBox(height: 24),

                  // Continue button (disabled look)
                  SizedBox(
                    width: double.infinity,
                    child: ElevatedButton(
                      onPressed: () {
                        // TODO: enable when email is valid
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: const Color(0xFFF3F3F3),
                        foregroundColor: Colors.grey[700],
                        disabledBackgroundColor: const Color(0xFFF3F3F3),
                        disabledForegroundColor: Colors.grey,
                        elevation: 0,
                        padding: const EdgeInsets.symmetric(vertical: 14),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(6),
                        ),
                        textStyle: const TextStyle(
                          fontSize: 15,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      child: const Text('Continue'),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
