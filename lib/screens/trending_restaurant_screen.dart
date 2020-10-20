import 'package:angadi/classes/dish.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:angadi/routes/router.dart';
import 'package:angadi/routes/router.gr.dart' as R;
import 'package:angadi/values/data.dart';
import 'package:angadi/values/values.dart';
import 'package:angadi/widgets/foody_bite_card.dart';
import 'package:angadi/widgets/search_input_field.dart';
import 'package:angadi/widgets/spaces.dart';

import 'home_screen.dart';

class TrendingRestaurantsScreen extends StatefulWidget {
  @override
  _TrendingRestaurantsScreenState createState() =>
      _TrendingRestaurantsScreenState();
}

class _TrendingRestaurantsScreenState extends State<TrendingRestaurantsScreen> {
  List<Widget> trending = new List();

  List<Dish> dishes = new List<Dish>();
  @override
  void initState() {
    super.initState();
    print(cat);
    print(rat);
    print(money);
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        FocusScopeNode currentFocus = FocusScope.of(context);
        if (!currentFocus.hasPrimaryFocus) {
          currentFocus.unfocus();
        }
      },
      child: Scaffold(
          appBar: AppBar(
            elevation: 0.0,
            leading: InkWell(
              onTap: () => R.Router.navigator.pop(),
              child: Image.asset(
                ImagePath.arrowBackIcon,
                color: AppColors.headingText,
              ),
            ),
            centerTitle: true,
            title: Text(
              'Results',
              style: Styles.customTitleTextStyle(
                color: AppColors.headingText,
                fontWeight: FontWeight.w600,
                fontSize: Sizes.TEXT_SIZE_20,
              ),
            ),
          ),
          body: Container(
            margin: const EdgeInsets.only(
                left: Sizes.MARGIN_16,
                right: Sizes.MARGIN_16,
                top: Sizes.MARGIN_16),
            child: Column(
              children: <Widget>[
//                FoodyBiteSearchInputField(
//                  ImagePath.searchIcon,
//                  textFormFieldStyle:
//                      Styles.customNormalTextStyle(color: AppColors.accentText),
//                  hintText: StringConst.HINT_TEXT_TRENDING_SEARCH_BAR,
//                  hintTextStyle:
//                      Styles.customNormalTextStyle(color: AppColors.accentText),
//                  suffixIconImagePath: ImagePath.settingsIcon,
//                  borderWidth: 0.0,
//                  borderStyle: BorderStyle.solid,
//                ),
                SizedBox(height: Sizes.WIDTH_16),
                Expanded(
                    child: StreamBuilder(
                        stream:
                            Firestore.instance.collection('Dishes').snapshots(),
                        builder: (BuildContext context,
                            AsyncSnapshot<QuerySnapshot> snap) {
                          if (snap.hasData &&
                              !snap.hasError &&
                              snap.data != null) {
                            dishes.clear();
                            trending.clear();
                            for (int i = 0;
                                i < snap.data.documents.length;
                                i++) {
//              print(snap.data.documents[i]['url']);
                              dishes.add(Dish(
                                  name: snap.data.documents[i]['name'],
                                  category: snap.data.documents[i]['category'],
                                  rating: snap.data.documents[i]['rating'],
                                  price: snap.data.documents[i]['price'],
                                  desc: snap.data.documents[i]['description'],
                                  url: snap.data.documents[i]['url']));
                              print(snap.data.documents[i]['name']);
                              if ((money != null
                                      ? int.parse(snap.data.documents[i]
                                              ['price']) <=
                                          money
                                      : 1 == 1) &&
                                  (rat != null
                                      ? double.parse(snap.data.documents[i]
                                                  ['rating'])
                                              .ceil() >=
                                          rat
                                      : 1 == 1) &&
                                  (cat != null
                                      ? snap.data.documents[i]['category'] ==
                                          cat
                                      : 1 == 1))
                                trending.add(Container(
                                  margin: EdgeInsets.only(right: 4.0),
                                  child: FoodyBiteCard(
                                    onTap: () => R.Router.navigator.pushNamed(
                                        R.Router.restaurantDetailsScreen,
                                        arguments: RestaurantDetails(
                                          url: snap.data.documents[i]['url'],
                                          name: snap.data.documents[i]['name'],
                                          desc: snap.data.documents[i]
                                              ['description'],
                                          category: snap.data.documents[i]
                                              ['category'],
                                          rating: snap.data.documents[i]
                                              ['rating'],
                                          price: snap.data.documents[i]
                                              ['price'],
                                        )),
                                    imagePath: snap.data.documents[i]['url'],
                                    cardTitle: snap.data.documents[i]['name'],
                                    rating: snap.data.documents[i]['rating'],
                                    category: snap.data.documents[i]
                                        ['category'],
                                    price: snap.data.documents[i]['price'],
                                    iPrice: snap.data.documents[i]['iPrice'],
                                    address: snap.data.documents[i]
                                        ['description'],
                                  ),
                                ));
                            }
                          }
                          return trending.length != 0
                              ? ListView(
                                  children: trending,
                                )
                              : Container();
                        })),
              ],
            ),
          )),
    );
  }
}
//ListView.separated(
//scrollDirection: Axis.vertical,
//itemCount: 4,
//separatorBuilder: (context, index) {
//return SpaceH8();
//},
//itemBuilder: (context, index) {
//return Container(
//child: FoodyBiteCard(
//onTap: () => R.Router.navigator.pushNamed(
//R.Router.restaurantDetailsScreen,
//arguments: RestaurantDetails(
//url: 'snap.data.documents[i][',
//name: 'Hamburger',
//desc: 'Description',
//category: 'Category',
//rating: 'Rating',
//price: 'Price',
//),
//),
//imagePath: imagePaths[index],
//status: '20% OFF',
//cardTitle: 'Hamburger',
//rating: ratings[index],
//category: category[index],
//distance: '',
//address: 'Made with exotic ingredients',
//),
//);
//},
//),

