import 'dart:convert';

import 'package:api_learn/complex_model.dart';
import 'package:flutter/material.dart';
 import 'package:http/http.dart'as http;

 class CustomModel extends StatefulWidget {
   const CustomModel({Key? key}) : super(key: key);

   @override
   State<CustomModel> createState() => _CustomModelState();
 }

 class _CustomModelState extends State<CustomModel> {
   List<Photos> photosList = [];

   Future<List<Photos>> getPhotos()async{
     final response = await http.get(Uri.parse('https://jsonplaceholder.typicode.com/photos'));
     var data = jsonDecode(response.body.toString());
     
     if(response.statusCode == 200){
       for(Map i in data){
         Photos photos = Photos(title: i['title'], url: i['url'], id: i['id']);
         photosList.add(photos);
       }
       return photosList;
     }else {
       return photosList;
     }
   }

   @override
   Widget build(BuildContext context) {
     return Scaffold(
       floatingActionButton: FloatingActionButton.extended(
         label: Text("Move To Complex Json"),
         onPressed: () {
           Navigator.push(context, MaterialPageRoute(builder: (context) => ComplexModel()));
         },
         backgroundColor: Colors.green,

         icon: const Icon(Icons.navigation),
       ),
       appBar: AppBar(

         centerTitle: true,
         title: Text("List with Custom Model"),
       ),
       body: Column(
         children: [
           Expanded(
             child: FutureBuilder(
               future: getPhotos(),
                 builder: (context,AsyncSnapshot<List<Photos>> snapshot) {
                   return ListView.builder(
                     itemCount: photosList.length,
                       itemBuilder: (context, index){
                     return ListTile(
                       leading: CircleAvatar(
                         backgroundImage: NetworkImage(snapshot.data![index].url.toString()),
                       ),
                     subtitle:  Text(snapshot.data![index].title.toString()),
                     title: Text('Notes id: '+ snapshot.data![index].id.toString()),
                     );
     });
                 }),
           )
         ],
       ),
     );
   }
 }

 //Creating own model using api end points

 class Photos{
   String title,url;
   int id;

   Photos({required this.title, required this.url, required this.id});
 }
