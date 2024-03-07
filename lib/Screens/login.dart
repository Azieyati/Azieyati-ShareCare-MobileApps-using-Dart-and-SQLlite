import 'package:flutter/material.dart';
import 'package:sharecareproject2/Screens/signup.dart';
import '../JsonModels/user_authentication.dart';
import '../JsonModels/users.dart';
import '../sqflite-database/sqflite.dart';
import 'homepage.dart';

class Login extends StatefulWidget {
  // Key constructors
  const Login({super.key});

  @override
  State<StatefulWidget> createState() => _Login();
}

class _Login extends State<Login> {

  // Size between widget
  SizedBox spaceInBetween = const SizedBox(height: 15);

  // Create global key for form
  final _formfield = GlobalKey<FormState>();

  // The variable as a controller that control the text
  final usernameController = TextEditingController();
  final passController = TextEditingController();

  // The variable used for hide and show password
  bool isVisible = false;

  //Declare database
  final db = DatabaseFile();
  bool islogin = false;


  // Validate the data from database
  // If the user enter the correct username and password
  // Then it will navigate to the Home screen
  // Otherwise it will display the error message
  validatelogin() async {
    UsersModel? loggedInUser = await
    db.loginUser(
        UsersModel(

            username: usernameController.text,
            password: passController.text,
            fullname: '',
            email: '',
            phonenumber: ''));

    if (loggedInUser != null) {
      // Login successful,
      // set the current user in AuthManager
      AuthManager.login(loggedInUser);

      // Display in the terminal
      print("Login successful for user: ${loggedInUser.username}");

      // If the username and password is correct
      Navigator.pushReplacement(context,
          MaterialPageRoute(builder:
              (context) => HomePage(),
          ));
    } else {
      // Login failed, handle accordingly
      print("Login failed. Invalid credentials.");
      setState(() {
        islogin = true;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(

      body: Center(
        child:

        SingleChildScrollView(

          padding: const EdgeInsets.symmetric(
              horizontal: 20,
              vertical: 60
          ),

          child:
          Form(
            key: _formfield,
            child:
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Center(
                  child:
                  Column(
                    children: [
                      const Text('LOGIN',
                        style: TextStyle(
                          fontSize: 40,
                        ),
                      ),
                      spaceInBetween,

                      Image.asset(
                        "images/loginicon.png",

                        height: 80,
                        width: 80,
                      ),

                      spaceInBetween,

                      // Username Text field
                      Container(
                        margin: const EdgeInsets.symmetric(
                            horizontal: 10,
                            vertical: 6),

                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(8),
                          color: Colors.grey.withOpacity(.2),
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

                        margin: const EdgeInsets.symmetric(
                            horizontal: 10,
                            vertical: 6),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(8),
                          color: Colors.grey.withOpacity(.2),
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
                              icon: const Icon(Icons.lock),
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
                            .width * .9,

                        decoration: BoxDecoration(
                          color: Colors.blue,
                          borderRadius: BorderRadius
                              .circular(10),
                        ),
                        child:
                        TextButton(
                          onPressed: () {
                            // Login validation
                            if (_formfield.currentState!
                                .validate()) {
                              // Login method
                              validatelogin();
                            }
                          },
                          child: const Text(
                            'LOGIN',

                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      ),

                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          const Text("Don't have an account?"),
                          TextButton(onPressed: () {
                            //   Navigate to sign up page
                            Navigator.push(context,
                              MaterialPageRoute(builder:
                                  (context) => SignUp()),
                            );
                          },
                              child: const Text(
                                  'SIGN UP'
                              ))
                        ],
                      ),

                      // This message is disable and
                      // show when username and password incorrect
                      islogin ? const Text(
                        'Username or password is incorrect!',

                        style: TextStyle(
                            color: Colors.red,
                            fontWeight: FontWeight.bold),
                      ) : const SizedBox(),
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