import 'dart:core';
import 'package:flutter/material.dart';

import '../student.dart';
import 'package:preparacion_parcial/api_services.dart';

class AddStudent extends StatelessWidget {
  final TextEditingController firstName = TextEditingController();
  final TextEditingController lastName = TextEditingController();
  final ApiServices apiServices = ApiServices();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Añadir entrada",
          style: TextStyle(color: Color(0xFF356859)),
        ),
        backgroundColor: Color(0xFFFFFBE6),
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.pop(context);
          },
          color: Color(0xFF356859),
        ),
      ),
      body: Container(
        color: Color(0xFF356859),
        child: ListView(
          children: [
            Center(
              child: Column(
                children: [
                  Padding(padding: EdgeInsets.fromLTRB(0, 20.0, 0, 0)),
                  Icon(
                    Icons.person,
                    color: Color(0xFFFFFBE6),
                    size: 50.0,
                  ),
                  Container(
                    margin: EdgeInsets.fromLTRB(0, 30.0, 0, 0),
                    padding:
                        EdgeInsets.symmetric(horizontal: 13.5, vertical: 5),
                    width: 200,
                    height: 30,
                    decoration: BoxDecoration(
                      color: Color(0xFFFFFBE6),
                      boxShadow: [
                        BoxShadow(color: Colors.black.withOpacity(1)),
                      ],
                    ),
                    child: Text(
                      "Información personal",
                      style: TextStyle(
                        fontSize: 18.0,
                        fontWeight: FontWeight.w500,
                        color: Color(0xFF356859),
                      ),
                    ),
                  ),
                  Container(
                    margin: EdgeInsets.fromLTRB(20, 30, 20, 0),
                    child: Column(
                      children: [
                        Row(
                          children: [
                            Icon(
                              Icons.navigate_next_rounded,
                              color: Color(0xFFFFFBE6),
                              size: 50.0,
                            ),
                            Text(
                              "Nombre",
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 20,
                                color: Color(0xFFFFFBE6),
                              ),
                            ),
                          ],
                        ),
                        Container(
                          margin: EdgeInsets.symmetric(
                              horizontal: 20, vertical: 20),
                          width: MediaQuery.of(context).size.width,
                          child: TextFormField(
                            controller: firstName,
                            decoration: InputDecoration(
                              labelText: "Introduce el nombre",
                              labelStyle: TextStyle(
                                color: Color(0xFFFFFBE6),
                              ),
                            ),
                          ),
                        ),
                        Row(
                          children: [
                            Icon(
                              Icons.navigate_next_rounded,
                              size: 50.0,
                              color: Color(0xFFFFFBE6),
                            ),
                            Text(
                              "Apellido",
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 20,
                                color: Color(0xFFFFFBE6),
                              ),
                            ),
                          ],
                        ),
                        Container(
                          margin: EdgeInsets.symmetric(
                              horizontal: 20, vertical: 20),
                          width: MediaQuery.of(context).size.width,
                          child: TextFormField(
                            controller: lastName,
                            decoration: InputDecoration(
                              labelText: "Introduce el apellido",
                              labelStyle: TextStyle(
                                color: Color(0xFFFFFBE6),
                              ),
                              border: UnderlineInputBorder(),
                              focusedBorder: UnderlineInputBorder(
                                borderSide: BorderSide(
                                  color: Color(0xFFFFFBE6),
                                ),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            Center(
              child: TextButton(
                onPressed: () {
                  Student newStudent = Student.newStudent(
                    50,
                    lastName.text,
                    firstName.text,
                    DateTime.now(),
                  );
                  apiServices.postStudent(newStudent);
                  Navigator.pop(context);
                },
                style: ButtonStyle(
                  backgroundColor: MaterialStateProperty.all(Color(0xFF356859)),
                  overlayColor: MaterialStateProperty.all(Color(0xFF356859)),
                ),
                // color: Color(0xFFFFFBE6),
                // splashColor: Color(0xFF356859),
                child: Text(
                  "Añadir estudiante",
                  style: TextStyle(
                    color: Color(0xFF356859),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
