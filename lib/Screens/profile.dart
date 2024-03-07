import 'package:flutter/material.dart';
import 'package:sharecareproject2/Screens/login.dart';
import '../JsonModels/user_authentication.dart';
import '../JsonModels/users.dart';
import '../sqflite-database/sqflite.dart';
import 'history_donation.dart';

class Profile extends StatefulWidget {
  Profile({Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() => _Profile();
}

class _Profile extends State<Profile> {
  // The variable used for hide and show password
  bool isVisible = false;

  //Declare database
  final db = DatabaseFile();
  bool islogin = false;

  @override
  Widget build(BuildContext context) {
    UsersModel? loggedInUser = AuthManager.currentUser;
    SizedBox spaceInBetween = SizedBox(height: 15);

    return Scaffold(
      appBar: AppBar(
        title: const Text('PROFILE',),
        titleTextStyle: TextStyle(
            color: Colors.black,
            fontWeight: FontWeight.bold,
            fontSize: 20,
        ),
        backgroundColor: Colors.white,
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              padding:
              EdgeInsets.only(
                  top: 20,
                  left: 10,
                  right: 10),
              

              height: 300,
              child: Card(
                elevation: 3,
                shape: RoundedRectangleBorder(
                  side: BorderSide(),
                  borderRadius: const BorderRadius
                      .all(Radius
                      .circular(12)),


                ),
                child: Column(
                  children: [

                    ListTile(
                      leading: Icon(
                          Icons.ad_units),

                      title: Padding(
                        padding: const EdgeInsets.only(top: 8.0),
                        child: Text(
                          'Profile Information:',

                          style: TextStyle(
                              fontWeight: FontWeight.bold),

                        ),
                      ),
                      subtitle: Column(

                        crossAxisAlignment: CrossAxisAlignment.start,

                        children: [

                          spaceInBetween,
                          Text(
                            "Name:    "
                                "${loggedInUser?.fullname}",
                            style: TextStyle(
                                fontWeight:
                                FontWeight.bold,
                                fontSize: 15
                            ),
                          ),

                          spaceInBetween,

                          Text(
                            "Phone Number:  "
                                "${loggedInUser?.phonenumber}",
                            style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 15
                            ),
                          ),

                          spaceInBetween,
                          Text(
                            "Email:  "
                                "${loggedInUser?.email}",

                            style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 15
                            ),
                          ),

                          spaceInBetween,

                          Text(
                            "Username:  "
                                "${loggedInUser?.username}",

                            style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 15
                            ),
                          ),

                          spaceInBetween,
                          spaceInBetween,

                          Container(
                            height: 45,
                            width: 200,
                            margin: EdgeInsets.only(
                                left: 190
                            ),

                            decoration: BoxDecoration(

                              color: Colors.blue,
                              borderRadius: BorderRadius
                                  .circular(10),

                            ),
                            child: TextButton(
                              onPressed: () {
                                // Logout Button
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder:
                                          (context) => Login()
                                  ),
                                );
                              },

                              child: Text(
                                'LOGOUT',

                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 16,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),

            Container(

              padding: EdgeInsets.only(
                  top: 20,
                  left: 10,
                  right: 10
              ),

              height: 110,

              child: Card(
                elevation: 1,
                shape: RoundedRectangleBorder(
                  side: BorderSide(),
                  borderRadius: const BorderRadius
                      .all(Radius
                      .circular(12)),
                ),

                child: Column(

                  children: [

                    // View history button
                    Padding(
                      padding: EdgeInsets
                          .all(16.0),

                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,

                        children: [

                          Text(
                            'History Donation',

                            style: TextStyle(
                              fontSize: 20,
                            ),
                          ),

                          ElevatedButton(
                            onPressed: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder:
                                        (context) => HistoryDonation()
                                ),
                              );
                              // Button onPressed logic
                            },
                            child: const Text(
                              'View',
                              style: TextStyle(
                                fontSize: 20,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
