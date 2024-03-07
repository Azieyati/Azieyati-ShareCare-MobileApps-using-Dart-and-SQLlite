// search_screen.dart
import 'package:flutter/material.dart';
import '../JsonModels/fooddonate.dart';

class DetailsDonation extends StatelessWidget {
  final FoodDonateModel data;

  DetailsDonation({required this.data});

  @override
  Widget build(BuildContext context) {
    return Scaffold(

      appBar: AppBar(
        title: const Text('Information'),
        titleTextStyle: TextStyle(
            color: Colors.black,
            fontSize: 20),

        toolbarHeight: 100,
        backgroundColor: Colors.white,
        leading: BackButton(
            color: Colors.black),

      ),
      body: SingleChildScrollView(
        child: Column(

          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,

          children: [

            //Use of SizedBox
            SizedBox(
              height: 30,
            ),
            //Address Donation

            Card(
              elevation: 0,
              shape: RoundedRectangleBorder(
                side: BorderSide(),

                borderRadius: const BorderRadius.all(
                    Radius.circular(
                        12
                    )),
              ),
              child: Column(
                children: [
                  ListTile(
                    leading: Icon(Icons.home),
                    title: Text('From:'),
                    subtitle: Text("${data.pickupaddress}"),
                  ),
                ],
              ),
            ),
            //Detain Donation
            Card(
              elevation: 0,
              shape: RoundedRectangleBorder(
                side: BorderSide(),
                borderRadius: const BorderRadius.all(Radius.circular(12)),
              ),
              child: Column(
                children: [
                  ListTile(
                    leading: Icon(Icons.ad_units),
                    title: Text('Information'),
                    subtitle: Text(
                        "${data.quantity} "
                            "x "
                            "${data.fooditems}"),
                  ),
                ],
              ),
            ),

            Card(

              elevation: 0,

              shape: RoundedRectangleBorder(
                side: BorderSide(),
                borderRadius: const BorderRadius.all(Radius.circular(12)),
              ),
              child: Column(

                children: [

                  ListTile(
                    leading: Icon(Icons.time_to_leave_outlined),
                    title: Text('Time'),
                    subtitle: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text("${data.pickuptime}"),
                        // Add your image below the subtitle
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ], // children
        ),
      ),
    );
  }
}
