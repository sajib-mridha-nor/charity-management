import 'package:flutter/material.dart';

import '../utils/network/network_exceptions.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class TestPage extends StatelessWidget {
  const TestPage({super.key});

  httpRequest() async {
    // debugPrint("$res");
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Column(
        children: [
          Center(
            child: OutlinedButton(
                onPressed: (() async {
                  httpRequest();
                  print("object");

                  // httpRequest();

                  // var postUri = Uri.parse(
                  //     "https://demo.webpointbd.com/api/mobile-attendance-store");
                  // Map<String, dynamic> map = {
                  //   "status": true,
                  //   "date": "2023-02-06",
                  //   "academic_class_id": 5,
                  //   "attendances": [
                  //     {
                  //       "student_academic_id": 123,
                  //       "shift_id": 2,
                  //       "attendance_status_id": 1
                  //     },
                  //     {
                  //       "student_academic_id": 234,
                  //       "shift_id": 1,
                  //       "attendance_status_id": 1
                  //     }
                  //   ]
                  // };
                  // var finalmap = jsonEncode(map);

                  try {
                    // var res = await http.post(
                    //     Uri.parse(
                    //         "https://prp.parliament.gov.bd/api/authentication/external?action=token"),
                    //     body: {
                    //       'username': 'ezzetech',
                    //       'password': 'Fty#3a',
                    //     },
                    //     headers: {
                    //       // 'Content-Type': 'application/json',
                    //       'Accept': 'application/json',
                    //       // 'authorization':
                    //       //     'Bearer eyJhbGciOiJIUzUxMiJ9.eyJzdWIiOiJlenpldGVjaCIsImlhdCI6MTY3ODY4NzgzOSwiZXhwIjoxNjc4Njg5NjM5fQ.O06L99nk5aOHwFULdHmriedNq33IOq5ACbncq0etOj4UAxOYMcbOZ9BriobJOVxtqjWnKPJN7qzGYiuwnI22DA',
                    //     });

                    var request = await http.get(
                        Uri.parse(
                            "https://prp.parliament.gov.bd/api/secure/external?action=division"),
                        headers: {
                          // 'Content-Type': 'application/json',
                          // 'Accept': 'application/json',
                          'authorization':
                              'Bearer eyJhbGciOiJIUzUxMiJ9.eyJzdWIiOiJlenpldGVjaCIsImlhdCI6MTY3ODY4NzgzOSwiZXhwIjoxNjc4Njg5NjM5fQ.O06L99nk5aOHwFULdHmriedNq33IOq5ACbncq0etOj4UAxOYMcbOZ9BriobJOVxtqjWnKPJN7qzGYiuwnI22DA'
                        });
                    print("$request");
                  } catch (e) {
                    print(e);
                  }
                }),
                child: Text("Send")),
          )
        ],
      ),
    );
  }
}
