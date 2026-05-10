import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:pokedex/services/auth_service.dart';
import '../../../navigation/AppRoutes.dart';
import '../../../utiles/shared_pref.dart';

class SignupScreen extends StatefulWidget {
  const SignupScreen({super.key});

  @override
  _SignupScreenState createState() => _SignupScreenState();
}

class _SignupScreenState extends State<SignupScreen> {
  // Checker -------------------------------------------------------

  final formKey = GlobalKey<FormState>();

  final usernameController = TextEditingController();
  final emailController = TextEditingController();
  final passController = TextEditingController();
  final confirmController = TextEditingController();

  bool hidePass = true;
  bool hideConfirm = true;
  bool isChecked = false;
  bool _isLoading = false;

  // Future<void> signUp() async {
  //   try {
  //     await AuthService.signUp(
  //       emailController.text.trim(),
  //       passController.text.trim(),
  //     );
  //
  //     ScaffoldMessenger.of(context).showSnackBar(
  //       const SnackBar(content: Text("created account successfully")),
  //     );
  //
  //     Navigator.pushReplacementNamed(context, AppRoutes.home);
  //   } on FirebaseAuthException catch (e) {
  //     ScaffoldMessenger.of(
  //       context,
  //     ).showSnackBar(const SnackBar(content: Text("firebase auth exception")));
  //   }
  // }

  @override
  void dispose() {
    usernameController.dispose();
    emailController.dispose();
    passController.dispose();
    confirmController.dispose();
    super.dispose();
  }

