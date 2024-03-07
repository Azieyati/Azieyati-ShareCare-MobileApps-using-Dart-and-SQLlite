// search_screen.dart
import 'package:flutter/material.dart';

import '../JsonModels/user_authentication.dart';
import '../JsonModels/users.dart';

class HomeUser extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    UsersModel? loggedInUser = AuthManager.currentUser;

    return Scaffold(
      body: SingleChildScrollView(

        child: Column(

          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [

            Container(

              decoration: BoxDecoration(

                color: Theme
                    .of(context)
                    .primaryColor,
                borderRadius: const BorderRadius.only(
                  bottomRight: Radius.circular(25),
                ),
              ),

              child: Column(

                children: [

                  const SizedBox(height: 100),
                  ListTile(

                    contentPadding: const
                    EdgeInsets.symmetric(
                        horizontal: 30),

                    leading: const CircleAvatar(
                      radius: 30,
                      backgroundImage: AssetImage(

                        // Make sure this path is correct
                          'images/homeusericon.png'),
                    ),

                    title: Text(

                      'HELLO ${loggedInUser ?.username.toUpperCase()}, \n'
                      'Welcome To ShareCare!',

                      // should display the current user
                      style: Theme
                          .of(context)
                          .textTheme
                          .headline6
                          ?.copyWith(
                        color: Colors.white,
                      ),
                    ),
                  ),
                  const SizedBox(height: 30),
                ],
              ),
            ),
            SizedBox(

              //Use of SizedBox
              height: 10,
            ),
            SizedBox(

              width: double.infinity,
              height: 300,
              child:
              ImageSection(
                image:
                'images/gambar.png',
              ),
            ),

            Container(

              width: double.infinity,
              padding: const
              EdgeInsets.all(
                  16
              ),

              child: Column(

                crossAxisAlignment: CrossAxisAlignment.start,

                children: [

                  TitleSection(

                    name: 'About ShareCare',
                    location: 'Let Do Donation ',
                  ),

                  TextSection(

                    description:
                    'Sharecare is a platform that allows '
                        'users to make donations to the '
                        'surrounding community. Through '
                        'this, it can help those who '
                        'embrace it more. '
                        'That is distributing food to '
                        'people who cannot afford it. '
                        'Through this, it can prevent '
                        'a high rate of waste and '
                        'can give birth to pure '
                        'values in an individual',
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class TitleSection extends StatelessWidget {
  final String name;
  final String location;

  const TitleSection({
    required this.name,
    required this.location});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8),
      child: Row(
        children: [
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: const EdgeInsets
                      .only(
                      bottom: 8
                  ),

                  child: Text(
                    name,
                    style: const TextStyle(
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                Text(
                  location,
                  style: TextStyle(
                    color: Colors.grey[500],
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class ButtonWithText extends StatelessWidget {
  const ButtonWithText({
    required this.color,
    required this.icon,
    required this.label,
  });

  final Color color;
  final IconData icon;
  final String label;

  @override
  Widget build(BuildContext context) {
    return Column(

      mainAxisSize: MainAxisSize.min,
      mainAxisAlignment: MainAxisAlignment.center,

      children: [

        Icon(icon, color: color),

        Padding(

          padding: const EdgeInsets
              .only(
              top: 8),

          child: Text(
            label,
            style: TextStyle(
              fontSize: 12,
              fontWeight: FontWeight.w400,
              color: color,
            ),
          ),
        ),
      ],
    );
  }
}

class TextSection extends StatelessWidget {

  const TextSection({
    required this.description,
  });

  final String description;

  @override
  Widget build(BuildContext context) {

    return Padding(

      padding: const EdgeInsets.all(8),

      child: Text(
        description,
        softWrap: true,
      ),
    );
  }
}

class ImageSection extends StatelessWidget {

  final String image;

  const ImageSection({required this.image});

  @override
  Widget build(BuildContext context) {
    return Image.asset(

      image,
      width: double
          .infinity,

      height: MediaQuery
          .of(context)
          .size
          .height * 0.9,
      fit: BoxFit
          .cover,
    );
  }
}
