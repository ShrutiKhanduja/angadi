// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// AutoRouteGenerator
// **************************************************************************

import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:auto_route/auto_route.dart';
import 'package:angadi/screens/login_screen.dart';
import 'package:angadi/screens/splash_screen.dart';
import 'package:angadi/screens/forgot_password_screen.dart';
import 'package:angadi/screens/register_screen.dart';
import 'package:angadi/screens/set_location_screen.dart';
import 'package:angadi/screens/home_screen.dart';
import 'package:angadi/screens/root_screen.dart';
import 'package:angadi/routes/router.dart';
import 'package:angadi/screens/profile_screen.dart';
import 'package:angadi/screens/notification_screen.dart';
import 'package:angadi/screens/trending_restaurant_screen.dart';
import 'package:angadi/screens/restaurant_details_screen.dart';
import 'package:angadi/screens/bookmarks_screen.dart';
import 'package:angadi/screens/filter_screen.dart';
import 'package:angadi/screens/search_results.dart';
import 'package:angadi/screens/review_rating_screen.dart';
import 'package:angadi/screens/add_ratings_screen.dart';
import 'package:angadi/screens/menu_photos_screen.dart';
import 'package:angadi/screens/preview_menu_photos.dart';
import 'package:angadi/screens/categories_screen.dart';
import 'package:angadi/screens/category_detail_screen.dart';
import 'package:angadi/screens/find_friends_screen.dart';
import 'package:angadi/screens/settings_screen.dart';
import 'package:angadi/screens/change_password_screen.dart';
import 'package:angadi/screens/change_language_screen.dart';
import 'package:angadi/screens/edit_profile_screen.dart';
import 'package:angadi/screens/new_review_screen.dart';

String n;

