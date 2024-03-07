import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../JsonModels/users.dart';
import '../sqflite-database/sqflite.dart';
import 'login.dart';

class SignUp extends StatefulWidget {

  @override
  State<StatefulWidget> createState() => _SignUp();
}

class _SignUp extends State<SignUp> {

  // Size between widget
  SizedBox spaceInBetween = SizedBox(height: 15);

  // The variable used for hide and show password
  bool isVisible = false;

  // Create global key for form
  final _formfield = GlobalKey<FormState>();

  // The variable as a controller that control the text
  final fullnameController = TextEditingController();
  final emailController = TextEditingController();
  final phonenumController = TextEditingController();
  final usernameController = TextEditingController();
  final passController = TextEditingController();


  // Declare database
  final db = DatabaseFile();


  @override
  Widget build(BuildContext context) {
    return Scaffold(

      appBar: AppBar(
        backgroundColor: Colors.white,

        leading: BackButton(
            color: Colors.black),
      ),
      body:

      Center(

        child:
        SingleChildScrollView(

          padding: EdgeInsets.symmetric(
              horizontal: 20,
              vertical: 60
          ),

          child:

          Form(
            key: _formfield,
            child:
            Column(
              mainAxisAlignment: MainAxisAlignment.center,

              children: <Widget>[

                // Display the image logo
                Image.asset(
                  "images/loginicon.png",
                  height: 80,
                  width: 80,
                ),
                spaceInBetween,

                // Display the text
                Text('Registration',
                  style: TextStyle(
                    fontSize: 30,
                  ),
                ),


                SizedBox(height: 30),

                Container(

                  margin: EdgeInsets.symmetric(
                      horizontal: 10,
                      vertical: 8),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(8),
                    color: Colors.blue.withOpacity(.2),
                  ),


                  child: TextFormField(
                    controller: fullnameController,
                    validator: (value) {
                      if (value!.isEmpty) {
                        return "Full name is required";
                      }
                      return null;
                    },
                    decoration: const InputDecoration(
                      icon: Icon(Icons.person),
                      border: InputBorder.none,
                      hintText: 'Full Name',

                    ),
                  ),
                ),

                // Email Text field
                Container(

                  margin: EdgeInsets.symmetric(
                      horizontal: 10,
                      vertical: 8),

                  decoration: BoxDecoration(
                    borderRadius: BorderRadius
                        .circular(8),

                    color: Colors.blue.withOpacity(.2),
                  ),


                  // Email TextField
                  child: TextFormField(

                    controller: emailController,
                    validator: (value) {
                      if (value!.isEmpty) {
                        return "Email is required";
                      }
                      return null;
                    },

                    decoration: const InputDecoration(
                      icon: Icon(
                          Icons.lock
                      ),
                      border: InputBorder.none,
                      hintText: 'Email',

                    ),
                  ),
                ),

                // Phone Number text field
                Container(

                  margin: EdgeInsets.symmetric(
                      horizontal: 10,
                      vertical: 8),

                  decoration: BoxDecoration(
                    borderRadius: BorderRadius
                        .circular(8),

                    color: Colors.blue.withOpacity(.2),
                  ),


                  child: TextFormField(
                    controller: phonenumController,
                    validator: (value) {
                      if (value!.isEmpty) {
                        return
                          "Phone number is required";
                      }
                      else if (value.length < 6) {
                        return
                          "Please enter password more than 6 character";
                      }
                      return null;
                    },
                    decoration: const InputDecoration(
                      icon: Icon(
                          Icons.phone
                      ),

                      border: InputBorder.none,
                      hintText: 'Phone Number',
                    ),
                  ),
                ),

                // username TextField
                Container(

                  margin: EdgeInsets.symmetric(
                      horizontal: 10,
                      vertical: 8),

                  decoration: BoxDecoration(
                    borderRadius: BorderRadius
                        .circular(8),

                    color: Colors.blue.withOpacity(.2),
                  ),

                  child: TextFormField(
                    controller: usernameController,
                    validator: (value) {
                      if (value!.isEmpty) {
                        return "Username is required";
                      }
                      return null;
                    },
                    decoration: const InputDecoration(
                      icon: Icon(Icons.person),
                      border: InputBorder.none,
                      hintText: 'Username',

                    ),
                  ),
                ),

                // Password TextField
                Container(

                  margin: EdgeInsets.symmetric(
                      horizontal: 10,
                      vertical: 8),

                  decoration: BoxDecoration(
                    borderRadius: BorderRadius
                        .circular(8),

                    color: Colors.blue.withOpacity(.2),
                  ),

                  child: TextFormField(
                    controller: passController,
                    validator: (value) {
                      if (value!.isEmpty) {
                        return "Password is required";
                      }
                      return null;
                    },
                    obscureText: !isVisible,
                    decoration: InputDecoration(
                        icon: Icon(Icons.lock),
                        border: InputBorder.none,
                        hintText: 'Password',
                        suffixIcon: IconButton(
                            onPressed: () {
                              setState(() {
                                isVisible = !isVisible;
                              });
                            },
                            icon: Icon(isVisible
                                ? Icons.visibility
                                : Icons.visibility_off)
                        )
                    ),
                  ),
                ),

                spaceInBetween,

                Container(
                  height: 55,
                  width: MediaQuery
                      .of(context)
                      .size
                      .width * .5,

                  decoration: BoxDecoration(
                    color: Colors.blue,
                    borderRadius: BorderRadius
                        .circular(10),
                  ),
                  margin: EdgeInsets.only(
                    left: 130,
                  ),

                  child:
                  TextButton(
                    onPressed: () {
                      // signup validation
                      if (_formfield.currentState!.validate()) {
                        // signup method
                        final db = DatabaseFile();

                        db.signup(UsersModel(
                          fullname: fullnameController.text,
                          phonenumber: phonenumController.text,
                          email: emailController.text,
                          username: usernameController.text,
                          password: passController.text,))
                            .whenComplete(() =>
                            Navigator.push(context,
                              MaterialPageRoute(builder:
                                  (context) => Login()
                              ),
                            ),
                        );
                      }
                    },
                    child: Text(
                      'SIGN UP',

                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
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