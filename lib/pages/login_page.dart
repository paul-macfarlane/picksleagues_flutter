import 'dart:io' show Platform;
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import '../services/auth.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  bool _isLoading = false;

  String _getGoogleLogoAsset(BuildContext context) {
    final brightness = Theme.of(context).brightness;
    final isDark = brightness == Brightness.dark;
    if (Platform.isIOS) {
      return isDark
          ? 'assets/google/ios_dark_rd_na@1x.png'
          : 'assets/google/ios_light_rd_na@1x.png';
    } else {
      // Default to Android
      return isDark
          ? 'assets/google/android_dark_rd_na@1x.png'
          : 'assets/google/android_light_rd_na@1x.png';
    }
  }

  Future<void> _handleGoogleSignIn(BuildContext context) async {
    setState(() => _isLoading = true);
    try {
      await signInWithGoogle();
      if (context.mounted) {
        context.go('/home');
      }
    } catch (e, st) {
      debugPrint('Google sign-in error: $e\n$st');
      if (context.mounted) {
        ScaffoldMessenger.of(
          context,
        ).showSnackBar(SnackBar(content: Text('Sign in failed: $e')));
      }
    } finally {
      if (context.mounted) setState(() => _isLoading = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;
    return Scaffold(
      body: Center(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(32.0),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                // Splash Section
                Text(
                  'Picks Leagues',
                  style: theme.textTheme.headlineLarge?.copyWith(
                    color: colorScheme.primary,
                    fontWeight: FontWeight.bold,
                  ),
                  textAlign: TextAlign.center,
                ),
                const SizedBox(height: 8),
                Text(
                  'Compete with friends to see who is the best at making NFL picks!',
                  style: theme.textTheme.titleMedium?.copyWith(
                    color: colorScheme.onBackground.withOpacity(0.7),
                  ),
                  textAlign: TextAlign.center,
                ),
                const SizedBox(height: 32),
                // Feature List
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: const [
                    FeatureTile(
                      icon: Icons.sports_football,
                      text: 'NFL picks: against the spread or straight up',
                    ),
                    FeatureTile(
                      icon: Icons.group,
                      text: 'Create or join leagues with friends',
                    ),
                    FeatureTile(
                      icon: Icons.emoji_events,
                      text: 'Track standings and see who is on top',
                    ),
                    FeatureTile(
                      icon: Icons.lock,
                      text: 'Private and public leagues',
                    ),
                    FeatureTile(
                      icon: Icons.light_mode,
                      text: 'Light & dark mode support',
                    ),
                  ],
                ),
                const SizedBox(height: 48),
                // Google Sign-In Button
                _isLoading
                    ? const CircularProgressIndicator()
                    : SizedBox(
                        width: double.infinity,
                        child: OutlinedButton.icon(
                          icon: Image.asset(
                            _getGoogleLogoAsset(context),
                            height: 24,
                            width: 24,
                          ),
                          label: const Text(
                            'Sign in with Google',
                            style: TextStyle(
                              color: Color(0xFF3C4043),
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                          style: OutlinedButton.styleFrom(
                            backgroundColor: Colors.white,
                            side: const BorderSide(color: Color(0xFFDDDFE2)),
                            padding: const EdgeInsets.symmetric(vertical: 12),
                            textStyle: const TextStyle(fontSize: 16),
                          ),
                          onPressed: () => _handleGoogleSignIn(context),
                        ),
                      ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class FeatureTile extends StatelessWidget {
  final IconData icon;
  final String text;
  const FeatureTile({super.key, required this.icon, required this.text});

  @override
  Widget build(BuildContext context) {
    final color = Theme.of(context).colorScheme.primary;
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4.0),
      child: Row(
        children: [
          Icon(icon, color: color, size: 22),
          const SizedBox(width: 10),
          Expanded(
            child: Text(text, style: Theme.of(context).textTheme.bodyLarge),
          ),
        ],
      ),
    );
  }
}