class Router {
  static const loginScreen = '/';
  static const splashScreen = '/splash-screen';
  static const forgotPasswordScreen = '/forgot-password-screen';
  static const registerScreen = '/register-screen';
  static const setLocationScreen = '/set-location-screen';
  static const homeScreen = '/home-screen';
  static const rootScreen = '/root-screen';
  static const profileScreen = '/profile-screen';
  static const notificationsScreen = '/notifications-screen';
  static const trendingRestaurantsScreen = '/trending-restaurants-screen';
  static const restaurantDetailsScreen = '/restaurant-details-screen';
  static const bookmarksScreen = '/bookmarks-screen';
  static const filterScreen = '/filter-screen';
  static const searchResultsScreen = '/search-results-screen';
  static const reviewRatingScreen = '/review-rating-screen';
  static const addRatingsScreen = '/add-ratings-screen';
  static const menuPhotosScreen = '/menu-photos-screen';
  static const previewMenuPhotosScreen = '/preview-menu-photos-screen';
  static const categoriesScreen = '/categories-screen';
  static const categoryDetailScreen = '/category-detail-screen';
  static const findFriendsScreen = '/find-friends-screen';
  static const settingsScreen = '/settings-screen';
  static const changePasswordScreen = '/change-password-screen';
  static const changeLanguageScreen = '/change-language-screen';
  static const editProfileScreen = '/edit-profile-screen';
  static const newReviewScreen = '/new-review-screen';
  static final navigator = ExtendedNavigator();
  static Route<dynamic> onGenerateRoute(RouteSettings settings) {
    final args = settings.arguments;
    switch (settings.name) {
      case Router.loginScreen:
        return CupertinoPageRoute<dynamic>(
          builder: (_) => LoginScreen(),
          settings: settings,
        );
      case Router.splashScreen:
        return CupertinoPageRoute<dynamic>(
          builder: (_) => SplashScreen(),
          settings: settings,
        );
      case Router.forgotPasswordScreen:
        return CupertinoPageRoute<dynamic>(
          builder: (_) => ForgotPasswordScreen(),
          settings: settings,
        );
      case Router.registerScreen:
        return MaterialPageRoute<dynamic>(
          builder: (_) => RegisterScreen(),
          settings: settings,
        );
      case Router.setLocationScreen:
        return CupertinoPageRoute<dynamic>(
          builder: (_) => SetLocationScreen(n),
          settings: settings,
        );
      case Router.homeScreen:
        if (hasInvalidArgs<Key>(args)) {
          return misTypedArgsRoute<Key>(args);
        }
        final typedArgs = args as Key;
        return CupertinoPageRoute<dynamic>(
          builder: (_) => HomeScreen(key: typedArgs),
          settings: settings,
        );
      case Router.rootScreen:
        if (hasInvalidArgs<CurrentScreen>(args)) {
          return misTypedArgsRoute<CurrentScreen>(args);
        }
        final typedArgs = args as CurrentScreen;
        return CupertinoPageRoute<dynamic>(
          builder: (_) => RootScreen(currentScreen: typedArgs),
          settings: settings,
        );
      case Router.profileScreen:
        if (hasInvalidArgs<Key>(args)) {
          return misTypedArgsRoute<Key>(args);
        }
        final typedArgs = args as Key;
        return CupertinoPageRoute<dynamic>(
          builder: (_) => ProfileScreen(key: typedArgs),
          settings: settings,
        );
      case Router.notificationsScreen:
        if (hasInvalidArgs<Key>(args)) {
          return misTypedArgsRoute<Key>(args);
        }
        final typedArgs = args as Key;
        return CupertinoPageRoute<dynamic>(
          builder: (_) => NotificationsScreen(key: typedArgs),
          settings: settings,
        );
      case Router.trendingRestaurantsScreen:
        return CupertinoPageRoute<dynamic>(
          builder: (_) => TrendingRestaurantsScreen(),
          settings: settings,
        );
      case Router.restaurantDetailsScreen:
        if (hasInvalidArgs<RestaurantDetails>(args, isRequired: true)) {
          return misTypedArgsRoute<RestaurantDetails>(args);
        }
        final typedArgs = args as RestaurantDetails;
        return CupertinoPageRoute<dynamic>(
          builder: (_) => RestaurantDetailsScreen(typedArgs),
          settings: settings,
        );
      case Router.bookmarksScreen:
        return CupertinoPageRoute<dynamic>(
          builder: (_) => BookmarksScreen(),
          settings: settings,
        );
      case Router.filterScreen:
        return CupertinoPageRoute<dynamic>(
          builder: (_) => FilterScreen(),
          settings: settings,
        );
      case Router.searchResultsScreen:
        if (hasInvalidArgs<SearchValue>(args)) {
          return misTypedArgsRoute<SearchValue>(args);
        }
        final typedArgs = args as SearchValue;
        return CupertinoPageRoute<dynamic>(
          builder: (_) => SearchResultsScreen(typedArgs),
          settings: settings,
        );
      case Router.reviewRatingScreen:
        final typedArgs = args as ReviewRating;

        return CupertinoPageRoute<dynamic>(
          builder: (_) => ReviewRatingScreen(typedArgs),
          settings: settings,
        );
      case Router.addRatingsScreen:
        return CupertinoPageRoute<dynamic>(
          builder: (_) => AddRatingsScreen(),
          settings: settings,
        );
      case Router.menuPhotosScreen:
        return CupertinoPageRoute<dynamic>(
          builder: (_) => MenuPhotosScreen(),
          settings: settings,
        );
      case Router.previewMenuPhotosScreen:
        return CupertinoPageRoute<dynamic>(
          builder: (_) => PreviewMenuPhotosScreen(),
          settings: settings,
        );
      case Router.categoriesScreen:
        return CupertinoPageRoute<dynamic>(
          builder: (_) => CategoriesScreen(),
          settings: settings,
        );
      case Router.categoryDetailScreen:
        if (hasInvalidArgs<CategoryDetailScreenArguments>(args,
            isRequired: true)) {
          return misTypedArgsRoute<CategoryDetailScreenArguments>(args);
        }
        final typedArgs = args as CategoryDetailScreenArguments;
        return CupertinoPageRoute<dynamic>(
          builder: (_) => CategoryDetailScreen(
              categoryName: typedArgs.categoryName,
              imagePath: typedArgs.imagePath,
              numberOfCategories: typedArgs.numberOfCategories,
              selectedCategory: typedArgs.selectedCategory,
              gradient: typedArgs.gradient),
          settings: settings,
        );
      case Router.findFriendsScreen:
        return CupertinoPageRoute<dynamic>(
          builder: (_) => FindFriendsScreen(),
          settings: settings,
        );
      case Router.settingsScreen:
        return CupertinoPageRoute<dynamic>(
          builder: (_) => SettingsScreen(),
          settings: settings,
        );
      case Router.changePasswordScreen:
        return CupertinoPageRoute<dynamic>(
          builder: (_) => ChangePasswordScreen(),
          settings: settings,
        );
      case Router.changeLanguageScreen:
        return CupertinoPageRoute<dynamic>(
          builder: (_) => ChangeLanguageScreen(),
          settings: settings,
        );
      case Router.editProfileScreen:
        return CupertinoPageRoute<dynamic>(
          builder: (_) => EditProfileScreen(),
          settings: settings,
        );
      case Router.newReviewScreen:
        return CupertinoPageRoute<dynamic>(
          builder: (_) => NewReviewScreen(),
          settings: settings,
        );
      default:
        return unknownRoutePage(settings.name);
    }
  }
}

//**************************************************************************
// Arguments holder classes
//***************************************************************************

//CategoryDetailScreen arguments holder class
class CategoryDetailScreenArguments {
  final String categoryName;
  final String imagePath;
  final int numberOfCategories;
  final int selectedCategory;
  final Gradient gradient;
  CategoryDetailScreenArguments(
      {@required this.categoryName,
      @required this.imagePath,
      @required this.numberOfCategories,
      @required this.selectedCategory,
      @required this.gradient});
}
