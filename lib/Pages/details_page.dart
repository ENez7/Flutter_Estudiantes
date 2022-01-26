import 'package:flutter/material.dart';

import '../student.dart';
import '../api_services.dart';
import 'edit_student_page.dart';

// ignore: must_be_immutable
class StudentDetails extends StatefulWidget {
  Student student;
  StudentDetails(this.student);
  @override
  _StudentDetailsState createState() => _StudentDetailsState();
}

class _StudentDetailsState extends State<StudentDetails> {
  final ApiServices apiServices = ApiServices();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Detalles de entrada",
          style: TextStyle(
            color: Color(0xFF356859),
          ),
        ),
        //iconTheme: IconThemeData(color: Color(0xFF356859)),
        leading: IconButton(
          icon: Icon(
            Icons.arrow_back,
            color: Colors.black,
          ),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        backgroundColor: Color(0xFFFFFBE6),
      ),
      body: Container(
        padding: EdgeInsets.all(20.0),
        color: Color(0xFF356859),
        child: Card(
          color: Color(0xFFFFFBE6),
          child: Container(
            padding: EdgeInsets.all(10.0),
            width: 440.0,
            child: Column(
              children: [
                Container(
                  margin: EdgeInsets.fromLTRB(0, 0, 0, 10.0),
                  child: Column(
                    children: [
                      Icon(
                        Icons.person,
                        size: 50.0,
                      ),
                      Text(
                        'Last name: ',
                        style: TextStyle(
                          color: Color(0xFF356859),
                          fontSize: 20.0,
                        ),
                      ),
                      Text(
                        widget.student.lastName!,
                        style: TextStyle(
                          color: Color(0xFF356859),
                          fontSize: 25.0,
                        ),
                      )
                    ],
                  ),
                ),
                Container(
                  margin: EdgeInsets.fromLTRB(0, 0, 0, 10.0),
                  child: Column(
                    children: [
                      Text(
                        'First name: ',
                        style: TextStyle(
                          color: Color(0xFF356859),
                          fontSize: 20.0,
                        ),
                      ),
                      Text(
                        widget.student.firstName!,
                        style: TextStyle(
                          color: Color(0xFF356859),
                          fontSize: 25.0,
                        ),
                      )
                    ],
                  ),
                ),
                Container(
                  margin: EdgeInsets.fromLTRB(0, 0, 0, 10.0),
                  child: Column(
                    children: [
                      Icon(
                        Icons.card_membership,
                        size: 50.0,
                      ),
                      Text(
                        'Student ID: ',
                        style: TextStyle(
                          color: Color(0xFF356859),
                          fontSize: 20.0,
                        ),
                      ),
                      Text(
                        widget.student.studentID.toString(),
                        style: TextStyle(
                          color: Color(0xFF356859),
                          fontSize: 25.0,
                        ),
                      ),
                    ],
                  ),
                ),
                Container(
                  margin: EdgeInsets.fromLTRB(0, 0, 0, 10.0),
                  child: Column(
                    children: [
                      Icon(
                        Icons.calendar_today,
                        size: 50.0,
                      ),
                      Text(
                        'Enrollment date: ',
                        style: TextStyle(
                          color: Color(0xFF356859),
                          fontSize: 20.0,
                        ),
                      ),
                      Text(
                        widget.student.enrollmentDate.toString(),
                        style: TextStyle(
                          color: Color(0xFF356859),
                          fontSize: 25.0,
                        ),
                      ),
                    ],
                  ),
                ),
                Container(
                  margin: EdgeInsets.fromLTRB(70, 50, 0, 10.0),
                  child: Row(
                    children: [
                      ElevatedButton(
                        onPressed: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => EditStudent(widget.student),
                            ),
                          );
                        },
                        style: ButtonStyle(
                          backgroundColor:
                              MaterialStateProperty.all(Color(0xFF356859)),
                          overlayColor:
                              MaterialStateProperty.all(Color(0xFFFFFBE6)),
                        ),
                        child: Text(
                          'Edit',
                          style: TextStyle(
                            color: /*Color(0xFFFFFBE6)*/ Colors.white,
                          ),
                        ),
                      ),
                      SizedBox(
                        width: 40.0,
                      ),
                      ElevatedButton(
                        onPressed: () {
                          apiServices.deleteStudent(widget.student.studentID);
                          Navigator.pop(context);
                        },
                        style: ButtonStyle(
                          backgroundColor:
                              MaterialStateProperty.all(Color(0xFF356859)),
                          overlayColor:
                              MaterialStateProperty.all(Color(0xFFFFFBE6)),
                        ),
                        child: Text(
                          'Delete',
                          style: TextStyle(color: Color(0xFFFFFBE6)),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