  Future<void> onSignup() async {
    // 1. Validate Form
    if (!formKey.currentState!.validate()) return;

    // 2. Check Checkbox
    if (!isChecked) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text("You Must Agree To Terms & Conditions"),
          backgroundColor: Colors.red,
        ),
      );
      return;
    }

    setState(() => _isLoading = true);

    try {
      await AuthService.signUp(
        emailController.text.trim(),
        passController.text.trim(),
      );

      final username = usernameController.text.trim();
      final email = emailController.text.trim();
      final pass = passController.text;

      if (!mounted) return;
      Navigator.pushReplacementNamed(context, AppRoutes.home);
    } on FirebaseAuthException catch (e) {
      if (!mounted) return;
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text(e.message ?? "Authentication failed")),
      );
    } finally {
      if (mounted) setState(() => _isLoading = false);
    }
  }

  // Helper to keep code clean since all inputs use the same circular style
  InputDecoration _buildInputDecoration(String label, String hint) {
    return InputDecoration(
      labelText: label,
      hintText: hint,
      border: OutlineInputBorder(borderRadius: BorderRadius.circular(30.0)),
      enabledBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(30.0),
        borderSide: const BorderSide(color: Colors.grey),
      ),
      focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(30.0),
        borderSide: const BorderSide(color: Colors.red, width: 2.0),
      ),
    );
  }

  // Checker ---------------------------------------------------------------------

  @override
  Widget build(BuildContext context) {
    var height = MediaQuery.of(context).size.height;
    var width = MediaQuery.of(context).size.width;
    var topPanelHeight = height * 0.25;

    return Scaffold(
      backgroundColor: Colors.red,
      body: Stack(
        alignment: Alignment.center,
        children: [
          // Background Image
          Positioned(
            top: 50,
            left: 0,
            right: 0,
            child: Opacity(
              opacity: 0.12,
              child: Image.asset(
                'assets/images/Sign_Image.png',
                height: 200,
                width: 200,
                fit: BoxFit.contain,
                errorBuilder: (context, error, stackTrace) => const Icon(
                  Icons.catching_pokemon,
                  size: 150,
                  color: Colors.white10,
                ),
              ),
            ),
          ),

          // White Data Card
          Positioned(
            bottom: 0,
            child: Container(
              width: width,
              height: height - topPanelHeight,
              decoration: const BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(35),
                  topRight: Radius.circular(35),
                ),
              ),
              child: SingleChildScrollView(
                padding: const EdgeInsets.only(
                  top: 30,
                  left: 25,
                  right: 25,
                  bottom: 20,
                ),
                child: Form(
                  key: formKey,
                  child: Column(
                    children: [
                      // Username Field
                      TextFormField(
                        controller: usernameController,
                        decoration: _buildInputDecoration("Username", "User"),
                        validator: (v) {
                          final value = v?.trim() ?? "";
                          if (value.isEmpty) return "Required Username";
                          if (value.length < 3)
                            return "Name Must Be 3+ Characters";
                          return null;
                        },
                      ),
                      const SizedBox(height: 12),

                      // Email Field
                      TextFormField(
                        controller: emailController,
                        keyboardType: TextInputType.emailAddress,
                        decoration: _buildInputDecoration(
                          "Email",
                          "Example@gmail.com",
                        ),
                        validator: (v) {
                          final value = v?.trim() ?? "";
                          if (value.isEmpty) return "Required Email";
                          if (!value.contains("@")) return "Enter valid email";
                          return null;
                        },
                      ),
                      const SizedBox(height: 12),

                      // Password Field
                      TextFormField(
                        controller: passController,
                        obscureText: hidePass,
                        decoration:
                            _buildInputDecoration(
                              "Password",
                              "********",
                            ).copyWith(
                              suffixIcon: IconButton(
                                icon: Icon(
                                  hidePass
                                      ? Icons.visibility_off
                                      : Icons.visibility,
                                ),
                                onPressed: () =>
                                    setState(() => hidePass = !hidePass),
                              ),
                            ),
                        validator: (v) {
                          final value = v ?? "";
                          if (value.isEmpty) return "Required Password";
                          if (value.length < 6)
                            return "Password must be 6+ characters";
                          return null;
                        },
                      ),
                      const SizedBox(height: 12),

                      // Confirm Password Field
                      TextFormField(
                        controller: confirmController,
                        obscureText: hideConfirm,
                        decoration:
                            _buildInputDecoration(
                              "Confirm Password",
                              "********",
                            ).copyWith(
                              suffixIcon: IconButton(
                                icon: Icon(
                                  hideConfirm
                                      ? Icons.visibility_off
                                      : Icons.visibility,
                                ),
                                onPressed: () =>
                                    setState(() => hideConfirm = !hideConfirm),
                              ),
                            ),
                        validator: (v) {
                          final value = v ?? "";
                          if (value.isEmpty) return "Require Password Confirm";
                          if (value != passController.text)
                            return "Passwords don't match";
                          return null;
                        },
                      ),

                      const SizedBox(height: 5),

                      // Terms Checkbox
                      CheckboxListTile(
                        title: const Text(
                          "I accept the Terms & Conditions",
                          style: TextStyle(fontSize: 12),
                        ),
                        value: isChecked,
                        onChanged: (val) => setState(() => isChecked = val!),
                        controlAffinity: ListTileControlAffinity.leading,
                        activeColor: Colors.red,
                        contentPadding: EdgeInsets.zero,
                      ),

                      const SizedBox(height: 10),

                      // Signup Button (Rounded Pill Shape)
                      SizedBox(
                        width: double.infinity,
                        height: 50,
                        child: FilledButton(
                          onPressed: _isLoading ? null : () => onSignup(),
                          style: FilledButton.styleFrom(
                            backgroundColor: Colors.red,
                          ),
                          child: const Text(
                            "Signup",
                            style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      ),

                      const SizedBox(height: 16),

                      // Login Redirect
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          const Text("Have an account? "),
                          GestureDetector(
                            onTap: () {
                              Navigator.pushNamed(context, AppRoutes.login);
                            },
                            child: const Text(
                              "Log in",
                              style: TextStyle(
                                color: Colors.red,
                                fontWeight: FontWeight.bold,
                                decoration: TextDecoration.underline,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),

          // Header Text
          Positioned(
            top: 100,
            left: 25,
            child: const Text(
              'Signup',
              style: TextStyle(
                color: Colors.white,
                fontSize: 35,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
