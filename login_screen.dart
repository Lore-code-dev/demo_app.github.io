import 'package:flutter/material.dart';
// ignore: unused_import
import 'package:prueba_demo/main.dart';

class LoginScreen extends StatefulWidget {
  // ignore: use_super_parameters
  const LoginScreen({Key? key}) : super(key: key);

  @override
  // ignore: library_private_types_in_public_api
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final String _correctUsername = "emma";
  final String _correctEmail = "emma@gmail.com";
  final String _correctPassword = "1234";

  // agragando las validaciones

  final _usernameController = TextEditingController();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();

  void _login() {
    String nombre = _usernameController.text.trim();
    String email = _emailController.text.trim();
    String password = _passwordController.text.trim();

    if (nombre == _correctUsername &&
        email == _correctEmail &&
        password == _correctPassword) {
      showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: const Text("Login Successful"),
            content: const Text("Welcome back!"),
            actions: [
              TextButton(
                child: const Text("OK"),
                onPressed: () {
                  Navigator.of(context).pop();
                },
              ),
            ],
          );
        },
      );
      // colocar en el login el llamado del home aqui
      Navigator.pushReplacementNamed(context, '/home'); // importante
    } else {
      showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: const Text("Login Failed"),
            content: const Text("Incorrect username, email, or password"),
            actions: [
              TextButton(
                child: const Text("Try Again"),
                onPressed: () {
                  Navigator.of(context).pop();
                },
              ),
            ],
          );
        },
      );
    }
  }

  @override
  void dispose() {
    _usernameController.dispose();
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: const Color.fromARGB(255, 253, 254, 255),
        body: ListView(
          padding: const EdgeInsets.symmetric(horizontal: 30.0, vertical: 90.0),
          children: <Widget>[
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const CircleAvatar(
                  radius: 80.0,
                  backgroundColor: Colors.grey,
                  backgroundImage: AssetImage('images/LogoGowPlay.png'),
                ),
                const Text(
                  'Welcome Back!',
                  style: TextStyle(fontFamily: 'Roboto-Black', fontSize: 30.0),
                ),
                const Text(
                  "Let's Get Start",
                  style: TextStyle(fontFamily: 'Roboto-Bold', fontSize: 20.0),
                ),
                const SizedBox(
                  width: 160.0,
                  height: 15.0,
                  child: Divider(
                    color: Color.fromARGB(255, 249, 250, 251),
                  ),
                ),
                TextField(
                  controller: _usernameController,
                  enableInteractiveSelection: false,
                  autofocus: true,
                  textCapitalization: TextCapitalization.none,
                  decoration: InputDecoration(
                      hintText: 'User-Name',
                      labelText: 'user name',
                      suffixIcon: const Icon(Icons.verified_user),
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(20.0))),
                  onChanged: (valor) {
                    setState(() {
                      //_nombre = valor;
                      // print('El nombre es $_nombre');
                      _usernameController.text = valor;
                    });
                  },
                ),
                const Divider(
                  height: 25.0,
                ),
                TextField(
                  controller: _emailController,
                  decoration: InputDecoration(
                      hintText: 'Email',
                      labelText: 'Email',
                      suffixIcon: const Icon(Icons.alternate_email),
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(20.0))),
                  onChanged: (valor) {
                    setState(() {
                      // _email = valor;
                      //  print('El email es $_email');
                      _emailController.text = valor;
                    });
                  },
                ),
                const Divider(
                  height: 25.0,
                ),
                TextField(
                  controller: _passwordController,
                  enableInteractiveSelection: false,
                  obscureText: true,
                  decoration: InputDecoration(
                      hintText: 'Password',
                      labelText: 'Password',
                      suffixIcon: const Icon(Icons.lock_outline),
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(20.0))),
                  onChanged: (valor) {
                    setState(() {
                      //_password = valor;
                      //  print('El Password es $_password');
                      _passwordController.text = valor;
                    });
                  },
                ),
                const Divider(
                  height: 25.0,
                ),
                SizedBox(
                  width: double.infinity,
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: const Color.fromARGB(255, 119, 124, 231),
                    ),
                    onPressed: _login,
                    //  print('diste click');
                    // },
                    child: const Text(
                      'Log In',
                      style: TextStyle(
                          color: Color.fromRGBO(252, 252, 252, 1),
                          fontSize: 30.0,
                          fontFamily: 'Roboto-Bold'),
                    ),
                  ),
                ),
                const SizedBox(height: 25.0),
                GestureDetector(
                  onTap: () {
                    // ACCION DE "CREAR CUENTA"
                  },
                  child: const Text(
                    'New User? Create Account',
                    style: TextStyle(
                      color: Color.fromARGB(255, 111, 7, 7),
                    ),
                  ),
                ),
              ],
            )
          ],
        ));
  }
}
