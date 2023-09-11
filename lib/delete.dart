import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class AddData extends StatefulWidget {
  const AddData({Key? key}) : super(key: key);

  @override
  State<AddData> createState() => _AddDataState();
}

class _AddDataState extends State<AddData> {
  final _formkey = GlobalKey<FormState>();
  String title = "";
  String description = "";
  TextEditingController titleC = TextEditingController();
  TextEditingController descriptionC = TextEditingController();

  void addData() async {
    final response = await http.post(
        Uri.parse("http://192.168.29.37:8080/v1/notes"),
        body: jsonEncode(
            {'title': titleC.text, 'description': descriptionC.text}));
    if (response.statusCode == 201) {
      print('Data added');
      print(response.body);
    } else {
      print('Data not added');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        elevation: 0.0,
        title: const Text(
          'ADD DATA',
          style: TextStyle(color: Colors.white),
        ),
        backgroundColor: Colors.blue,
      ),
      body: SingleChildScrollView(
        child: Form(
          key: _formkey,
          child: Container(
            padding: const EdgeInsets.fromLTRB(35, 35, 35, 0),
            child: Column(
              children: [
                TextFormField(
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Enter title';
                    } else {
                      return null;
                    }
                  },
                  controller: titleC,
                  decoration: InputDecoration(
                      labelText: 'Title',
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                      )),
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 17),
                  child: TextFormField(
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Enter description';
                      } else {
                        return null;
                      }
                    },
                    controller: descriptionC,
                    decoration: InputDecoration(
                        labelText: 'Description',
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10),
                        )),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 17),
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      maximumSize: const Size(100, 60),
                      textStyle: const TextStyle(fontSize: 20),
                    ),
                    child: const Text('Submit'),
                    onPressed: () {
                      setState(() {
                        title = titleC.text;
                        description = descriptionC.text;
                        Navigator.pop(context);
                        addData();
                      });
                    },
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
