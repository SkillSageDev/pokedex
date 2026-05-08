import 'package:flutter/material.dart';
import '../navigation/AppRoutes.dart';
import '../utiles/shared_pref.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final formKey = GlobalKey<FormState>(); //=>12346FGH

  final emailController = TextEditingController();
  final passController = TextEditingController();

  bool hidePass = true;

  @override
  void dispose() {
    emailController.dispose();
    passController.dispose();
    super.dispose();
  }

  Future<void> onSignup() async {
    if (!formKey.currentState!.validate()) return;

    final email = emailController.text.trim();
    final pass = passController.text;
    await AuthPrefs.saveUser(username: 'Nan', email: email,password: pass);
    Navigator.pushNamed(context, AppRoutes.home);

  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        title: const Text("Login", style: TextStyle(fontSize: 24,fontWeight: FontWeight.bold),),centerTitle: true,
      ),
      body:
      Padding(
        padding: const EdgeInsets.all(16),
        child:
        Form(
          key: formKey,
          child: ListView(
            children: [
              TextFormField(
                controller: emailController,
                keyboardType: TextInputType.emailAddress,
                decoration: const InputDecoration(
                  labelText: "Email",
                  hintText: "Example@gmail.com",
                  border: OutlineInputBorder(),
                ),
                validator: (v) {
                  final value = v?.trim() ?? "";
                  if (value.isEmpty) return "Required Email";
                  if (!value.contains("@")) return "Enter valid email";
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
                  border: const OutlineInputBorder(),
                  suffixIcon: IconButton(
                    icon: Icon(hidePass ? Icons.visibility_off : Icons.visibility),
                    onPressed: () => setState(() => hidePass = !hidePass),
                  ),
                ),
                validator: (v) {
                  final value = v ?? "";
                  if (value.isEmpty) return "Required Password";
                  if (value.length < 6) return "Password must be 6+ characters";
                  return null;
                },
              ),

              const SizedBox(height: 12),

              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: onSignup,
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.red,
                      foregroundColor: Colors.white,
                    ),
                  child: const Text("Login",style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold
                  )),
                ),
              ),
              const SizedBox(height: 16),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Text("Don't have an account? "),
                  GestureDetector(
                    onTap: () {
                      Navigator.pushNamed(context, AppRoutes.signup);
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
      ),
    );
  }
}