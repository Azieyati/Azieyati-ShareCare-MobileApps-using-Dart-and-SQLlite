import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import '../JsonModels/fooddonate.dart';
import '../JsonModels/user_authentication.dart';
import '../JsonModels/users.dart';
import '../sqflite-database/sqflite.dart';
import 'history_donation.dart';

class DonationFormWidget extends StatefulWidget {
  const DonationFormWidget({Key? key, this.restorationId}) : super(key: key);

  final String? restorationId; // For datetime id
  @override
  State<StatefulWidget> createState() => _DonationFormWidget();
}

// DropdownMenuEntry labels and values for time menu
enum timeLabel {
  time1('09:00 pagi'),
  time2('10:00 pagi'),
  time3('12:00 tengahari'),
  time4('1:00 petang'),
  time5('2:00 petang'),
  time6('3:00 petang'),
  time7('4:00 petang'),
  time8('5:00 petang');

  const timeLabel(this.label);

  final String label;
}


// DropdownMenuEntry labels and values for food category menu
enum categoryLabel {
  category1('Fruit and vegetables.'),
  category2('Grains'),
  category3('Protein Foods'),
  category4('Dairy'),
  category5('Oils & Solid Fats'),
  category6('Beverages'),
  category7('Others');

  const categoryLabel(this.label);

  final String label;
}


