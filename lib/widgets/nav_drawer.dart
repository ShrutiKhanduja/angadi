import 'package:angadi/routes/router.gr.dart';
import 'package:angadi/screens/settings_screen.dart';
import 'package:angadi/values/data.dart';
import 'package:angadi/values/values.dart';
import 'package:angadi/widgets/custom_text_form_field.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:expandable/expandable.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:angadi/routes/router.gr.dart' as R;
import 'package:geocoder/geocoder.dart';
import 'package:geolocator/geolocator.dart';

import 'package:getflutter/components/avatar/gf_avatar.dart';
import 'package:getflutter/components/drawer/gf_drawer.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:location/location.dart';

class CustomDrawer extends StatefulWidget {
  @override
  _CustomDrawerState createState() => _CustomDrawerState();
}

class _CustomDrawerState extends State<CustomDrawer> {
  List categories = [];
  getCategories() {
    Firestore.instance.collection('Categories').getDocuments().then((value) {
      for (var v in value.documents) {
        print('----------------$v');
        categories.add(v);
      }
    });
  }

  Location loc = new Location();
  LocationData _currentPosition;

  final Geolocator geolocator = Geolocator()..forceAndroidLocationManager;

  String currentAddress = 'Enter Address';
  Future<Position> _getCurrentLocation() async {
    _currentPosition = await loc.getLocation();
//    Position position = await geolocator.getCurrentPosition(
//        desiredAccuracy: LocationAccuracy.high);
//    print(position);
//    geolocator
//        .getCurrentPosition(desiredAccuracy: LocationAccuracy.best)
//        .then((Position position) {
//      setState(() {
//        _currentPosition = position;
//      });
    print(_currentPosition);
    _getAddressFromLatLng();
    print(_currentPosition);
  }

  _getAddressFromLatLng() async {
    try {
      List<Placemark> p = await geolocator.placemarkFromCoordinates(
          _currentPosition.latitude, _currentPosition.longitude);

      Placemark place = p[0];

      setState(() {
        currentAddress = "${place.subLocality}, ${place.locality}";
        print(currentAddress);
        location = currentAddress;
        pass.text = currentAddress;
      });
    } catch (e) {
      print(e);
    }
  }

  var location = 'Dubai';
  final pass = TextEditingController();

  Future<void> _locationDialog(BuildContext context) async {
    return showDialog<void>(
      context: context,
      barrierDismissible: false, // user must tap button!
      builder: (BuildContext context) {
        return _buildAlertDialogLocation(context);
      },
    );
  }

