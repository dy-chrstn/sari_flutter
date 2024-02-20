import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:mongo_dart/mongo_dart.dart' as M;
import 'package:sari/dbHelper/mongodb.dart';
import 'package:sari/model/business_acc_model.dart';

class Signup extends StatelessWidget {
  const Signup({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
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
  final _formKey = GlobalKey<FormState>();
  final TextEditingController usernameController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController confirmPasswordController =
      TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: Column(
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
          const Text(
            'Create Account',
            style: TextStyle(fontSize: 30, fontWeight: FontWeight.w900),
          ),
          const SizedBox(height: 12.0),
          TextFormField(
            controller: usernameController,
            decoration: InputDecoration(
              labelText: 'Username',
              fillColor: Colors.white70,
              filled: true,
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(10),
              ),
            ),
            validator: (value) {
              if (value == null || value.isEmpty) {
                return 'Please enter your username';
              }
              return null;
            },
          ),
          const SizedBox(height: 16.0),
          TextFormField(
            controller: emailController,
            decoration: InputDecoration(
              labelText: 'Email',
              fillColor: Colors.white70,
              filled: true,
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(10),
              ),
            ),
            validator: (value) {
              if (value == null || value.isEmpty) {
                return 'Please enter your email';
              }
              return null;
            },
          ),
          const SizedBox(height: 16.0),
          TextFormField(
            controller: passwordController,
            decoration: InputDecoration(
              labelText: 'Password',
              fillColor: Colors.white70,
              filled: true,
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(10),
              ),
            ),
            obscureText: true,
            validator: (value) {
              if (value == null || value.isEmpty) {
                return 'Please enter a password';
              }
              return null;
            },
          ),
          const SizedBox(height: 16.0),
          TextFormField(
            controller: confirmPasswordController,
            decoration: InputDecoration(
              labelText: 'Confirm Password',
              fillColor: Colors.white70,
              filled: true,
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(10),
              ),
            ),
            obscureText: true,
            validator: (value) {
              if (value != passwordController.text) {
                return 'Passwords do not match';
              }
              return null;
            },
          ),
          const SizedBox(height: 24.0),
          SizedBox(
            width: double.infinity,
            height: 60,
            child: ElevatedButton(
              onPressed: () {
                if (_formKey.currentState!.validate()) {
                  // Form is valid, perform signup or other actions here
                  // Access the controllers for each text field to get the entered values.
                  // print('Username: ${usernameController.text}');
                  // print('Email: ${emailController.text}');
                  // print('Password: ${passwordController.text}');
                  // print('Confirm Password: ${confirmPasswordController.text}');

                  _insertData(usernameController.text, emailController.text,
                      passwordController.text);
                }
              },
              style: ElevatedButton.styleFrom(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
                backgroundColor: const Color(0xFF001B2E),
              ),
              child: const Text(
                'SIGN UP',
                style: TextStyle(color: Colors.white),
              ),
            ),
          ),
          const SizedBox(height: 100),
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
                      recognizer: TapGestureRecognizer()
                        ..onTap = () {
                          Navigator.pop(context);
                        },
                    ),
                  ],
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Future<void> _insertData(
      String username, String email, String password) async {
    var _id = M.ObjectId();
    final businessAccData = BusinessAcc(
        id: _id, username: username, password: password);

    var result = await MongoDatabase.insert(businessAccData);
    ScaffoldMessenger.of(context)
        .showSnackBar(SnackBar(content: Text('Inserted ID: ' + _id.oid)));
    _clearAll();
  }

  void _clearAll(){
    usernameController.text = "";
    emailController.text = "";
    passwordController.text = "";
    confirmPasswordController.text = "";
  }
}