class _DonationFormWidget extends State<DonationFormWidget>
    with RestorationMixin {

  // The variable used for hide and show password
  bool isVisible = false;

  // Create global key for form
  final _formfield = GlobalKey<FormState>();

  // The variable as a controller that control the text
  final addressController = TextEditingController();
  final fooditemsController = TextEditingController();
  final pickupdateController = TextEditingController();
  final pickuptimeController = TextEditingController();
  final quantityController = TextEditingController();
  final foodcategoryController = TextEditingController();

  // Label for pickup time
  timeLabel? selectedTime;

  // Label for food category
  categoryLabel? selectedcategory;

  // Declare database
  final db = DatabaseFile();

  // This method used for date picker
  @override
  String? get restorationId => widget.restorationId;

  final RestorableDateTime _selectedDate =
  RestorableDateTime(DateTime(2024, 1, 1));

  late final RestorableRouteFuture<DateTime?>
  _restorableDatePickerRouteFuture =
  RestorableRouteFuture<DateTime?>(
    onComplete: _selectDate,

    onPresent: (NavigatorState navigator, Object? arguments) {
      return navigator.restorablePush(

        _datePickerRoute,
        arguments: _selectedDate.value.millisecondsSinceEpoch,
      );
    },
  );

  // This method used for date picker
  static Route<DateTime> _datePickerRoute(BuildContext context,
      Object? arguments,) {
    return DialogRoute<DateTime>(
      context: context,
      builder: (BuildContext context) {
        return DatePickerDialog(
          restorationId: 'date_picker_dialog',
          initialEntryMode: DatePickerEntryMode.calendarOnly,
          initialDate: DateTime.now(),
          // Set initialDate to the current date
          firstDate: DateTime(2024),
          lastDate: DateTime(2025),
        );
      },
    );
  }

  // This method used for date picker
  @override
  void restoreState(RestorationBucket? oldBucket, bool initialRestore) {
    registerForRestoration(_selectedDate, 'selected_date');
    registerForRestoration(
        _restorableDatePickerRouteFuture, 'date_picker_route_future');
  }

  void _selectDate(DateTime? newSelectedDate) {
    if (newSelectedDate != null) {
      setState(() {
        _selectedDate.value = newSelectedDate;

        // Update Controller with the selected date
        pickupdateController.text =
        '${_selectedDate.value.day}/${_selectedDate.value.month}/'
            '${_selectedDate.value.year}';

        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          content: Text(
              'Selected: ${_selectedDate.value.day}/${_selectedDate.value
                  .month}'
                  '/${_selectedDate.value.year}'),
        ));
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    UsersModel? loggedInUser = AuthManager.currentUser;
    return Scaffold(

      appBar: AppBar(

        title: Text('Food Donation Form'),
        titleTextStyle: TextStyle(
            fontSize: 20,
            color: Colors.black),

        backgroundColor: Colors.white,
        // leading: BackButton(color: Colors.black),
      ),
      body:

      SingleChildScrollView(
        padding: EdgeInsets.symmetric(
          horizontal: 20,
          vertical: 30,
        ),

        child:
        Form(
          key: _formfield,
          child:
          Column(
            children: <Widget>[

              // For pickup address field
              Container(
                margin: EdgeInsets.symmetric(
                    horizontal: 10,
                    vertical: 6),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(8),
                  color: Colors.transparent,
                ),


                child: TextFormField(
                  // Register to controller
                  keyboardType: TextInputType.streetAddress,
                  controller: addressController,

                  decoration: InputDecoration(
                    labelText: 'Pickup address?',

                    border: OutlineInputBorder(
                        borderRadius:
                        BorderRadius.circular(8)
                    ),

                    suffixIcon: Icon(
                      Icons.location_pin,
                    ),
                  ),

                  validator: (value) {
                    if (value!.isEmpty) {
                      return "Enter address to pickup";
                    }
                  },
                ),
              ),

              // For food items field
              Container(
                margin: EdgeInsets.symmetric(
                    horizontal: 10,
                    vertical: 6),

                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(8),
                  color: Colors.transparent,
                ),

                child:
                TextFormField(
                  // Register to controller
                  keyboardType: TextInputType.text,
                  controller: fooditemsController,

                  decoration: InputDecoration(
                    labelText: 'Food Item ',

                    border: OutlineInputBorder(
                        borderRadius:
                        BorderRadius.circular(8)),
                  ),

                  validator: (value) {
                    if (value!.isEmpty) {
                      return "Enter food item";
                    }
                  },
                ),
              ),

              // For pickup date field
              Container(
                margin: EdgeInsets.symmetric(
                    horizontal: 10,
                    vertical: 6
                ),

                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(8),
                  color: Colors.transparent,
                ),

                child: Column(
                  children: [
                    TextFormField(
                      controller: TextEditingController(
                        text: '${_selectedDate.value.day}'
                            '/'
                            '${_selectedDate.value.month}'
                            '/'
                            '${_selectedDate.value.year}',

                      ),

                      style: TextStyle(fontSize: 16),

                      //Set the TextFormField as read-only to prevent user input
                      readOnly: true,

                      decoration: InputDecoration(
                        labelText: 'Selected Date',
                        border: OutlineInputBorder(),
                        suffixIcon: IconButton(

                          icon: Icon(Icons.calendar_month_outlined),
                          onPressed: () {
                            _restorableDatePickerRouteFuture.present();
                          },
                        ),
                      ),
                    ),
                  ],
                ),
              ),

              // For pickup Time field
              Container(
                margin: EdgeInsets.symmetric(
                    horizontal: 10,
                    vertical: 10),

                decoration: BoxDecoration(

                  borderRadius: BorderRadius.circular(8),
                  color: Colors.transparent,
                ),

                child:
                DropdownMenu<timeLabel>(
                  controller: pickuptimeController,
                  width: 335,
                  requestFocusOnTap: true,
                  label: const Text('Time'),
                  onSelected: (timeLabel? time) {
                    setState(() {
                      selectedTime = time;
                    });
                  },

                  dropdownMenuEntries: timeLabel.values
                      .map<DropdownMenuEntry<timeLabel>>(
                          (timeLabel time) {
                        return DropdownMenuEntry<timeLabel>(
                          value: time,
                          label: time.label,
                          enabled: time.label != 'Grey',
                          style: MenuItemButton.styleFrom(
                            foregroundColor: Colors.blue,
                          ),
                        );
                      }).toList(),
                ),
              ),

              // Quantity
              Container(
                margin: EdgeInsets.symmetric(
                    horizontal: 9,
                    vertical: 6),

                decoration: BoxDecoration(

                  borderRadius: BorderRadius.circular(8),
                  color: Colors.transparent,
                ),

                child: // For food items
                TextFormField(
                  // Register to controller
                  keyboardType: TextInputType.number,
                  controller: quantityController,

                  decoration: InputDecoration(

                    labelText: 'Quantity (eg, 100 packets)',
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(8)),
                    suffixIcon: Icon(Icons.edit_calendar
                    ),
                  ),

                  validator: (value) {
                    if (value!.isEmpty) {
                      return "Enter quantity";
                    }
                  },
                ),
              ),

              // For Food category field
              Container(
                margin: EdgeInsets.symmetric(
                    horizontal: 10,
                    vertical: 6),

                child:
                DropdownMenu<categoryLabel>(
                  controller: foodcategoryController,
                  width: 335,
                  requestFocusOnTap: true,
                  label: const Text('Food Category'),
                  onSelected: (categoryLabel? category) {
                    setState(() {
                      selectedcategory = category;
                    });
                  },

                  dropdownMenuEntries: categoryLabel.values
                      .map<DropdownMenuEntry<categoryLabel>>(
                          (categoryLabel category) {
                        return DropdownMenuEntry<categoryLabel>(
                          value: category,
                          label: category.label,
                          enabled: category.label != 'Grey',
                          style: MenuItemButton.styleFrom(
                            foregroundColor: Colors.blue,
                          ),
                        );
                      }).toList(),
                ),
              ),

              SizedBox(height: 18),

              // Button to submit the donation form
              Align(alignment: Alignment.bottomRight,

                child:
                ElevatedButton(

                  onPressed: () {
                    if (_formfield.currentState!.validate()) {
                      // signup method
                      final db = DatabaseFile();
                      db.donateform(FoodDonateModel(
                          userID: loggedInUser?.userID,
                          pickupaddress: addressController.text,
                          fooditems: fooditemsController.text,
                          pickupdate: pickupdateController.text,
                          pickuptime: pickuptimeController.text ?? "",
                          quantity: int.tryParse(quantityController.text),
                          category: foodcategoryController.text ?? "")
                      ).whenComplete(() =>
                          Navigator.push(context,
                              MaterialPageRoute(builder:
                                  (context) => HistoryDonation())));
                    };
                  },

                  child:
                  Text('Confirm',
                      style: TextStyle(
                          color: Colors.white,
                          fontSize: 20)),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Theme
                        .of(context)
                        .primaryColor, //background color of button
                    elevation: 3, //elevation of button
                    shape: RoundedRectangleBorder( //to set border radius to button
                        borderRadius: BorderRadius.circular(20)
                    ),
                    padding: EdgeInsets.only(
                        left: 40, right: 40, bottom: 15, top: 15
                    ), //content padding inside button
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}