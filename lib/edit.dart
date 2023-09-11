import 'dart:convert';

import 'package:api1/Model.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class Edit extends StatefulWidget {
  Jsondata jsondata;
  Edit({super.key, required this.jsondata});

  @override
  State<Edit> createState() => _EditState();
}

class _EditState extends State<Edit> {
  final _formKey = GlobalKey<FormState>();
  late TextEditingController titleC = TextEditingController();
  late TextEditingController descriptionC = TextEditingController();

  void editData() async {
    final response = await http.patch(
        Uri.parse("http://192.168.29.37:8080/v1/notes/${widget.jsondata.id}"),
        body: jsonEncode(<String, dynamic>{
          'title': titleC.text,
          'description': descriptionC.text
        }));
    if (response.statusCode == 200) {
      print('Data added ');
      print(response.body);
    } else {
      print('Data not added');
    }
  }

  @override
  void initState() {
    titleC.text = widget.jsondata.title!;
    descriptionC.text = widget.jsondata.description!;
    print(widget.jsondata.toJson());

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        elevation: 0.0,
        title: const Text(
          'EDIT DATA',
          style: TextStyle(color: Colors.white),
        ),
        backgroundColor: Colors.blue,
      ),
      body: SingleChildScrollView(
        child: Form(
          key: _formKey,
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
                    onPressed: () async {
                      setState(() {
                        if (_formKey.currentState!.validate()) {
                          Navigator.pop(context);
                          editData();
                        }
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
