import 'dart:async';
import 'dart:convert';
import 'package:preparacion_parcial/student.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;

class ApiServices {
  final String url = "https://appserviceenrique.azurewebsites.net/api/Students";
  /*
    <<< GET FUNCTION >>>
  */
  Future<List<Student>> getStudents() async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    String token = sharedPreferences.getString('token'); // OBTENER TOKEN

    final response = await http.get(
      url,
      headers: {
        'Content-Type': 'application/json',
        'Accept': 'application/json',
        'Authorization': 'Bearer $token',
      },
    );
    if (response.statusCode == 200) {
      List jsonResponse = json.decode(response.body);
      return jsonResponse.map((job) => new Student.fromJson(job)).toList();
    } else {
      throw Exception('Failed to load students from API');
    }
  }

  Future<Student> getStudent(int id) async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    String token = sharedPreferences.getString('token');

    final response = await http.get(
      '$url/$id',
      headers: {
        'Content-Type': 'application/json; charset=UTF-8',
        'Accept': 'application/json',
        'Authorization': 'Bearer $token',
      },
    );
    //print("Code: " + response.statusCode.toString());
    if (response.statusCode == 200)
      return Student.fromJson(json.decode(response.body));
    else
      throw Exception('Failed to load student from API');
  }

  /*
    <<< POST FUNCTION >>>
  */
  Future<Student> postStudent(Student student) async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    String token = sharedPreferences.getString('token');
    Map data = {
      'StudentID': student.studentID,
      'LastName': student.lastName,
      'FirstName': student.firstName,
      'EnrollmentDate': DateTime.now().toIso8601String() + '+00:00'
      //                Model -> "2010-09-17T16:55:57.198941+00:00"
    };

    final response = await http.post(
      url,
      headers: {
        'Content-Type': 'application/json',
        //'Accept': 'application/json',
        'Authorization': 'Bearer $token',
      },
      body: jsonEncode(data),
    );

    // print("Code: ${response.statusCode}");

    if (response.statusCode == 201)
      return Student.fromJson(json.decode(response.body));
    else
      throw Exception('Failed to post student');
  }

  /*
    <<< PUT FUNCTION >>>
  */
  void putStudent(int id, Student student) async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    String token = sharedPreferences.getString('token');
    Map data = {
      'StudentID': id,
      'LastName': student.lastName,
      'FirstName': student.firstName,
      'EnrollmentDate': DateTime.now().toIso8601String() + '+00:00'
      //                Model -> "2010-09-17T16:55:57.198941+00:00"
    };

    final response = await http.put(
      '$url/$id',
      headers: {
        'Content-Type': 'application/json',
        //'Accept': 'application/json',
        'Authorization': 'Bearer $token',
      },
      body: jsonEncode(data),
    );
    if (response.statusCode != 204)
      throw Exception("Failed to update a student");
  }

  /*
    <<< DELETE FUNCTION >>>
  */
  Future<void> deleteStudent(int id) async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    String token = sharedPreferences.getString('token');

    final response = await http.delete(
      '$url/$id',
      headers: {
        'Authorization': 'Bearer $token',
      },
    );

    if (response.statusCode == 200)
      return Student.fromJson(json.decode(response.body));
    else
      throw Exception("Failed to delete the student");
  }
}
