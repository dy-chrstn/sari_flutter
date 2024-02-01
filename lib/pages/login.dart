import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:sari/pages/main.dart';
import 'package:sari/pages/signup.dart';

void main() => runApp(const MyApp());

class Login extends StatelessWidget {
  const Login({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: const LoginPage(),
      theme: ThemeData(
          textTheme: GoogleFonts.robotoTextTheme(Theme.of(context).textTheme)),
      debugShowCheckedModeBanner: false,
    );
  }
}

class LoginPage extends StatelessWidget {
  const LoginPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        color: const Color(0xFFB3CDE4),
        child: const Padding(
          padding: EdgeInsets.only(top: 16, bottom: 16, left: 24, right: 24),
          child: LoginForm(),
        ),
      ),
    );
  }
}

class LoginForm extends StatefulWidget {
  const LoginForm({super.key});

  @override
  _LoginFormState createState() => _LoginFormState();
}

class _LoginFormState extends State<LoginForm> {
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        //sari icon
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SvgPicture.asset(
              'lib/assets/Sari-Logo.svg',
              width: 131,
              height: 93,
            ),
          ],
        ),
        const SizedBox(height: 64.0),
        //Login
        const Text(
          'Login',
          style: TextStyle(fontSize: 36, fontWeight: FontWeight.w900),
        ),
        const SizedBox(height: 5.0),
        //please sign in to continue
        const Text(
          'Please sign in to continue.',
          style: TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
        ),
        //input username/email
        const SizedBox(height: 12.0),
        Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10),
            color: const Color(0xFFEEF3F9),
          ),
          child: TextField(
            controller: emailController,
            decoration: InputDecoration(
              labelText: 'Username/Email',
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
        //password input
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
        const SizedBox(height: 24.0),
        //login button
        SizedBox(
          width: double.infinity,
          height: 60,
          child: ElevatedButton(
            onPressed: () {
              bool isLoginSuccessful = true;

            if (isLoginSuccessful) {
              Navigator.pushReplacement(
                context,
                MaterialPageRoute(builder: (context) => const MyApp()),
              );
            } 
            },
            style: ElevatedButton.styleFrom(
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10)),
                backgroundColor: const Color(0xFF001B2E)),
            child: const Text('LOGIN',
                style: TextStyle(
                  color: Colors.white,
                )),
          ),
        ),
        const SizedBox(
          height: 120,
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            RichText(
              text: TextSpan(
                  text: 'Don’t have an account? ',
                  style: const TextStyle(color: Colors.black87),
                  children: <TextSpan>[
                    TextSpan(
                      text: 'Sign up',
                      style: const TextStyle(fontWeight: FontWeight.w700),
                      recognizer: TapGestureRecognizer()..onTap = ()=> Navigator.push(context, MaterialPageRoute(builder: (context) => const Signup())),
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
