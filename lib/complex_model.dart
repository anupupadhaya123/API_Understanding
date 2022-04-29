import 'dart:convert';

import 'package:api_learn/Models/UserModel.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class ComplexModel extends StatefulWidget {
  const ComplexModel({Key? key}) : super(key: key);

  @override
  State<ComplexModel> createState() => _ComplexModelState();
}

class _ComplexModelState extends State<ComplexModel> {

  List<UserModel> userList = [];

  Future<List<UserModel>> getUserApi()async{
    final response = await http.get(Uri.parse("https://jsonplaceholder.typicode.com/users"));
    var data = jsonDecode(response.body.toString());
    if(response.statusCode ==200){

      for(Map i in data){
        // print(i['name']);
        userList.add(UserModel.fromJson(i));
      }
      return userList;
    }else{
      return userList;

    }

  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text("Complex Model Fetching in List"),
      ),
      body: Column(
        children: [
          Expanded(child: FutureBuilder(
            future: getUserApi(),
            builder: (context,AsyncSnapshot<List<UserModel>> snapshot){
              if(!snapshot.hasData){
                return CircularProgressIndicator();
              }else{
                return ListView.builder(
                    itemCount: userList.length,
                    itemBuilder: (context, index){
                      return Card(
                        child: Padding(
                          padding: EdgeInsets.all(8),
                          child: Column(
                            children: [
                              ReusableRow(title: 'Name', value: snapshot.data![index].name.toString()),
                              ReusableRow(title: 'Username', value: snapshot.data![index].username.toString()),
                              ReusableRow(title: 'Email', value: snapshot.data![index].email.toString()),
                              ReusableRow(title: 'Address',
                                  value: snapshot.data![index].address!.city.toString() + " "+
                                      snapshot.data![index].address!.geo!.lat.toString()
                              ),
                            ],
                          ),
                        ),
                      );
                    });
              }

            },
          ))
        ],
      ),

    );
  }
}

class ReusableRow extends StatelessWidget {
  String title,value ;
   ReusableRow({Key? key, required this.title, required this.value}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return  Padding(
      padding: EdgeInsets.all(8),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(title),
          Text(value),
        ],
      ),
    );
  }
}
