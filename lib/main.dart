import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'login.dart';
import 'student_list.dart';
import 'add_student.dart';

void main() => runApp(Practica());

class Practica extends StatelessWidget {
  const Practica({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: "Practico Parcial 2",
      debugShowCheckedModeBanner: false, // QUITAR ETIQUETA DEBUG
      home: Inicio(),
    );
  }
}

class Inicio extends StatefulWidget {
  Inicio({Key key}) : super(key: key);

  @override
  _InicioState createState() => _InicioState();
}

class _InicioState extends State<Inicio> {
  SharedPreferences sharedPreferences;
  @override
  void initState() {
    super.initState();
    checkLoginStatus();
  }

  checkLoginStatus() async {
    sharedPreferences = await SharedPreferences.getInstance();
    if (sharedPreferences.getString("token") == null) {
      Navigator.of(context).pushAndRemoveUntil(
        MaterialPageRoute(builder: (BuildContext context) => LoginPage()),
        (Route<dynamic> route) => false,
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Practico Parcial 2",
          style: TextStyle(color: Color(0xFF356859)),
        ),
        backgroundColor: Color(0xFFFFFBE6),
        actions: [
          FlatButton(
            onPressed: () {
              sharedPreferences.clear();
              // ignore: deprecated_member_use
              sharedPreferences.commit();
              Navigator.of(context).pushAndRemoveUntil(
                  MaterialPageRoute(
                      builder: (BuildContext context) => LoginPage()),
                  (Route<dynamic> route) => false);
            },
            child: Text("Log Out", style: TextStyle(color: Color(0xFF356859))),
          )
        ],
      ),
      body: Center(
        child: StudentsListView(),
      ),
      floatingActionButton: FloatingActionButton.extended(
        backgroundColor: Color(0xFF356859),
        tooltip: "Add student",
        splashColor: Color(0xFFFFFBE6),
        label: Text(
          "Add",
          style: TextStyle(
            color: Color(0xFFFFFBE6),
          ),
        ),
        icon: Icon(
          Icons.person_add,
          color: Color(0xFFFFFBE6),
        ),
        onPressed: () {
          // DIRIGIR A POST STUDENT
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => AddStudent()),
          );
        },
        shape:
            RoundedRectangleBorder(borderRadius: BorderRadius.circular(25.0)),
      ),
    );
  }
}
