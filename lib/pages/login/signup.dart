import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

void main() {
  runApp(const Signup());
}

class Signup extends StatelessWidget {
  const Signup({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        color: const Color(0xFFB3CDE4),
        child: const Padding(
          padding: EdgeInsets.only(top: 16, bottom: 16, left: 24, right: 24),
          child: SignupForm(),
        ),
      ),
    );
  }
}

class SignupForm extends StatefulWidget {
  const SignupForm({super.key});

  @override
  _SignupFormState createState() => _SignupFormState();
}

class _SignupFormState extends State<SignupForm> {
  final TextEditingController usernameController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController confirmPasswordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SvgPicture.asset(
              'lib/assets/Sari-Logo.svg',
              width: 84,
              height: 60,
            ),
          ],
        ),
        const SizedBox(height: 64.0),
        //Login
        const Text(
          'Create Account',
          style: TextStyle(fontSize: 30, fontWeight: FontWeight.w900),
        ),
        const SizedBox(height: 12.0),
        Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10),
            color: const Color(0xFFEEF3F9),
          ),
          child: TextField(
            controller: usernameController,
            decoration: InputDecoration(
              labelText: 'Username',
              enabledBorder: OutlineInputBorder(
                borderSide:
                    const BorderSide(color: Colors.transparent, width: 0.0),
                borderRadius: BorderRadius.circular(10.0),
              ),
              focusedBorder: OutlineInputBorder(
                // Customize focused state if needed
                borderSide:
                    const BorderSide(color: Colors.transparent, width: 1.0),
                borderRadius: BorderRadius.circular(10.0),
              ),
            ),
          ),
        ),
        const SizedBox(height: 16.0),
        Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10),
            color: const Color(0xFFEEF3F9),
          ),
          child: TextField(
            controller: emailController,
            decoration: InputDecoration(
              labelText: 'Email',
              enabledBorder: OutlineInputBorder(
                borderSide:
                    const BorderSide(color: Colors.transparent, width: 0.0),
                borderRadius: BorderRadius.circular(10.0),
              ),
              focusedBorder: OutlineInputBorder(
                // Customize focused state if needed
                borderSide:
                    const BorderSide(color: Colors.transparent, width: 1.0),
                borderRadius: BorderRadius.circular(10.0),
              ),
            ),
          ),
        ),
        const SizedBox(height: 16.0),
        Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10),
            color: const Color(0xFFEEF3F9),
          ),
          child: TextField(
            controller: passwordController,
            decoration: InputDecoration(
              labelText: 'Password',
              enabledBorder: OutlineInputBorder(
                borderSide:
                    const BorderSide(color: Colors.transparent, width: 0.0),
                borderRadius: BorderRadius.circular(10.0),
              ),
              focusedBorder: OutlineInputBorder(
                // Customize focused state if needed
                borderSide:
                    const BorderSide(color: Colors.transparent, width: 1.0),
                borderRadius: BorderRadius.circular(10.0),
              ),
            ),
            obscureText: true,
          ),
        ),
        const SizedBox(height: 16.0),
        Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10),
            color: const Color(0xFFEEF3F9),
          ),
          child: TextField(
            controller: confirmPasswordController,
            decoration: InputDecoration(
              labelText: 'Confirm Password',
              enabledBorder: OutlineInputBorder(
                borderSide:
                    const BorderSide(color: Colors.transparent, width: 0.0),
                borderRadius: BorderRadius.circular(10.0),
              ),
              focusedBorder: OutlineInputBorder(
                // Customize focused state if needed
                borderSide:
                    const BorderSide(color: Colors.transparent, width: 1.0),
                borderRadius: BorderRadius.circular(10.0),
              ),
            ),
            obscureText: true,
          ),
        ),
        const SizedBox(height: 24.0),
        SizedBox(
          width: double.infinity,
          height: 60,
          child: ElevatedButton(
            onPressed: () {
            // You can access the controllers for each text field
            // to get the entered values.
            // print('Username: ${usernameController.text}');
            // print('Email: ${emailController.text}');
            // print('Password: ${passwordController.text}');
            // print('Confirm Password: ${confirmPasswordController.text}');
            },
            style: ElevatedButton.styleFrom(
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10)),
                backgroundColor: const Color(0xFF001B2E)),
            child: const Text('SIGN UP',
                style: TextStyle(
                  color: Colors.white,
                )),
          ),
        ),
        const SizedBox(
          height: 100,
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            RichText(
              text: TextSpan(
                  text: 'Already have an account? ',
                  style: const TextStyle(color: Colors.black87),
                  children: <TextSpan>[
                    TextSpan(
                      text: 'Sign in',
                      style: const TextStyle(fontWeight: FontWeight.w700),
                      recognizer: TapGestureRecognizer()..onTap =() {
                        Navigator.pop(context);
                      } 
                    )
                  ]),
            )
            // Text('Don’t have an account? '),
            // Text(
            //   'Sign up',
            //   style: TextStyle(fontWeight: FontWeight.w700),
            // )
          ],
        )
        
      ],
    );
  }
}
