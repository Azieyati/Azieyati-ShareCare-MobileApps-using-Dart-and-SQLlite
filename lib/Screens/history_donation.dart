import 'package:flutter/material.dart';
import '../JsonModels/fooddonate.dart';
import '../JsonModels/user_authentication.dart';
import '../JsonModels/users.dart';
import '../sqflite-database/sqflite.dart';
import 'details_donation.dart';

class HistoryDonation extends StatefulWidget {
  HistoryDonation({Key? key}) : super(key: key);

  @override
  _HistoryDonationState createState() => _HistoryDonationState();

}

class _HistoryDonationState extends State<HistoryDonation> {

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  UsersModel? loggedInUser = AuthManager.currentUser;

  @override
  Widget build(BuildContext context) {
    return Scaffold(

      appBar: AppBar(

        title: Text('History'),
        leading: IconButton(
          icon: Icon(Icons.arrow_back),

          onPressed: () {
            Navigator.pop(context); // Use this if you want to navigate back
          },
        ),
      ),
      body: SafeArea(
        child: FutureBuilder(
          future: DatabaseFile().fetchData(loggedInUser?.userID),
          builder: (BuildContext context,
              AsyncSnapshot<List<FoodDonateModel>> snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return Center(child: CircularProgressIndicator());
            } else if (snapshot.hasError) {
              return Center(child: Text("Error: ${snapshot.error}"));
            } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
              return Center(child: Text("No Data Found"));
            } else {
              return ListView.builder(
                itemCount: snapshot.data!.length,
                itemBuilder: (context, index) {
                  return _displayCard(snapshot.data![index]);
                },
              );
            }
          },
        ),
      ),
    );
  }

  // Widget _displayCard(FoodDonateModel data){
  Widget _displayCard(FoodDonateModel data) {
    return Card(
      elevation: 5,
      child: Padding(
        padding: EdgeInsets.all(10.0),
        child: Row(
          children: [
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text("${data.fooditems}"),
                  Text("${data.pickupdate}"),
                ],
              ),
            ),
            ElevatedButton(
              onPressed: () {
                Navigator.push(
                  context, MaterialPageRoute(
                    builder: (context) =>
                        DetailsDonation(data: data)),
                );
              },
              child: const Text('View'),
            ),
          ],
        ),
      ),
    );
  }
}
