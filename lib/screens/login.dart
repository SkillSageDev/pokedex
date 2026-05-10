import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:pokedex/services/auth_service.dart';
import '../../navigation/AppRoutes.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  //Checker -------------------------------------------------------

  //=>12346FGH
  final formKey = GlobalKey<FormState>();

  final emailController = TextEditingController();
  final passController = TextEditingController();

  bool hidePass = true;
  bool _isLoading = false;

  @override
  void dispose() {
    emailController.dispose();
    passController.dispose();
    super.dispose();
  }

  Future<void> onLogin() async {
    if (!formKey.currentState!.validate()) return;

    final email = emailController.text.trim();
    final pass = passController.text;

    setState(() => _isLoading = true);

    try {
      await AuthService.logIn(
        emailController.text.trim(),
        passController.text.trim(),
      );

      final email = emailController.text.trim();
      final pass = passController.text;

      if (!mounted) return;
      Navigator.pushNamed(context, AppRoutes.home);
    } on FirebaseAuthException catch (e) {
      if (!mounted) return;
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text(e.message ?? "Authentication failed")),
      );
    } finally {
      if (mounted) setState(() => _isLoading = false);
    }
  }

  //Checker ---------------------------------------------------------------------

  @override
  Widget build(BuildContext context) {
    var height = MediaQuery.of(context).size.height;
    var width = MediaQuery.of(context).size.width;
    var topPanelHeight = height * 0.35;

    return Scaffold(
      backgroundColor: Colors.red,
      body: Stack(
        alignment: Alignment.center,
        children: [
          Positioned(
            top: 70,
            left: 0,
            right: 0,
            child: Opacity(
              opacity: 0.12,
              child: Image.asset(
                'assets/images/Sign_Image.png',
                height: 250,
                width: 250,
                fit: BoxFit.contain,
                errorBuilder: (context, error, stackTrace) => const Icon(
                  Icons.catching_pokemon,
                  size: 200,
                  color: Colors.white10,
                ),
              ),
            ),
          ),

          // 2. White Data Card
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
                padding: const EdgeInsets.only(top: 50, left: 25, right: 25),
                child: Column(
                  children: [
                    // This Is Where We Will Put Login Items ------------------------------------------------------------------------
                    Form(
                      key: formKey,
                      child: Column(
                        // FIXED: Changed ListView to Column
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          TextFormField(
                            controller: emailController,
                            keyboardType: TextInputType.emailAddress,
                            decoration: const InputDecoration(
                              labelText: "Email",
                              hintText: "Example@gmail.com",
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.all(
                                  Radius.circular(30.0),
                                ),
                              ),
                            ),
                            validator: (v) {
                              final value = v?.trim() ?? "";
                              if (value.isEmpty) return "Required Email";
                              if (!value.contains("@"))
                                return "Enter valid email";
                              return null;
                            },
                          ),
                          const SizedBox(height: 12),

                          TextFormField(
                            controller: passController,
                            obscureText: hidePass,
                            decoration: InputDecoration(
                              labelText: "Password",
                              hintText: "********",
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.all(
                                  Radius.circular(30.0),
                                ),
                              ),
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

                          SizedBox(
                            width: double.infinity,
                            height: 50,
                            child: ElevatedButton(
                              onPressed: _isLoading ? null : onLogin,
                              style: ElevatedButton.styleFrom(
                                backgroundColor: Colors.red,
                                foregroundColor: Colors.white,
                              ),
                              child: const Text(
                                "Login",
                                style: TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                          ),
                          const SizedBox(height: 16),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              const Text("Don't have an account? "),
                              GestureDetector(
                                onTap: () {
                                  Navigator.pushNamed(
                                    context,
                                    AppRoutes.signup,
                                  );
                                },
                                child: const Text(
                                  "Sign up",
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

                    // -----------------------------------------------------------------------------------------------------------------------------
                  ],
                ),
              ),
            ),
          ),
          // 4. Header Info
          Positioned(
            top: 100,
            left: 25,
            right: 25,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: const [
                //Title
                Text(
                  'Login',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 35,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

