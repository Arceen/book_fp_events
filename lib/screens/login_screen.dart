import 'package:flutter/material.dart';

import '../shared/authentication.dart';
import 'event_screen.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final TextEditingController txtEmail = TextEditingController();
  final TextEditingController txtPassword = TextEditingController();
  bool _isLogin = true;
  String? _userId;
  String? _password;
  String? _email;
  String? _message;

  late final Authentication auth;

  @override
  void initState() {
    auth = Authentication();
    super.initState();
  }

  Widget emailInput() {
    return Padding(
      padding: EdgeInsets.only(
        top: 120,
      ),
      child: TextFormField(
        controller: txtEmail,
        keyboardType: TextInputType.emailAddress,
        decoration: InputDecoration(
          hintText: 'email',
          icon: Icon(Icons.mail),
        ),
        validator: (text) => text!.isEmpty ? 'Email is required' : '',
      ),
    );
  }

  Widget passwordInput() {
    return Padding(
      padding: EdgeInsets.only(
        top: 120,
      ),
      child: TextFormField(
        controller: txtPassword,
        keyboardType: TextInputType.visiblePassword,
        obscureText: true,
        decoration: InputDecoration(
          hintText: 'password',
          icon: Icon(Icons.enhanced_encryption),
        ),
        validator: (text) => text!.isEmpty ? 'Password is required' : '',
      ),
    );
  }

  Widget mainButton() {
    String buttonText = _isLogin ? 'Login' : 'Sign up';
    return Padding(
      padding: EdgeInsets.only(top: 120),
      child: Container(
          height: 50,
          child: ElevatedButton(
            child: Text(buttonText),
            style: ButtonStyle(
              backgroundColor: MaterialStateProperty.all<Color>(Colors.red),
              elevation: MaterialStateProperty.all<double>(3),
            ),
            onPressed: submit,
          )),
    );
  }

  void submit() async {
    setState(() {
      _message = "";
    });

    try {
      if (_isLogin) {
        _userId = await auth.login(txtEmail.text, txtPassword.text);
        print('Login for user $_userId');
      } else {
        _userId = await auth.signUp(txtEmail.text, txtPassword.text);
        print('Sign up for user $_userId');
      }
      if (_userId != null) {
        Navigator.push(
            context, MaterialPageRoute(builder: (context) => EventScreen()));
      }
    } catch (e) {
      print('Error: $e');
      setState(() {
        _message = e.toString();
      });
    }
  }

  Widget secondaryButton() {
    String buttonText = !_isLogin ? 'Login' : 'Sign up';
    return TextButton(
      child: Text(buttonText),
      onPressed: () {
        setState(() {
          _isLogin = !_isLogin;
        });
      },
    );
  }

  Widget validationMessage() {
    return Text(
      _message ?? '',
      style: TextStyle(
          fontSize: 14, color: Colors.red, fontWeight: FontWeight.bold),
    );
  }

  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Login'),
      ),
      body: Container(
        padding: EdgeInsets.all(24),
        child: SingleChildScrollView(
          child: Form(
            child: Column(
              children: <Widget>[
                emailInput(),
                passwordInput(),
                mainButton(),
                secondaryButton(),
                validationMessage(),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
