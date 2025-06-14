import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import '../widgets/sign_in_button.dart';

class LoginPage extends StatelessWidget {
  const LoginPage({super.key});

  void _mockSignIn(BuildContext context) {
    // Mock sign-in, navigate to home
    context.go('/home');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(32.0),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                'Picks Leagues',
                style: Theme.of(context).textTheme.headlineLarge?.copyWith(
                  color: Theme.of(context).colorScheme.primary,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 48),
              SignInButton(
                text: 'Sign in with Google',
                icon: Icons.g_mobiledata,
                onPressed: () => _mockSignIn(context),
                color: Colors.white,
                textColor: Colors.black,
              ),
              const SizedBox(height: 16),
              SignInButton(
                text: 'Sign in with Discord',
                icon: Icons.discord,
                onPressed: () => _mockSignIn(context),
                color: Color(0xFF5865F2),
                textColor: Colors.white,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
