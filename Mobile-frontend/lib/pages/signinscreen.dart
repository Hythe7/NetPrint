import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:printhub/pages/newuploadscreen.dart';
import 'package:sign_in_with_apple/sign_in_with_apple.dart';

class SignInScreen extends StatefulWidget {
  const SignInScreen({Key? key}) : super(key: key);

  @override
  State<SignInScreen> createState() => _SignInScreenState();
}

class _SignInScreenState extends State<SignInScreen> {
  final TextEditingController _emailController = TextEditingController();
  bool _isLoading = false;

  /// Handle Email & Password sign-up or sign-in
  Future<void> _continueWithEmail() async {
    final email = _emailController.text.trim();
    if (email.isEmpty) return;

    setState(() => _isLoading = true);

    try {
      // Create a user with a dummy password (for demo).
      // In a real app, you would collect a password from the user.
      await FirebaseAuth.instance.createUserWithEmailAndPassword(
        email: email,
        password: "password123", // A super secure password
      );
      _showSnackBar("Account created & signed in: $email");
    } on FirebaseAuthException catch (e) {
      if (e.code == 'email-already-in-use') {
        // If user exists, sign in with same password (demo).
        try {
          await FirebaseAuth.instance.signInWithEmailAndPassword(
            email: email,
            password: "ASuperSecureRandomPassword123!",
          );
          _showSnackBar("Welcome back! Signed in: $email");
        } catch (signInError) {
          _showSnackBar("Sign-in failed: $signInError");
        }
      } else {
        _showSnackBar("Error: ${e.message}");
      }
    } catch (e) {
      _showSnackBar("Error: $e");
    } finally {
      Navigator.of(context).pushReplacement(
        MaterialPageRoute(builder: (_) => const MergedTabScreen()),
      );
      setState(() => _isLoading = false);
    }
  }

  /// Google Sign-In
  Future<void> _signInWithGoogle() async {
    setState(() => _isLoading = true);
    try {
      final googleUser = await GoogleSignIn().signIn();
      if (googleUser == null) {
        // User canceled
        setState(() => _isLoading = false);
        return;
      }
      final googleAuth = await googleUser.authentication;
      final credential = GoogleAuthProvider.credential(
        accessToken: googleAuth.accessToken,
        idToken: googleAuth.idToken,
      );
      await FirebaseAuth.instance.signInWithCredential(credential);
      _showSnackBar("Signed in with Google: ${googleUser.email}");
    } catch (e) {
      _showSnackBar("Google Sign-In error: $e");
    } finally {
      setState(() => _isLoading = false);
    }
  }

  /// Apple Sign-In (works on iOS/macOS)
  Future<void> _signInWithApple() async {
    setState(() => _isLoading = true);
    try {
      final credential = await SignInWithApple.getAppleIDCredential(
        scopes: [
          AppleIDAuthorizationScopes.email,
          AppleIDAuthorizationScopes.fullName,
        ],
      );
      final oauthCredential = OAuthProvider("apple.com").credential(
        idToken: credential.identityToken,
        accessToken: credential.authorizationCode,
      );
      await FirebaseAuth.instance.signInWithCredential(oauthCredential);
      _showSnackBar("Signed in with Apple!");
    } catch (e) {
      _showSnackBar("Apple Sign-In error: $e");
    } finally {
      setState(() => _isLoading = false);
    }
  }

  void _showSnackBar(String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text(message)),
    );
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 24),
          child: Column(
            children: [
              // Top "Sign In" text (optional)
              // If your reference image shows "Sign In" at the top-left,
              // you can replicate that with a Row + Text or an AppBar.
              Align(
                alignment: Alignment.centerLeft,
                child: Text(
                  "Sign In",
                  style: theme.textTheme.titleMedium?.copyWith(
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),

              const SizedBox(height: 24),

              // Illustration
              SizedBox(
                height: 200,
                child: Image.asset(
                  'assets/images/onboard.png',
                  fit: BoxFit.contain,
                ),
              ),

              const SizedBox(height: 24),

              // Title: "Create an account"
              Text(
                "Create an account",
                style: theme.textTheme.titleLarge?.copyWith(
                  fontWeight: FontWeight.bold,
                ),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 8),

              // Subtitle
              Text(
                "Enter your email to sign up for this app",
                style: theme.textTheme.bodyMedium?.copyWith(
                  color: Colors.grey[700],
                ),
                textAlign: TextAlign.center,
              ),

              const SizedBox(height: 32),

              // Email TextField
              TextField(
                controller: _emailController,
                keyboardType: TextInputType.emailAddress,
                decoration: InputDecoration(
                  hintText: "email@domain.com",
                  filled: true,
                  fillColor: Colors.grey[100],
                  contentPadding: const EdgeInsets.symmetric(
                    horizontal: 16,
                    vertical: 16,
                  ),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(8),
                    borderSide: BorderSide.none, // No visible border
                  ),
                ),
              ),

              const SizedBox(height: 16),

              // Green "Continue" button
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: _isLoading ? null : _continueWithEmail,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xFF4CAF50), // Green color
                    padding: const EdgeInsets.symmetric(vertical: 16),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8),
                    ),
                  ),
                  child: _isLoading
                      ? const CircularProgressIndicator(color: Colors.white)
                      : const Text(
                          "Continue",
                          style: TextStyle(fontSize: 16, color: Colors.white),
                        ),
                ),
              ),

              const SizedBox(height: 16),

              // OR divider
              Row(
                children: [
                  Expanded(
                    child: Divider(
                      thickness: 1,
                      color: Colors.grey[300],
                    ),
                  ),
                  const Padding(
                    padding: EdgeInsets.symmetric(horizontal: 8),
                    child: Text("or"),
                  ),
                  Expanded(
                    child: Divider(
                      thickness: 1,
                      color: Colors.grey[300],
                    ),
                  ),
                ],
              ),

              const SizedBox(height: 16),

              // Continue with Google
              SizedBox(
                width: double.infinity,
                child: OutlinedButton.icon(
                  onPressed: _isLoading ? null : _signInWithGoogle,
                  style: OutlinedButton.styleFrom(
                    padding: const EdgeInsets.symmetric(vertical: 14),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8),
                    ),
                    side: BorderSide(color: Colors.grey[300]!),
                  ),
                  icon: Image.network(
                    'https://upload.wikimedia.org/wikipedia/commons/4/4a/Logo_2013_Google.png',
                    height: 24,
                  ),
                  label: const Text(
                    "Continue with Google",
                    style: TextStyle(color: Colors.black),
                  ),
                ),
              ),

              const SizedBox(height: 16),

              // Continue with Apple
              // This will only work on iOS (and macOS) for real sign-in
              SizedBox(
                width: double.infinity,
                child: OutlinedButton.icon(
                  onPressed: _isLoading ? null : _signInWithApple,
                  style: OutlinedButton.styleFrom(
                    padding: const EdgeInsets.symmetric(vertical: 14),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8),
                    ),
                    side: BorderSide(color: Colors.grey[300]!),
                  ),
                  icon: const Icon(Icons.apple, color: Colors.black),
                  label: const Text(
                    "Continue with Apple",
                    style: TextStyle(color: Colors.black),
                  ),
                ),
              ),

              const SizedBox(height: 32),

              // Terms of Service
              Text(
                "By clicking continue, you agree to our Terms of Service and Privacy Policy.",
                style: theme.textTheme.bodySmall?.copyWith(
                  color: Colors.grey[600],
                ),
                textAlign: TextAlign.center,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
