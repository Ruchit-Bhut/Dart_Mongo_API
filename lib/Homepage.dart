import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

import 'Model.dart';
import 'delete.dart';
import 'edit.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);
  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  List<Jsondata> jsondata = [];
  TextEditingController titleC = TextEditingController();
  TextEditingController descriptionC = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(context,
                  MaterialPageRoute(builder: (context) => const AddData()))
              .then((value) => setState(() {}));

        },
        child: const Icon(Icons.add),
      ),
      body: FutureBuilder(
          future: getData(),
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              return ListView.builder(
                  itemCount: jsondata.length,
                  itemBuilder: (context, index) {
                    return Container(
                      color: Colors.grey,
                      padding: const EdgeInsets.symmetric(
                          vertical: 5, horizontal: 5),
                      margin: const EdgeInsets.all(15),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            'Id: ${jsondata[index].id}',
                            style: const TextStyle(fontSize: 20),
                          ),
                          Text(
                            'Title: ${jsondata[index].title}',
                            style: const TextStyle(fontSize: 20),
                          ),
                          Text(
                            'Description: ${jsondata[index].description}',
                            style: const TextStyle(fontSize: 20),
                          ),
                          Row(
                            children: [
                              IconButton(
                                  onPressed: () {
                                    Delete(jsondata[index].id);
                                    setState(() {});
                                  },
                                  icon: const Icon(Icons.delete)),
                              IconButton(
                                  onPressed: () {
                                    Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                          builder: (context) => Edit(
                                            jsondata: snapshot.data![index],
                                          ),
                                        ));
                                    // Delete(moderate[index].id);
                                    setState(() {});
                                  },
                                  icon: const Icon(Icons.edit,size: 25,)),
                            ],
                          ),
                        ],
                      ),
                    );
                  });
            } else {
              return const Center(
                child: CircularProgressIndicator(),
              );
            }
          }),
    );
  }

  Future<List<Jsondata>> getData() async {
    final response =
        await http.get(Uri.parse('http://192.168.29.37:8080/v1/notes'));
    var data = jsonDecode(response.body.toString());
    if (response.statusCode == 200) {
      final list = data as List;
      jsondata = list.map((e) => Jsondata.fromJson(e)).toList();
      return jsondata;
    } else {
      return jsondata;
    }
  }

  void Delete(String id) async {
    var url = Uri.parse('http://192.168.29.37:8080/v1/notes/$id');
    var response = await http.delete(url);
    if (response.statusCode == 200) {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(id)));
    }
  }
}
