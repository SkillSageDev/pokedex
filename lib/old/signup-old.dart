import 'package:flutter/material.dart';

import '../navigation/AppRoutes.dart';
import '../utiles/shared_pref.dart';

class SignupScreen extends StatefulWidget {
  const SignupScreen({super.key});

  @override
  State<SignupScreen> createState() => _SignupScreenState();
}

class _SignupScreenState extends State<SignupScreen> {

  final formKey = GlobalKey<FormState>(); //=>12346FGH

  final usernameController = TextEditingController();
  final emailController = TextEditingController();
  final passController = TextEditingController();
  final confirmController = TextEditingController();

  bool hidePass = true;
  bool hideConfirm = true;
  bool isChecked = false;

  @override
  void dispose() {
    usernameController.dispose();
    emailController.dispose();
    passController.dispose();
    confirmController.dispose();
    super.dispose();
  }

  Future<void> onSignup() async {

    final savedEmail = await AuthPrefs.getEmail();

    if (savedEmail == emailController.text.trim())
    {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text("User already exists, go to login"),
          backgroundColor: Colors.red,
          behavior: SnackBarBehavior.floating,
        ),
      );
      return;
    }
    if (!formKey.currentState!.validate()) return;

    if (!isChecked)
    {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text("You Must Agree To Terms & Conditions"),
          backgroundColor: Colors.red,
          behavior: SnackBarBehavior.floating,
        ),
      );
      return;
    }
    final username = usernameController.text.trim();
    final email = emailController.text.trim();
    final pass = passController.text;
    await AuthPrefs.saveUser(username: username, email: email,password: pass);
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
        title: const Text("Signup", style: TextStyle(fontSize: 24,fontWeight: FontWeight.bold),),centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child:
        Form(
          key: formKey,
          child: ListView(
            children: [
              TextFormField(
                controller: usernameController,
                decoration: const InputDecoration(
                  labelText: "Username",
                  hintText: "Mohammed jalal",
                  border: OutlineInputBorder(),
                ),
                validator: (v) {
                  final value = v?.trim() ?? "";
                  if (value.isEmpty) return "Required Username";
                  if (value.length < 3) return "Name Must Be 3+ Characters";
                  return null;
                },
              ),
              const SizedBox(height: 12),

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

              TextFormField(
                controller: confirmController,
                obscureText: hideConfirm,
                decoration: InputDecoration(
                  labelText: "Confirm Password",
                  hintText: "********",
                  border: const OutlineInputBorder(),
                  suffixIcon: IconButton(
                    icon: Icon(hideConfirm ? Icons.visibility_off : Icons.visibility),
                    onPressed: () => setState(() => hideConfirm = !hideConfirm),
                  ),
                ),
                validator: (v) {
                  final value = v ?? "";
                  if (value.isEmpty) return "Require Password Confirm";
                  if (value != passController.text) return "Password isn't Matching";
                  return null;
                },
              ),
              CheckboxListTile(
                title: const Text("By Creating An Account I Accept Selling My Soul To A Greedy Company"),
                value: isChecked,
                onChanged: (val) => setState(() => isChecked = val!),
                controlAffinity: ListTileControlAffinity.leading,
                activeColor: Colors.red,


                side: const BorderSide(
                  color: Colors.red,
                  width: 2.0,
                ),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(24),
                ),
              ),
              const SizedBox(height: 16),
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: onSignup,
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.red,
                      foregroundColor: Colors.white,
                    ),
                  child: const Text("Signup",style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold
                  )),
                ),
              ),
              const SizedBox(height: 16),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Text("have an account? "),
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
    );
  }
}