class TrendingRestaurantsScreen1 extends StatefulWidget {
  String type;
  TrendingRestaurantsScreen1(this.type);
  @override
  _TrendingRestaurantsScreen1State createState() =>
      _TrendingRestaurantsScreen1State();
}

class _TrendingRestaurantsScreen1State
    extends State<TrendingRestaurantsScreen1> {
  List<Widget> trending = new List();

  List<Dish> dishes = new List<Dish>();
  @override
  void initState() {
    super.initState();
    print(cat);
    print(rat);
    print(money);
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        FocusScopeNode currentFocus = FocusScope.of(context);
        if (!currentFocus.hasPrimaryFocus) {
          currentFocus.unfocus();
        }
      },
      child: Scaffold(
          appBar: AppBar(
            elevation: 0.0,
            leading: InkWell(
              onTap: () => R.Router.navigator.pop(),
              child: Image.asset(
                ImagePath.arrowBackIcon,
                color: AppColors.headingText,
              ),
            ),
            centerTitle: true,
            title: Text(
              'All Dishes',
              style: Styles.customTitleTextStyle(
                color: AppColors.headingText,
                fontWeight: FontWeight.w600,
                fontSize: Sizes.TEXT_SIZE_20,
              ),
            ),
          ),
          body: Container(
            margin: const EdgeInsets.only(
                left: Sizes.MARGIN_16,
                right: Sizes.MARGIN_16,
                top: Sizes.MARGIN_16),
            child: Column(
              children: <Widget>[
//                FoodyBiteSearchInputField(
//                  ImagePath.searchIcon,
//                  textFormFieldStyle:
//                      Styles.customNormalTextStyle(color: AppColors.accentText),
//                  hintText: StringConst.HINT_TEXT_TRENDING_SEARCH_BAR,
//                  hintTextStyle:
//                      Styles.customNormalTextStyle(color: AppColors.accentText),
//                  suffixIconImagePath: ImagePath.settingsIcon,
//                  borderWidth: 0.0,
//                  borderStyle: BorderStyle.solid,
//                ),
                SizedBox(height: Sizes.WIDTH_16),
                Expanded(
                    child: StreamBuilder(
                        stream:
                            Firestore.instance.collection('Dishes').snapshots(),
                        builder: (BuildContext context,
                            AsyncSnapshot<QuerySnapshot> snap) {
                          if (snap.hasData &&
                              !snap.hasError &&
                              snap.data != null) {
                            dishes.clear();
                            trending.clear();
                            for (int i = 0;
                                i < snap.data.documents.length;
                                i++) {
//              print(snap.data.documents[i]['url']);
                              dishes.add(Dish(
                                  name: snap.data.documents[i]['name'],
                                  category: snap.data.documents[i]['category'],
                                  rating: snap.data.documents[i]['rating'],
                                  price: snap.data.documents[i]['price'],
                                  desc: snap.data.documents[i]['description'],
                                  url: snap.data.documents[i]['url']));
                              print(snap.data.documents[i]['name']);
                              if (snap.data.documents[i][widget.type])
                                trending.add(Container(
                                  margin: EdgeInsets.only(right: 4.0),
                                  child: FoodyBiteCard(
                                    onTap: () => R.Router.navigator.pushNamed(
                                        R.Router.restaurantDetailsScreen,
                                        arguments: RestaurantDetails(
                                          url: snap.data.documents[i]['url'],
                                          name: snap.data.documents[i]['name'],
                                          desc: snap.data.documents[i]
                                              ['description'],
                                          category: snap.data.documents[i]
                                              ['category'],
                                          rating: snap.data.documents[i]
                                              ['rating'],
                                          price: snap.data.documents[i]
                                              ['price'],
                                        )),
                                    imagePath: snap.data.documents[i]['url'],
                                    cardTitle: snap.data.documents[i]['name'],
                                    rating: snap.data.documents[i]['rating'],
                                    category: snap.data.documents[i]
                                        ['category'],
                                    price: snap.data.documents[i]['price'],
                                    iPrice: snap.data.documents[i]['iPrice'],
                                    address: snap.data.documents[i]
                                        ['description'],
                                  ),
                                ));
                            }
                          }
                          return trending.length != 0
                              ? ListView(
                                  children: trending,
                                )
                              : Container();
                        })),
              ],
            ),
          )),
    );
  }
}
//ListView.separated(
//scrollDirection: Axis.vertical,
//itemCount: 4,
//separatorBuilder: (context, index) {
//return SpaceH8();
//},
//itemBuilder: (context, index) {
//return Container(
//child: FoodyBiteCard(
//onTap: () => R.Router.navigator.pushNamed(
//R.Router.restaurantDetailsScreen,
//arguments: RestaurantDetails(
//url: 'snap.data.documents[i][',
//name: 'Hamburger',
//desc: 'Description',
//category: 'Category',
//rating: 'Rating',
//price: 'Price',
//),
//),
//imagePath: imagePaths[index],
//status: '20% OFF',
//cardTitle: 'Hamburger',
//rating: ratings[index],
//category: category[index],
//distance: '',
//address: 'Made with exotic ingredients',
//),
//);
//},
//),
