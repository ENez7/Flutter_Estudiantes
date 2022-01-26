import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

import 'package:preparacion_parcial/main.dart';

class LoginPage extends StatefulWidget {
  LoginPage({Key? key}) : super(key: key);

  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  bool _isLoading = false;
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passController = TextEditingController();

  update(_isLoading) {
    setState(() {
      _isLoading = false;
    });
  }

  final verticalText = Padding(
    padding: const EdgeInsets.only(top: 60.0, left: 10.0),
    child: RotatedBox(
      quarterTurns: -1,
      child: Text(
        "Sign in",
        style: TextStyle(
          color: Color(0xFF356859),
          fontSize: 38.0,
          fontWeight: FontWeight.w900,
        ),
      ),
    ),
  );

  final loginText = Padding(
    padding: const EdgeInsets.only(top: 30.0, left: 10.0),
    child: Container(
      //color: Colors.green,
      height: 200,
      width: 200,
      child: Column(
        children: <Widget>[
          Container(
            height: 60,
          ),
          Center(
            child: Text(
              'Enrique Núñez 2019112540',
              style: TextStyle(
                fontSize: 24,
                color: Color(0xFF356859),
              ),
            ),
          ),
        ],
      ),
    ),
  );

  Padding emailBox() {
    return Padding(
      padding: const EdgeInsets.only(top: 50, left: 50, right: 50),
      child: Container(
        height: 60,
        width: MediaQuery.of(context).size.width,
        child: TextFormField(
          controller: emailController,
          style: TextStyle(
            color: Color(0xFF356859),
          ),
          decoration: InputDecoration(
            border: UnderlineInputBorder(),
            focusedBorder: UnderlineInputBorder(
              borderSide: BorderSide(color: Color(0xFF356859)),
            ),
            fillColor: Colors.lightBlueAccent,
            labelText: 'Email',
            labelStyle: TextStyle(
              color: Color(0xFF356859),
            ),
            icon: Icon(
              Icons.email,
              color: Color(0xFF356859),
            ),
          ),
        ),
      ),
    );
  }

  Padding passwordBox() {
    return Padding(
      padding: const EdgeInsets.only(top: 20, left: 50, right: 50),
      child: Container(
        height: 60,
        width: MediaQuery.of(context).size.width,
        child: TextFormField(
          controller: passController,
          style: TextStyle(
            color: Color(0xFF356859),
          ),
          obscureText: true,
          decoration: InputDecoration(
            border: UnderlineInputBorder(),
            focusedBorder: UnderlineInputBorder(
              borderSide: BorderSide(color: Color(0xFF356859)),
            ),
            labelText: 'Password',
            labelStyle: TextStyle(
              color: Color(0xFF356859),
            ),
            icon: Icon(
              Icons.lock,
              color: Color(0xFF356859),
            ),
          ),
        ),
      ),
    );
  }

  signIn(String email, pass) async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    Map data = {'grant_type': 'password', 'username': email, 'password': pass};
    var jsonResponse;
    var response = await http.post(
      Uri.parse("https://appserviceenrique.azurewebsites.net/token"),
      body: data,
    );
    if (response.statusCode == 200) {
      jsonResponse = json.decode(response.body);
      if (jsonResponse != null) {
        update(_isLoading);
        sharedPreferences.setString("token", jsonResponse['access_token']);
        Navigator.of(context).pushAndRemoveUntil(
          MaterialPageRoute(
            builder: (BuildContext context) => Inicio(),
          ),
          (Route<dynamic> route) => false,
        );
      }
    }
  }

  Padding button() {
    return Padding(
      padding: const EdgeInsets.only(top: 40, right: 50, left: 200),
      child: Container(
        alignment: Alignment.bottomRight,
        height: 50,
        width: MediaQuery.of(context).size.width,
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(30),
        ),
        child: ElevatedButton(
          onPressed: emailController.text == "" || passController.text == ""
              ? null
              : () {
                  update(_isLoading);
                  signIn(emailController.text, passController.text);
                },
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Text(
                'Sign in',
                style: TextStyle(
                  color: const Color(0xFF207C7E),
                  fontSize: 14,
                  fontWeight: FontWeight.w700,
                ),
              ),
              Icon(
                Icons.arrow_forward,
                color: const Color(0xFF207C7E),
              ),
            ],
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [Color(0xFFFFFBE6), Color(0xFFFFFBE6)],
          ),
        ),
        child: ListView(
          children: [
            Column(
              children: [
                Row(
                  children: [verticalText, loginText],
                ),
                emailBox(),
                passwordBox(),
                button()
              ],
            )
          ],
        ),
      ),
    );
  }
}
