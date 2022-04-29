import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:http/http.dart';


class SignUpScreen extends StatefulWidget {
  const SignUpScreen({Key? key}) : super(key: key);

  @override
  State<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {

  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

  //Sign Up Of the data
  void login(String email, password) async{
    try{
      Response response = await post(
        Uri.parse("https://reqres.in/api/register"),
        body: {
          'email' : email,
          'password' : password,
        }
      );
      if( response.statusCode  == 200){
        var data = jsonDecode(response.body.toString());
        print(data['token']);
        print("Account Created Successfully");
      }else{
        print ("Failed");
      }
    }catch(e){
      print(e.toString());
    }
  }
//For login the data
  void reallogin(String email, password) async{
    try{
      Response response = await post(
          Uri.parse("https://reqres.in/api/login"),
          body: {
            'email' : email,
            'password' : password,
          }
      );
      if( response.statusCode  == 200){
        var data = jsonDecode(response.body.toString());
        print(data['token']);
        print("Login Successfully");
      }else{
        print ("Login Failed");
      }
    }catch(e){
      print(e.toString());
    }
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Sign Up Api"),
      ),
      body: Padding(
        padding: EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            TextFormField(
              controller: emailController,
              decoration: InputDecoration(
                hintText: "Email"
              ),
            ),
            SizedBox(
              height: 20,
            ),
            
            TextFormField(
              controller: passwordController,
              decoration: InputDecoration(
                  hintText: "Password"
              ),
            ),
            SizedBox(
              height: 20,
            ),
            GestureDetector(
              onTap: () {
                login(emailController.text.toString(), passwordController.text.toString());
              },
              child: Container(
                height: 50,
                width: 100,
                decoration: BoxDecoration(
                  color: Colors.green,
                  borderRadius: BorderRadius.circular(10)
                ),
                child: Center(

                  child: Text("Sign Up"),
                ),
              ),

            ),
            SizedBox(
              height: 20,
            ),
            GestureDetector(
              onTap: () {
                reallogin(emailController.text.toString(), passwordController.text.toString());
              },
              child: Container(
                height: 50,
                width: 100,
                decoration: BoxDecoration(
                    color: Colors.green,
                    borderRadius: BorderRadius.circular(10)
                ),
                child: Center(

                  child: Text("Login"),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