  Widget _buildAlertDialogLocation(BuildContext context) {
    var textTheme = Theme.of(context).textTheme;

    var hintTextStyle =
        textTheme.subtitle.copyWith(color: AppColors.accentText);
    var textFormFieldTextStyle =
        textTheme.subtitle.copyWith(color: AppColors.accentText);
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.all(
          Radius.circular(Sizes.RADIUS_32),
        ),
      ),
      child: AlertDialog(
        contentPadding: EdgeInsets.fromLTRB(
          Sizes.PADDING_0,
          Sizes.PADDING_36,
          Sizes.PADDING_0,
          Sizes.PADDING_0,
        ),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(Sizes.RADIUS_20),
        ),
        elevation: Sizes.ELEVATION_4,
        content: Container(
          height: Sizes.HEIGHT_160,
          width: Sizes.WIDTH_300,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              SingleChildScrollView(
                child: Center(
                  child: Text(
                    'Change location',
                    style: textTheme.title.copyWith(
                      fontSize: Sizes.TEXT_SIZE_20,
                    ),
                  ),
                ),
              ),
              Spacer(flex: 1),
              Padding(
                padding: const EdgeInsets.all(10.0),
                child: CustomTextFormField(
                  controller: pass,
                  textFormFieldStyle: textFormFieldTextStyle,
                  hintText: "New Location",
                  hintTextStyle: hintTextStyle,
                  borderStyle: BorderStyle.solid,
                  borderWidth: Sizes.WIDTH_1,
                ),
              ),
              Spacer(flex: 1),
              Row(
                children: <Widget>[
                  AlertDialogButton(
                    buttonText: "Cancel",
                    width: Sizes.WIDTH_150,
                    border: Border(
                      top: BorderSide(
                        width: 1,
                        color: AppColors.greyShade1,
                      ),
                      right: BorderSide(
                        width: 1,
                        color: AppColors.greyShade1,
                      ),
                    ),
                    textStyle:
                        textTheme.button.copyWith(color: AppColors.accentText),
                    onPressed: () => Navigator.of(context).pop(),
                  ),
                  AlertDialogButton(
                      buttonText: "Change",
                      width: Sizes.WIDTH_150,
                      border: Border(
                        top: BorderSide(
                          width: 1,
                          color: AppColors.greyShade1,
                        ),
                      ),
                      textStyle: textTheme.button
                          .copyWith(color: AppColors.secondaryElement),
                      onPressed: () {
                        setState(() {
                          location = pass.text;
                        });
                        Navigator.of(context).pop(true);
                      }),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }

  @override
  void initState() {
    _getCurrentLocation();
    getCategories();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return GFDrawer(
      child: Scaffold(
        body: ListView(
          padding: EdgeInsets.zero,
          children: <Widget>[
            SizedBox(
              height: 50,
              child: Container(
                  // color: Color(0xFF3871AD),
                  ),
            ),
            // Container(
            //   margin: EdgeInsets.symmetric(horizontal: 20),
            //   height: 0.5,
            //   color: Colors.black26,
            // ),
            Container(
              child: Padding(
                padding: const EdgeInsets.fromLTRB(20, 8.0, 8, 8),
                child: Row(
                  children: [
                    Container(width: 230, child: Text('Deliver to $location')),
                    SizedBox(
                      width: 10,
                    ),
                    InkWell(
                        onTap: () {
                          _locationDialog(context);
                        },
                        child: Icon(Icons.edit))
                  ],
                ),
              ),
            ),
            Container(
              margin: EdgeInsets.symmetric(horizontal: 20),
              height: 0.5,
              color: Colors.black26,
            ),
            ExpandablePanel(
                // hasIcon: true,
                // iconColor: Color(0xFFC5891E),
//          trailing: Icon(Icons.keyboard_arrow_down),
                header: Padding(
                  padding: const EdgeInsets.fromLTRB(20, 20, 0, 10),
                  child: Text(
                    'Earliest Delivery in 5 hrs',
                    style: TextStyle(
                      // fontWeight: FontWeight.w500,
                      fontSize: 22,
                      // color: Color(0xFFC5891E),
                    ),
                  ),
                ),
                expanded: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 8),
                    child: ListView.builder(
                        itemCount: 2,
                        shrinkWrap: true,
                        scrollDirection: Axis.vertical,
                        itemBuilder: (context, index) {
                          return Padding(
                            padding: const EdgeInsets.fromLTRB(20, 0, 0, 10),
                            child: Container(
                                width: MediaQuery.of(context).size.width,
                                // color: Color(0xFFC5891E),
                                child: Text(
                                  'Delivery in ${24 * (index + 1)} hrs',
                                  style: TextStyle(
                                    fontSize: 20,
                                  ),
                                )),
                          );
                        }))),
            Container(
              margin: EdgeInsets.symmetric(horizontal: 20),
              height: 0.5,
              color: Colors.black26,
            ),

            InkWell(
              onTap: () {
                Navigator.pop(context);
              },
              child: ListTile(
                title: Padding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 10.0, vertical: 5),
                  child: Text(
                    'Home',
                    style: TextStyle(
                      fontSize: 20,
                      // fontFamily: 'nunito',
                    ),
                  ),
                ),
                onTap: () {
                  // UrlLauncher.launch(
                  //     "https://www.youtube.com/playlist?list=PLKe-Zuux9p9vWWUVGyY5SPMO6MpRDjZ5x");
                },
              ),
            ),

            Container(
              margin: EdgeInsets.symmetric(horizontal: 20),
              height: 0.5,
              color: Colors.black26,
            ),
            ListTile(
              title: Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 10.0, vertical: 5),
                child: Text(
                  'Offers',
                  style: TextStyle(
                    fontSize: 20,
                  ),
                ),
              ),
              onTap: () {
                // UrlLauncher.launch(
                //     "https://www.youtube.com/playlist?list=PLKe-Zuux9p9vWWUVGyY5SPMO6MpRDjZ5x");
              },
            ),
            Container(
              margin: EdgeInsets.symmetric(horizontal: 20),
              height: 0.5,
              color: Colors.black26,
            ),
            ExpandablePanel(
                // hasIcon: true,
                // iconColor: Color(0xFFC5891E),
//          trailing: Icon(Icons.keyboard_arrow_down),
                header: Padding(
                  padding: const EdgeInsets.fromLTRB(20, 20, 0, 20),
                  child: Text(
                    'Categories',
                    style: TextStyle(
                      // fontWeight: FontWeight.w500,
                      fontSize: 22,
                      // color: Color(0xFFC5891E),
                    ),
                  ),
                ),
                expanded: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 8),
                    child: ListView.builder(
                        itemCount: categories.length,
                        shrinkWrap: true,
                        scrollDirection: Axis.vertical,
                        itemBuilder: (context, index) {
                          return InkWell(
                            onTap: () {
                              R.Router.navigator.pushNamed(
                                R.Router.categoryDetailScreen,
                                arguments: CategoryDetailScreenArguments(
                                  categoryName: categories[index]['catName'],
                                  imagePath: categories[index]['imageURL'],
                                  selectedCategory: index,
                                  numberOfCategories: categories.length,
                                  gradient: gradients[index],
                                ),
                              );
                            },
                            child: Padding(
                              padding: const EdgeInsets.fromLTRB(20, 0, 0, 10),
                              child: Container(
                                  width: MediaQuery.of(context).size.width,
                                  // color: Color(0xFFC5891E),
                                  child: Text(
                                    '${categories[index]['catName']}',
                                    style: TextStyle(
                                      fontSize: 20,
                                    ),
                                  )),
                            ),
                          );
                        }))),
            Container(
              margin: EdgeInsets.symmetric(horizontal: 20),
              height: 0.5,
              color: Colors.black26,
            ),
            ListTile(
              title: Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 10.0, vertical: 5),
                child: Text(
                  'Customer Service',
                  style: TextStyle(
                    fontSize: 20,
                  ),
                ),
              ),
              onTap: () {
                // UrlLauncher.launch(
                //     "https://www.youtube.com/playlist?list=PLKe-Zuux9p9vWWUVGyY5SPMO6MpRDjZ5x");
              },
            ),
            Container(
              margin: EdgeInsets.symmetric(horizontal: 20),
              height: 0.5,
              color: Colors.black26,
            ),
            ListTile(
              title: Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 10.0, vertical: 5),
                child: Text(
                  'Notifications',
                  style: TextStyle(
                    fontSize: 20,
                  ),
                ),
              ),
              onTap: () {
                // UrlLauncher.launch(
                //     "https://www.youtube.com/playlist?list=PLKe-Zuux9p9vWWUVGyY5SPMO6MpRDjZ5x");
              },
            ),
            Container(
              margin: EdgeInsets.symmetric(horizontal: 20),
              height: 0.5,
              color: Colors.black26,
            ),
            ListTile(
              title: Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 10.0, vertical: 5),
                child: Text(
                  'FAQs',
                  style: TextStyle(
                    fontSize: 20,
                  ),
                ),
              ),
              onTap: () {
                // UrlLauncher.launch(
                //     "https://www.youtube.com/playlist?list=PLKe-Zuux9p9vWWUVGyY5SPMO6MpRDjZ5x");
              },
            ),
            Container(
              margin: EdgeInsets.symmetric(horizontal: 20),
              height: 0.5,
              color: Colors.black26,
            ),
            ListTile(
              title: Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 10.0, vertical: 5),
                child: Text(
                  'Sign Out',
                  style: TextStyle(
                    fontSize: 20,
                  ),
                ),
              ),
              onTap: () => _logoutDialog(context),
            ),
          ],
        ),
      ),
    );
  }

  Future<void> _logoutDialog(BuildContext context) async {
    return showDialog<void>(
      context: context,
      barrierDismissible: false, // user must tap button!
      builder: (BuildContext context) {
        return _buildAlertDialog(context);
      },
    );
  }

  Widget _buildAlertDialog(BuildContext context) {
    var textTheme = Theme.of(context).textTheme;
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.all(
          Radius.circular(Sizes.RADIUS_32),
        ),
      ),
      child: AlertDialog(
        contentPadding: EdgeInsets.fromLTRB(
          Sizes.PADDING_0,
          Sizes.PADDING_36,
          Sizes.PADDING_0,
          Sizes.PADDING_0,
        ),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(Sizes.RADIUS_20),
        ),
        elevation: Sizes.ELEVATION_4,
        content: Container(
          height: Sizes.HEIGHT_150,
          width: Sizes.WIDTH_300,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              SingleChildScrollView(
                child: Center(
                  child: Container(
                    width: 200,
                    child: Text(
                      'Are you sure you want to Logout ?',
                      textAlign: TextAlign.center,
                      style: textTheme.title.copyWith(
                        fontSize: Sizes.TEXT_SIZE_20,
                      ),
                    ),
                  ),
                ),
              ),
              Spacer(flex: 1),
              Row(
                children: <Widget>[
                  AlertDialogButton(
                    buttonText: "No",
                    width: 140,
                    border: Border(
                      top: BorderSide(
                        width: 1,
                        color: AppColors.greyShade1,
                      ),
                      right: BorderSide(
                        width: 1,
                        color: AppColors.greyShade1,
                      ),
                    ),
                    textStyle:
                        textTheme.button.copyWith(color: AppColors.accentText),
                    onPressed: () => Navigator.of(context).pop(),
                  ),
                  AlertDialogButton(
                      buttonText: "Yes",
                      width: 140,
                      border: Border(
                        top: BorderSide(
                          width: 1,
                          color: AppColors.greyShade1,
                        ),
                      ),
                      textStyle: textTheme.button
                          .copyWith(color: AppColors.secondaryElement),
                      onPressed: () {
                        FirebaseAuth.instance.signOut();
                        R.Router.navigator.pushNamedAndRemoveUntil(
                          R.Router.loginScreen,
                          (Route<dynamic> route) => false,
                        );
                      }),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}

//
// Widget retNavDrawer() {
//   return GFDrawer(
//     child: Scaffold(
//       body: ListView(
//         padding: EdgeInsets.zero,
//         children: <Widget>[
//           SizedBox(
//             height: 50,
//             child: Container(
//                 // color: Color(0xFF3871AD),
//                 ),
//           ),
//           // Container(
//           //   margin: EdgeInsets.symmetric(horizontal: 20),
//           //   height: 0.5,
//           //   color: Colors.black26,
//           // ),
//           ListTile(
//             title: Padding(
//               padding:
//                   const EdgeInsets.symmetric(horizontal: 10.0, vertical: 5),
//               child: Text(
//                 'Home',
//                 style: TextStyle(
//                   fontSize: 20,
//                   // fontFamily: 'nunito',
//                 ),
//               ),
//             ),
//             onTap: () {
//               // UrlLauncher.launch(
//               //     "https://www.youtube.com/playlist?list=PLKe-Zuux9p9vWWUVGyY5SPMO6MpRDjZ5x");
//             },
//           ),
//           Container(
//             margin: EdgeInsets.symmetric(horizontal: 20),
//             height: 0.5,
//             color: Colors.black26,
//           ),
//           ListTile(
//             title: Padding(
//               padding:
//                   const EdgeInsets.symmetric(horizontal: 10.0, vertical: 5),
//               child: Text(
//                 'Offers',
//                 style: TextStyle(
//                   fontSize: 20,
//                 ),
//               ),
//             ),
//             onTap: () {
//               // UrlLauncher.launch(
//               //     "https://www.youtube.com/playlist?list=PLKe-Zuux9p9vWWUVGyY5SPMO6MpRDjZ5x");
//             },
//           ),
//           Container(
//             margin: EdgeInsets.symmetric(horizontal: 20),
//             height: 0.5,
//             color: Colors.black26,
//           ),
//           ListTile(
//             title: Padding(
//               padding:
//                   const EdgeInsets.symmetric(horizontal: 10.0, vertical: 5),
//               child: Text(
//                 'Shop By Category',
//                 style: TextStyle(
//                   fontSize: 20,
//                 ),
//               ),
//             ),
//             onTap: () {
//               // UrlLauncher.launch(
//               //     "https://www.youtube.com/playlist?list=PLKe-Zuux9p9vWWUVGyY5SPMO6MpRDjZ5x");
//             },
//           ),
//           Container(
//             margin: EdgeInsets.symmetric(horizontal: 20),
//             height: 0.5,
//             color: Colors.black26,
//           ),
//           ListTile(
//             title: Padding(
//               padding:
//                   const EdgeInsets.symmetric(horizontal: 10.0, vertical: 5),
//               child: Text(
//                 'Customer Service',
//                 style: TextStyle(
//                   fontSize: 20,
//                 ),
//               ),
//             ),
//             onTap: () {
//               // UrlLauncher.launch(
//               //     "https://www.youtube.com/playlist?list=PLKe-Zuux9p9vWWUVGyY5SPMO6MpRDjZ5x");
//             },
//           ),
//           Container(
//             margin: EdgeInsets.symmetric(horizontal: 20),
//             height: 0.5,
//             color: Colors.black26,
//           ),
//           ListTile(
//             title: Padding(
//               padding:
//                   const EdgeInsets.symmetric(horizontal: 10.0, vertical: 5),
//               child: Text(
//                 'Notifications',
//                 style: TextStyle(
//                   fontSize: 20,
//                 ),
//               ),
//             ),
//             onTap: () {
//               // UrlLauncher.launch(
//               //     "https://www.youtube.com/playlist?list=PLKe-Zuux9p9vWWUVGyY5SPMO6MpRDjZ5x");
//             },
//           ),
//           Container(
//             margin: EdgeInsets.symmetric(horizontal: 20),
//             height: 0.5,
//             color: Colors.black26,
//           ),
//           ListTile(
//             title: Padding(
//               padding:
//                   const EdgeInsets.symmetric(horizontal: 10.0, vertical: 5),
//               child: Text(
//                 'FAQs',
//                 style: TextStyle(
//                   fontSize: 20,
//                 ),
//               ),
//             ),
//             onTap: () {
//               // UrlLauncher.launch(
//               //     "https://www.youtube.com/playlist?list=PLKe-Zuux9p9vWWUVGyY5SPMO6MpRDjZ5x");
//             },
//           ),
//         ],
//       ),
//     ),
//   );
// }
